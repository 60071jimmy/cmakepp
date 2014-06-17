# returns the the unique elements of list A without the elements of listB
function(list_difference __list_difference_lstA __list_difference_listB)
  if(NOT __list_difference_lstA)
    return()
  endif()
  if(NOT "${__list_difference_lstA}")
    return()
  endif()
  list(REMOVE_DUPLICATES ${__list_difference_lstA})
  foreach(__list_operation_item ${${__list_difference_listB}})
    list(REMOVE_ITEM ${__list_difference_lstA} ${__list_operation_item})
  endforeach()
  return_ref(${__list_difference_lstA})
endfunction()