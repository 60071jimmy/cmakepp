
  # input:
  # {
  #  <path:<executable>>, // path to executable or executable name -> shoudl be renamed to command
  #  <args:<arg ...>>,        // command line arguments to executable, use string_semicolon_encode() on an argument if you want to pass an argument with semicolons
  #  <?timeout:<seconds>],            // timout
  #  <?cwd:<unqualified path>>,                // current working dir (default is whatever pwd returns)
  #
  # }
  # returns:
  # {
  #   path: ...,
  #   args: ...,
  #   <timeout:<seconds>> ...,
  #   <cwd:<qualified path>> ...,
  #   output: <string>,   // all output of the process (stderr, and stdout)
  #   result: <int>       // return code of the process (normally 0 indicates success)
  # }
  #
  #
  function(execute processStart)
    process_start_info("${processStart}")
    ans(processStart)

    #obj("${processStart}")
  
    map_clone_deep(${processStart})
    ans(processResult)

    scope_import_map(${processStart})

    set(timeout TIMEOUT ${timeout})
    set(cwd WORKING_DIRECTORY "${cwd}")


    

    set(execute_process_command "
        execute_process(
          COMMAND \"\${command}\" ${arg_string}
          \${timeout}
          \${cwd}
          RESULT_VARIABLE result
          OUTPUT_VARIABLE output
          ERROR_VARIABLE output
        )

        map_set(\${processResult} output \"\${output}\")
        map_set(\${processResult} stdout \"\${output}\")
        map_set(\${processResult} result \"\${result}\")
        map_set(\${processResult} error \"\${result}\")
        map_set(\${processResult} return_code \"\${result}\")
    ")


     
    eval("${execute_process_command}")


    if(OOCMAKE_DEBUG_EXECUTE)
      json_print(${processResult})
    endif()

    return(${processResult})
  endfunction()