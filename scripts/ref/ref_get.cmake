function(ref_get result ref)
	#local ref
	set(ref_value)
	get_property(ref_value GLOBAL PROPERTY "${ref}")
	set(${result} ${ref_value} PARENT_SCOPE)
	#message("getting Ref  '${result}'' '${${result}}'' ${res}")
endfunction()