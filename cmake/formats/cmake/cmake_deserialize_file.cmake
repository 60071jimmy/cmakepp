function(cmake_deserialize_file file)
  if(NOT EXISTS "${file}")
    return()
  endif()
   ref_new()
   ans(result)
   include("${file}")
   ref_get(${result})
   return_ans()
endfunction()