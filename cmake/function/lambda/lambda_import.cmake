function(lambda2_tryimport callable)
  if("${callable}" MATCHES "^\\[[a-zA-Z0-9_ ]*]*\\]\\([[a-zA-Z0-9_ ]*\\)")
    lambda2_instanciate("${callable}" ${ARGN})
    ans(res)
    return_ref(res)
  endif()
  return()
endfunction()