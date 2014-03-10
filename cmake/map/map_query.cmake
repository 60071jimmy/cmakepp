# query a a list of maps with linq like syntax
# ie  from package in packages where package.id STREQUAL package1 AND package.version VERSION_GREATER 1.3
# packages is a list of maps and package is the name for a single pakcage used in the where clause
# 
function(map_where result query)
	set(regex "from (.*) in (.*) where (.*)")
	string(REGEX REPLACE "${regex}" "\\1" ref "${query}")
	string(REGEX REPLACE "${regex}" "\\2" source "${query}")
	string(REGEX REPLACE "${regex}" "\\3" where "${query}")
	string_split(where_parts "${where}" " ")

	set(res)
	foreach(${ref} ${${source}})
		string(REGEX MATCHALL "${ref}[^ ]*" references "${where}")
		set(current_where ${where_parts})
		foreach(reference ${references})
			map_navigate(val "${reference}")
			string(REPLACE ";${reference};" ";${val};" current_where ";${current_where}")
		endforeach()
		if(${current_where})
			set(res ${res} ${${ref}})
		endif()
	endforeach()	 

	set(${result} ${res} PARENT_SCOPE)
endfunction()