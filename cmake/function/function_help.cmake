function(function_help result func)
	function_lines_get( "${func}")
	ans(res)
	set(res)
	foreach(line ${res})
		string(STRIP "${line}" line)
		if(line)
			string(SUBSTRING "${line}" 0 1 first_char)
			if(NOT ${first_char} STREQUAL "#")
				if(res)
					set(res "${res}\n")
				endif()
				set(res "${res}${line}")
			else()
				break()
			endif()
		endif()
	endforeach()
	return_value("${res}")
endfunction()