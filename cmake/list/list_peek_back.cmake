
function(list_peek_back  __list_peek_back_lst)
  if("${__list_peek_back_lst}_" STREQUAL "_")
    return()
  endif()
  list(LENGTH ${__list_peek_back_lst} len)
  math(EXPR len "${len} - 1")
  list(GET ${__list_peek_back_lst} "${len}" res)
  return_ref(res)
endfunction()