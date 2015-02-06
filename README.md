![cmakepp logo](https://raw.githubusercontent.com/toeb/cmakepp/master/logo.png "cmakepp logo")

## A CMake Enhancement Suite
[![Travis branch](https://img.shields.io/travis/toeb/cmakepp/master.svg)](https://travis-ci.org/toeb/cmakepp)
[![GitHub stars](https://img.shields.io/github/stars/toeb/cmakepp.svg?)](https://github.com/toeb/cmakepp/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/toeb/cmakepp.svg)](https://github.com/toeb/cmakepp/network)
[![GitHub issues](https://img.shields.io/github/issues/toeb/cmakepp.svg)](https://github.com/toeb/cmakepp/issues) 
[![Build Status](https://webapi.biicode.com/v1/badges/toeb/toeb/cmakepp/master)](https://www.biicode.com/toeb/cmakepp)
[![Project Stats](https://www.ohloh.net/p/cmakepp/widgets/project_thin_badge.gif)](https://www.ohloh.net/p/cmakepp)

# Installing

You have multiple options for install `cmakepp` the only prerequisite for all options is that cmake is installed with version `>=2.8.7`. 


* [Install by Console](#install_console) - Recommended
* Use the [Biicode Block](https://www.biicode.com/toeb/cmakepp)
* [Download a release](https://github.com/toeb/cmakepp/releases) and include it in your cmake script file - If you do not want to run the tests or have access to the single function files this option is for you
	- [Manually setup aliases](#install_aliases)
* Clone the repository and include `cmakepp.cmake` in your `CMakeLists.txt` (or other cmake script)

# Usage
Look through the files in the package.  Most functions will be commented and the other's usage can be inferred.  All functions are avaiable as soon as you include the cmakepp.cmake file.

# Testing
To test the code (alot is tested but not all) run the following in the root dir of cmakepp *this takes long :)*

``` 
cmake -P build/script.cmake 
```

# Feature Overview

`cmakepp` is a general purpose library for cmake.  It contains functionality that was missing in my opinion and also wraps some cmake functionality to fit to the style of this library.

* Features
	* [interactive cmake console](#icmake) (`cmake -P icmake.cmake`)
	* [lists](#lists) - common and usefull list and set operations.
		- [ranges](#ranges) range based access to lists
	* [maps](#maps) - map functions and utility functions (nested data structures for cmake)
		* graph algorithms 
		* serialization/deserialization
			* [json](#json)
			* [quickmap format](#quickmap) (native to cmake)
			* [xml](#xml)
	* [assign](#assign) universal assign ease of use for maps and functions 
	* [expression syntax](#expr).
			* `obj("{id:1,prop:{hello:3, other:[1,2,3,4]}}")` -> creates the specified object 
	* [eval](#eval) - evaluates cmake code and is the basis of many advanced features
	* [shell](#shell) - "platform independent" shell script execution
		* [aliases](#aliases) - platform independent shell aliases
		* [console](#console) - functions for console input and outputf
	* [filesystem](#filesystem) - directory and file functions with close relations to bash syntax
		* [mime types](#mimetypes) - mime type based file handling  
		* [compression/decompression](#compression) - compressing and decompressing tgz and zip files
	* [command execution](#execute) simplifying access to exectables using the shell tools.
	* [cmake tool compilation](#tooling) simple c/c++ tools for cmake
	* debugging
		* some convenience functions
		* `breakpoint()` - stops execution at specified location and allows inspection of cmake variables, execution of code (if `-DDEBUG_CMAKE` was specified in command line)
	* [version control systems](#vcs)
		* `hg()` convenience function for calling mercurial vcs
		* `git()` convenience function for calling git vcs
		* `svn()` convenience function for calling subversion vcs
		* utility methods for working with the different systems
	* [package search and retrieval](#packages) 
	* [cmake](#cmake) calling cmake from cmake.
	* [date/time](#datetime)
	  * function for getting the correct date and time on all OSs
	  * get milliseconds since epoch
	* [events](#events) allows registering event handlers and emitting events
	* [Windows Registry](#windowsregstry)
		* `reg()` shorthand for working with windows registry command line interface
		* read write manipulate registry values
		* query registry keys for values
	* [string functions](#stringfunctions) - advanced string manipulation	
	* [URIs](#uris) - Uniform Resource Identifier parsing and formatting	
	* [user data](#userdata) - persists and retrieves data for the current user (e.g. allowing cross build/ script configuration)
	* functions
		* [returning values](#return)
		* define dynamic functions (without cluttering the namespace)
		* call functions dynamically (basically allowing `${functionName}(arg1 arg2 ...)` by typing  `call(${functionName}(arg1 arg2 ...))`)
		* set a variable to the result of functions `rcall(result = somefunction())`
		* lambda functions (a shorthand syntax for defining inline functions.  `(var1,var2)-> do_somthing($var1); do_something_else($var2)` 
		* import functions (from files, from string, ...)
	* [objects](#objects) - object oriented programming with prototypical inheritance, member functions
	* [process management](#process_management) - platform independent forking, waiting, controlling separate process from cmake 
	* [Targets](#targets)
		* [access to a list of all defined targets](#target_list)
		* easier access to target properties
		* 
	* [implementation notes](#implementation_notes)


*NOTE: the list is still incomplete*


# <a href="install_console"></a> Install by Console

For ease of use I provide you with simple copy paste code for your console of choice.  These scripts download the `install.cmake` file and execute it.  This file in turn downloads `cmakepp` and adds itself to your os (creating aliases and setting a environment variable - which allow you to use [icmake](#icmake) and [cmakepp cli](#cmake_cli) from the console).

*Bash*
```
#!bin/bash
wget https://raw.github.com/toeb/cmakepp/master/install.cmake && cmake -P install.cmake && rm install.cmake
```

*Powershell*
```
((new-object net.webclient).DownloadString('https://raw.github.com/toeb/cmakepp/master/install.cmake')) |`
out-file -Encoding ascii install.cmake; `
cmake -P install.cmake; `
rm install.cmake;


```


# <a href="install_aliases"></a> Manually setting up aliases



# <a name="cmake_cli"></a>cmakepp Console Client




# <a name="icmake"></a>Interactive CMake Shell

If you want to learn try or learn cmake and `cmakepp` you can use the interactive cmake shell by launching `cmake -P icmake.cmake` which gives you a prompt with the all functions available in `cmakepp` and cmake in general.

`icmake` allows you to enter valid cmake and also a more lazily you can neglect to enter the parentheses around functions e.g. `cd my/path ` -> `cd(my/path)`

Since console interaction is complicated with cmake and cmake itself is not very general purpose by design the interactive cmake shell is not as user friendly as it should be.  If you input an error the shell will terminate because cmake terminates. This problem might be addressed in the future (I have an idea however not the time to implement and test it)
Example:
```
> ./icmake.sh
icmake> cd /usr/tobi
"/usr/tobi"
icmake> pwd
"/usr/tobi"
icmake> @echo off
echo is now off
icmake> pwd
icmake> message("${ANS}")
/usr/tobi
icmake> @echo on
echo is now on
icmake> function(myfunc name)\  # <-- backslash allows multiline input
	        message("hello ${name}") \
	        obj("{name: $name}")\
	        ans(person)\
	        return(${person})\
        endfunction()
"/usr/tobi"                 # <-- the last output of any function is always repeated. 
icmake> myfunc Tobi
hello Tobi  				# <-- output in function using message
{"name":"Tobi"} 			# <-- json serialized return value of function
icmake> quit
icmake is quitting
> 
```


# Formalisms 

This section is incomplete and currently the functions described below do not all adhere to the formalisms. This will be adressed soon(ish)

To describe cmake functions I use formalisms which I found most useful they should be intuitively understandable but here I want to describe them in detail.



* `@` denotes character data
* `<string> ::= "\""@"\""` denotes a string literal
* `<regex> ::= /<string>/` denotes a regular expression (as cmake defines it)
* `<identifier> ::= /[a-zA-Z0-9_-]+/` denotes a identifier which can be used for definitions
* `<datatype> ::= "<" "any"|"bool"|"number"|""|"void"|""|<structured data> <?"...">">"` denotes a datatype the elipses denotes that multiple values in array form are described else the datatype can be `any`, `bool`, `number`, `<structured data>` etc.. 
* `<named definition> ::= "<"<identifier>">"`
* `<definition> ::= "<"<?"?"><identifier>|<identifier>":"<datatype>|<datatype>>">"`  denotes a possibly name piece of data. this is used in signatures and object descriptions e.g. `generate_greeting(<firstname:<string>> <?lastname:<string>>):<string>` specifies a function which which takes a required parameter called `first_name` which is of type `string` and an optional parameter called `lastname` which is of type `string` and returns a `string`
* `<structured data> ::= "{"<? <named definition> ...>"}"`
* `<void>` primitve which stand for nothing
* `<falseish>:"false"|""|"no"` cmake's false values (list incomplete)
* `<trueish>: !<falseish>`
* `<bool> ::= "true":"false"` indicates a well defined true or false value
* `<boolish> ::= <trueish>|<falsish>|<bool>`
* `<any> ::= <string>|<number>|<structured data>|<bool>|<void>`
* `<named function parameter>`
* `<function parameter> ::= <definition>|<named function parameter>`
* `<function definition> `
* ... @todo


# <a name="return"></a>Returning values

**Related Functions**

* `return(...)` overwritten CMake function accepting arguments which are returned
* `ans(<var>)` a shorthand for getting the result of a function call and storing it in var
* `clr([PARENT_SCOPE])` clears the `__ans` variable in current scope or in PARENT_SCOPE if flag is set.  

A CMake function can return values by accessing it's parent scope.  Normally one does the following to return a value
```
	function(myfunc result)
		set(${result} "return value" PARENT_SCOPE)
	endfunction()
	myfunc(res)
	assert(${res} STREQUAL "return value")
```
This type of programming causes problems when nesting functions as one has to return every return value that a nested function returns. Doing this automatically would cause alot of overhead as the whole scope would have to be parsed to see which values are new after a  function call.

A cleaner alternative known from many programming languages is using a return value. I propose and have implemented the following pattern to work around the missing function return values of cmake. 

```
	function(myfunc)
		return("return_value")
	endfunction()
	myfunc()
	ans(res)
	# the __ans var is used as a register
	assert(${__ans} STREQUAL "return value")
	assert(${res} STREQUAL "return value")
```

This is possible by overwriting CMakes default return() function with a macro. It accepts variables and  will call `set(__ans ${ARGN} PARENT_SCOPE)` so after the call to `myfunc()` the scope will contain the variable `__ans`. using the `ans(<var>)` function is a shorthand for `set(<var> ${__ans})`.  

### Caveats

* The returnvalue should immediately be consumed after the call to `myfunc` because it might be reused again somewhere else.
* functions which do  not call return will not set  `__ans` in their parent scope.  If it is unclear weather a function really sets `__ans` you may want to clear it before the function call using `clr()` 
* the overwrite for `return` has to be a macro, else accessing the `PARAENT_SCOPE` would be unfeasible. However macros caus the passed arguments to be re-evaluated which destroys some string - string containing escaped variables or  other escaped characters.  This is often a problem - therfore I have als added the `return_ref` function which accepts a variable name that is then returned. 

### Alternatives
* a stack machine would also be a possiblity as this would allow returning multiple values. I have decided using the simpler single return value appoach as it is possible to return a structured list or a map if multiple return values are needed.
 
# Refs

CMake has a couple of scopes every file has its own scope, every function has its own scope and you can only have write access to your `PARENT_SCOPE`.  So I searched for  simpler way to pass data throughout all scopes.  My solution is to use CMake's `get_property` and `set_property` functions.  They allow me to store and retrieve data in the `GLOBAL` scope - which is unique per execution of CMake. It is my RAM for cmake - It is cleared after the programm shuts down.

I wrapped the get_property and set_property commands in these shorter and simple functions:

```
ref_new() 	# returns a unique refernce (you can also choose any string)
ref_set(ref [args ...]) # sets the reference to the list of arguments
ref_get(ref) # returns the data stored in <ref> 

# some more specialized functions
# which might be faster in special cases
ref_setnew([args ...]) 		# creates, returns a <ref> which is set to <args>
ref_print(<ref>)			# prints the ref
ref_isvalid(<ref>)			# returns true iff the ref is valid
ref_istype(<ref> <type>)	# returns true iff ref is type
ref_gettype(<ref>)			# returns the (if any) of the ref				
ref_delete(<ref>)			# later: frees the specified ref
ref_append(<ref> [args ...])# appends the specified args to the <ref>'s value
ref_append_string(<ref> <string>) # appends <string> to <ref>'s value
```

*Example*:
```
 # create a ref
 ref_new()
 ans(ref)
 assert(ref)
 
 # set the value of a ref
 ref_set(${ref} "hello world")

# retrieve a value by dereferencing
ref_get(${ref})
ans(val)
assert(${val} STREQUAL "hello world")

# without generating the ref:  
ref_set("my_ref_name" "hello world")
ref_get("my_ref_name")
ans(val)
assert(${val} STREQUAL "hello world")
```


# <a name="maps"></a> Maps

Maps are very versatile and are missing dearly from CMake in my opinion. Maps are references as is standard in many languages. They are signified by having properties which are adressed by keys and can take any value.

Due to the "variable variable" system (ie names of variables are string which can be generated from other variables) it is very easy to implement the map system. Under the hood a value is mapped by calling `ref_set(${map}.${key})`.  


## Functions and Datatypes
Using refs it easy to implement a map datastructure:
```
map_new()					# returns a unique reference to a map
map_get(map key)			# returns the value of map[key], fails hard if key does not exist
map_has(map key)			# returns true iff map[key] was set
map_set(map key [arg ...])	# sets map[key]
map_keys(map)				# returns all keys which were set
map_tryget(map key)			# returns the stored value or nothing: ""
map_sethidden(map key)	 	# sets a field in the map without adding the key to the keys collection
map_remove()

# some specialized functions
map_append()
map_append_string()

```

* `mm(<structured data~>):<map>` creates a map from any kind of structured data

## Map Iterators

For a more intuitive way to work with maps I developed a `map_iterator` which which allows forward iteration of all maps. The syntax is held simple so that you can quickly go through a map as you can see in the following example:

### Example 

*Iterate through a maps's key/value pairs and prints them*

```
mm(mymap = "{a:1,b:2,c:3}")
map_iterator(${mymap})
ans(it)
while(true)
	map_iterator_break(it)
	# you have access to ${it.key} and ${it.value}
	message("${it.key} = ${it.value}")
endwhile()
```
*output*
```
a = 1
b = 2
c = 3
```

### Functions and Datatypes

* `<map iterator> ::= *internal data*` contains data which the iterator functions use.
* `<map iterator ref> ::= <iterator&>` a variable which contains an iterator
* `map_iterator(<map>): <map iterator>` creates a map iterator for the specied map
* `map_iterator_next(<iterator ref>):<bool>` returns true if the iterator could be advanced to the next key, also sets the variables `<iterator ref>.key` and `<iterator ref>.value` in the current scope
* `map_iterator_current(<iterator ref>):<value>` also sets `<iterator ref>.key` and `<iterator ref>.value` 
* `map_iterator_break(<iterator>)` only usable inside a loop (normally a while loop) it calls `break()` when the iterator has ended also sets `<iterator ref>.key` and `<iterator ref>.value` 

##  <a href="assign"></a> Easy map handling with `assign()`

Using the map and list functions can be cumbersome. Therefore I have added a universal function called `assign()` It allows you to use statements known from other programming languages. 

The easiest way to illustrate the usefullness is by example:

*Examples*

```
## assign the string value 3 to x  - single quotes indicate a value
assign(x = '3') 
assert("${x}" EQUAL 3)

## assign a string containing spaces to x
assign(x = "'hello there!'") 
assert("${x}" STREQUAL "hello there!" )

## assign a literal to x - simplification of the above
assign(x "hello world" "how are you") # notice missing '='
assert("${x}" EQUALS "hello world" "how are you")

## assign the result of a function call to x
assign(x = string_length("abcde"))
assert("${x}" EQUAL 5)

## assign x the result of an expression
assign(x = "{id:1}")  # the strign {id:1} is parsed into a map
assertf("{x.id}" EQUAL 1)

## append a value to x
set(x)
assign(x[] = '1')
assign(x[] = '2')
assign(x[] = '3')
assign(x[] = '4')
assert(${x} EQUALS 1 2 3 4)

## reverse x
set(x 1 2 3 4)
assign(x = x[$:0:-1]) # read assign x at end to 0 in -1 increments to x
assert(${x} EQUALS 4 3 2 1)

## replace a range of x
set(x 1 2 3 4)
assign(x[1:2] = '5')
assert(${x} EQUALS 1 5 4)

## create a object path if it does not exist by prepending '!'
set(x)
assign(!x.y.z = '3')
assert_matches("{y:{z:3}}" "${x}")

...

```


## <a href="xml"></a> Naive Xml Deserialization

Xml Deserialization is a complex subject in CMake.  I have currently implemented a single naive implementation based on regular expressions which *does not* allow recursive nodes (ie nodes with the same tag being child of one another).



### Functions

* `xml_node(<name> <value> <attributes:object>)->{ tag:<name>, value:<value>, attrs:{<key>:<value>}}`  creates a naive xml node representation.
* `xml_parse_nodes(<xml:string> <tag:string>)-> list of xml_nodes`  this function looks for the specified tag in the string (matching every instance(no recursive tags)) it parses the found nodes attributes and value (innerXml). You can then use `nav()`, `map_get()` etc functions to parse the nodes




## <a name="json"></a>Json Serialziation and Deserialization

I have written five functions which you can use to serialize and deserialize json.  

### Functions

* `json(<map>)` 
    - transforms the specified object graph to condensed json (no superfluos whitespace)
    - cycles are detected but not handled. (the property will not be set if it would cause a cycle e.g. map with a self reference would be serialized to `{"selfref":}` which is incorrect json... which will be addressed in the future )  
    - unicode is not transformed into `\uxxxx` because of lacking unicode support in cmake
* `json_indented(<map>)` 
    - same as `json()` however is formatted to be readable ie instead of `{"var":"val","obj":{"var":["arr","ay"]}}` it will be 
```
{
	"var":"var",
	"obj":[
		"arr",
		"ay"
	]
}
```
* `json_deserialize(<json_string>)`
	- deserialized a json string ignoring any unicode escapes (`\uxxxx`)
* `json_read(<file>)`
	- directly deserializes af json file into a map
* `json_write(<file> <map>)`
	- write the map to the file

### Caveats
As can be seen in the functions' descriptions unicode is not support. Also you should probably avoid cycles.  

### Caching
Because deserialization is extremely slow I chose to cache the results of deserialization. So the first time you deserialize something large it might take long however the next time it will be fast (if it hasn't changed).
This is done by creating a hash from the input string and using it as a cache key. The cache is file based using Quick Map Syntax (which is alot faster to parse since it only has to be included by cmake).  

## <a name="quickmap"></a>Quick Map Syntax
To quickly define a map in cmake I introduce the quick map syntax which revolves around these 5 functions and is quite intuitive to understand:
```
map([key]) # creates, returns a new map (and parent map at <key> to the new map) 
key(<key>)	# sets the current key
val([arg ...])	# sets the value at current map[current key] to <args>
kv(<key> [arg ...]) # same as writing key(<key>) LF val([arg ...]) 
end() # finishes the current map and returns it
```

*Example* 
Here is an example how to use this syntax
```
# define the map
map()
 key(firstname)
 value(Tobias)
 key(lastname)
 value(Becker)
 value(projects)
 	map()
 		kv(name cmakepp)
 		kv(url https://github.org/toeb/cmakepp)
 	end()
 	map()
 		key(name)
 		value(cutil)
 		key(url)
 		value(https://github.org/toeb/cutil)
 	end()
 end()
 map(address)
 	key(street)
 	value(Musterstrasse)
 	key(number)
 	value(99)
 end()
end()
# get the result
ans(themap)
# print the result
ref_print(${themap})
```

*Output* 
```
{
	"firstname":"Tobias",
	"lastname":"Becker",
	"projects":[
		{
			"name":"cmakepp",
			"url":"https://github.org/toeb/cmakepp"
		},
		{
			"name":"cutil",
			"url":"https://github.org/toeb/cutil"
		}
	]
	"address":{
		"street":"Musterstrasse",
		"number":"99"
	}
}

```


# Functions

CMake is a function oriented language. Every line in a cmake script is a function just a function call. It is the only available statement.  CMake does not allow dynamic function calling (ie calling a function which you first know at runtime). This has problem and some further funcitonality issues are addressed in this section.

Functions in cmake are not variables - they have a separate global only scope in which they are defined.  
*A Note on Macros* Macros are also functions.  They do not have their own scope and evaluate arguments differently. They will more likely than not have unintended side effects because of the way the are evaluated. There are valid reasons to use macros but if you do not know them, you SHOULD NOT use macros...

## Functions and Datatypes

* Datatypes
	* `<cmake code> ::= <string>` any valid cmake code
	* `<cmake function file> ::= <cmake file>` a cmake script file containing a single function 
	* `<function string> :: <cmake code>` a string containing a single function
	* `<cmake file> ::= <path>` a file containing valid cmake code
	* `<function call> ::=<function?!>(<any...>)` a function call can be evaluated to a valid cmake code line which executes the function specified
	* `<function>` ::= <identifier>` any cmake function or macro name for which `if(COMMAND <function>)` evaluates to true.  This can be directly called
	* `<function?!>` ::= <function>|<cmake function file>|<lambda>|<function&>|<function string>|<function string&>  a function?! can be any type of code which somehow evaluates to a function
	* `<function info> ::= {type:<function type>, name:<identifier>, args:<arg ...>, code:<function string>|<function call>}` a map containing information on a specific function. if possible the info map contains the original source code of the function
* Functions
	* `eval(<cmake code>)` executes the given cmake code. If the code returns something (see return) the result will be available after the `eval()` call using `ans()`
	* `eval_ref(<cmake code&>)` executes the given code.  Since this is a macro the code is passed as a variable name (reference) to suppress automatic variable expansion. This allows you to eval code which uses the `set(x y PARENT_SCOPE)` 
	* `function_new()`	returns a unqiue name for a function.  
	* `is_function(<value:any>):<bool>` returns true if the specified value is a function
	* `function_import(<cmake function?!> as <function_name:<identifier>>)` imports a function under the specified name 
	* `call(<function call>)` calls a function and returns the return value of the call.
	* `rcall(<identifier> = <function call>)` calls a function and sets the specified identifier to the return value of the call.
	* `function_info(<function?!>):<function info>`	returns info on name, arguments, type of function
	* `wrap_platform_specific_function(<function_name:<identifier>>` a helper method which allows platform the correct choice for platform specific functions. Consider getting an environment variable like the home directory.  Under Linux this is `$ENV{HOME}` under Windows this is `$ENV{HOME_DRIVE}$ENV{HOME_DIR}` depending on the os the result is 'the same' but you get it is different.  this function looks for specialized functions and imports the most fitting one as `<function_name>`.  If no function is found which matches the platform a dummy function is implemented which throws a `FATAL_ERROR` detailing how you can alleviate the missing implementation problem. 
	* `curry`
	* `bind`
	* Lambdas
		* `<lambda code>`  string of code similar to cmake.  a typical lambda looks like this `(a)-> return_truth($a STREQUAL "hello")`
		* `lambda(<lambda code>):<function string>`
		* `lambda_import(<lambda code>)`
		* `lambda_parse()`


## Examples

```
```


# <a name="objects"></a>Objects 

Objects are an extension of the maps. They add inheritance, member calls and custom member operations to the concept of maps. I split up maps and objects because objects are a lot slower (something like 2x-3x slower) and if you do not need objects you should not use them (handling 1000s of maps is already slow enough). The reason for the performance loss is the number of function calls needed to get the correct virtual function/property value.


## Functions and Datatypes

These are the basic functions which are available (there are more which all use these basic ones): 

* Basic Object functions - Functions on which all other object functions base
	- `<type> := <cmake function>` a type is represented by a globally unique cmake function.  This function acts as the constructor for the type. In this constructor you define inheritance, properties and member functions. The type may only be defined once.  So make sure the function name is and stays unique ie. is not overwritten somewhere else in the code.
	- `<object> := <ref>` an object is the instance of a type. 
	- `<member> := <key>` a string which identifies the member of an object
	- `obj_new(<type>):<object>` creates the instance of a type. calls the constructor function specified by type and returns an object instance
	- `obj_delete(<object>):<void>` deletes an object instance. You MAY call this. If you do the desctructor of an object is invoked. This function is defined for completeness sake and can only be implemented if CMake script changes. So don't worry about this ;).
	- `obj_set(<object> <member> <value:<any...>>):<any>`  sets the object's  property identified by `<member>` to the specified value.  *the default behaviour can be seen in `obj_default_setter(...)` and MAY be overwridden by using `obj_declare_setter(...)`*
	- `obj_get(<object> <member>):<any>` gets the value of the object's property identified by `<member>` *the default behaviour MAY be overwridden b using `obj_declare_getter`*  
	- `obj_has(<object> <member>):<bool>` returns true iff the object has a property called `<member>`
	- `obj_keys(<object>):<member...>` returns the list of available members
	- `obj_member_call(<object> <member> <args:<any...>>):<any>` calls the specified member with the specified arguments and returns the result of the operation
* Most `obj_*` functions are also available in the shorter `this-form` so `obj_get(<this:<object>> ...)` can also be used inside a member function or constructor by using the function `this_get(...)`.  This is achieved by forwarding the call from `this_get(...)` to `obj_get(${this} ...)`

## Overriding default behaviour

As is possible in JavaScript an Python I let you override default object operations by specifying custom member functions. You may set the following hidden object fields to the name of a function which implements the correct interface. You can see the default implementations by looking at the `obj_default_*` functions.  To ensure ease of use I provided functions which help you correctly override object behaviour.  

* reserved hidden object fields
	* `__setter__ : (<this> <member> <any...>):<any>` override the set operation. Return value may be anything. the default is void
	* `__getter__ : (<this> <member>):<any>` override the get operation. expects the return value to be the value of the object's property identified by `<member>`
	* `__get_keys__ : (<this>):<member ...>` override the operation which returns the list of available keys.  It is expected that all keys returned will are valid properties (they exist).
	* `__has__ : (<this> <member>):<bool>` overrides the has operation. MUST return true iff the object has a property called `<member>`
	* `__member_call__ : (<this> <member> <args:<any...>>):<return value:<any>>` this operation is invoked when `obj_member_call(...)` is called (and thus also when `call, rcall, etc` is called) overriding this function allows you to dispatch a call operation to the object member identified by `<member>` with the specified `args` it should return the result of the specified operation. The `this` variable is always set to the object instance current instance.
	* `__cast__` @todo
* helper functions
	* `obj_declare_getter()`
	* `obj_declare_setter()`
	* `obj_declare_call()`
	* `obj_declare_member_call()`  
	* `obj_declare_get_keys()`
	* `obj_declare_has_key()` @todo
	* `obj_declare_cast()` @todo
	

```
new([Constructor]) returns a ref to a object
obj_get(obj)
obj_set(obj)
obj_has(obj)
obj_owns(obj)
obj_keys(obj)
obj_ownedkeys(obj)
obj_call(obj)
obj_member_call(obj key [args])
obj_delete(obj)
```



## Example

This is how you define prototypes and instanciate objects.  

The syntax seems a bit strange and could be made much easier with a minor change to CMake... Go Cmake Gods give me true macro power! (allow to define a macro which can call function() and another which contains endfunction()) /Rant



```
function(BaseType)
	# initialize a field
	this_set(accu 0)
	# declare a functions which adds a value to the accumulator of this object
	proto_declarefunction(accuAdd)
	function(${accuAdd} b)
		this_get(accu)
		math_eval("${accu} + ${b}")
		ans(accu)
		this_set(accu "${accu}")
		call(this.printAccu())
		return(${accu})
	endfunction()

	proto_declarefunction(printAccu)
	function(${printAccu})
		this_get(accu)
		message("value of accu: ${accu}")
	endfunction()
endfunction()
function(MyType)
	# inherit another type
	this_inherit(BaseType)
 	# create a subtract from accu function
 	proto_declarefunction(accuSub)
 	function(${accuSub} b)
 		this_get(accu)
 		math_eval("${accu} - ${b}")
		this_set(accu "${accu}")
		call(this.printAccu())
		return(${accu})
 	endfunction()

endfunction()

new(MyType)
ans(myobj)
rcall(result = myobj.add(3))
# result == 3, output 3
rcall(result = myobj.sub(2))
# result == 1, output 1
```

## Special hidden Fields
```
__type__		# contains the name of the constructor function
__proto__		# contains the prototype for this object
__getter__ 		# contains a function (obj, key)-> value 
__setter__		# contains a function (obj, key,value) 
__call__		# contains a function (obj [arg ...])
__callmember__	# contains a function (obj key [arg ..])
__not_found__ 	# gets called by the default __getter__ when a field is not found
__to_string__	# contains a function which returns a string representation for the object
__destruct__	# a function that is called when the object is destroyed
```


# <a name="semver"></a>Parsing and handling semantic versions


A `semantic version` gives a specific meaning to it components. It allows software engineers to quickly determine weather versioned components of their software can be updated or if breaking changes could occur.  

On [semver.org](http://semver.org/) Tom Preston-Werner defines Semantic Versioning 2.0.0 which is recapped in the following.

A `semantic version` is defined by is a version string which is in the following format whose components have a special semantic meaning in regard to the versioned subject:
```
<version number> ::= (0|[1-9][0-9]*)
<version tag> ::= [a-zA-Z0-9-]+
<major> ::= <version number>
<minor> ::= <version number>
<patch> ::= <version number>
<prerelease> ::= <version tag>[.<version tag>]*
<metadata> ::= <version tag>[.<version tag>]*
<semantic_version> ::= <major>.<minor>.<patch>[-<prerelease>][+<metadata>]

```
## Examples

* `1.3.42-alpha.0+build-4902.nightly`
* `4.2.1`
* `0.0.0`

## Description

A `version number` may be any `0` or any positive integer. It may not have leading `0`s. 

`major` is a `version number`.

A `version tag` non-empty alphanumeric string (also allowed: hyphen `-`)

`prerelease` is a period `.` separated list of a `version tag`s. A version with `prerelease` is always of a lower order than a the same version without `prerelease`. 

`<metadata>` is a list of period `.` separated `version tag`s with no meaning to the `semantic version`. It can be considered as user data.

## Semantics

`major` is a `version number`.  `0` signifies that the public interface (API) of a package is not yet defined. The first major version `1` defines the public interface for a package. If the `major` version changes backwards incompatible changes have occured.

`minor` is a `version number` which signifies a backwards compatible change in the public interface of a package.  Updating a package to a new minor version MAY NOT break the dependee.

`patch` is a `version number`  which signifies a change in the internals of a package. ie bugfixes, inner enhancements. 

A `version number` SHOULD be incremented by `1` and `version number` the lower `version number`s are reset to zero. Incrementing a version with prerelease has to be done manually e.g.

* increment `major` `1.23.1` => `2.0.0` 
* increment `minor` `1.23.1` => `1.24.0`
* increment `patch` `1.23.1` => `1.23.2`

## Semantic Version Object

The sematic version object is the following map:

```
{
    "string":"<major>.<minor>.<patch>-<prerelease>+<metadata>"
    "numbers":"<major>.<minor>.<patch>",
    "major":"<major>",
    "minor":"<minor>",
    "patch":"<patch>",
    "prerelease":"<prerelease>",
    "metadata":"<metadata>",
    "tags":[
        <version tag>,
        <version tag>,
        ...
    ],
    "metadatas":[
        <version tag>,
        <version tag>,
        ...
    ]

}
```
## Constraining Versions

A `version constraint` constrains the set of all version to a subset.

```
<version operator> ::= >=|<=|>|<|=|~|! 
<version constraint> ::= <version constraint>"|"<version constraint> 
<version constraint> ::= <version constraint>","<version constraint>
<version constraint> ::= <version operator><lazy version>
```

* `<version constraint> ::= <- <package_version_constraint> , <package_version_constring>` can be AND combined. `,` is the and operator and it has precedence before 
* `<package_version_constraint> <- <package_version_constraint> | <package_version_constring>`: `<package_version_constraint>`s can be or combined
* `<package_version_constraint_operator><package_version>`
* `<package_version_constraint_operator><lazy_version>`
* `<package_version>` -> `~<package_version>`
* `<lazy_version>`
* `<lazy_version>` is a `<package_version>` which may  miss elements. These elements are ie `1` would correspond to `1.0.0`
* a `<package_version_constraint_operator>` can be one of the following
    - `=` `<package_version>`  equals the specified version exactly
    - `<` `<package_version>` is less up to date then specified version
    - `>` `<package_version>` is greater than specified version
    - `>=` `<package_version>` is greater or equal to specified version evaluates to `><package_version> | =<package_version>`
    - `<=` `package_version` is less or equal than specified version evaluates to `<<package_version> | =<package_version>`
    - `~` 





## Lazy Version

A `lazy version` a less strict formulation of a `sematic version` 
```
<lazy version> ::= [whitespace]<<sematic_version>|v<lazy_version>|<major>|<major>.<minor>|"">[whitespace]
```

A lazy version allows whitesspace and omission of `minor` and `patch` numbers. It also allows a preceding `v` as is common in many versioning schemes.

A `lazy version` can be normalized to a strict `semantic version` by removing any whitespace around and in the version as well as the leading `v`, and filling up missing `major` and `minor` and `patch` version components with `0`. Normalizing an empty (or pure whitespace) string results in version `0.0.0`

*Examples*
* `v1.3` => `1.3.0`
* `v1-alpha` => `1.0.0-alpha`
* `v1.3-alpha` => `1.3.0-alpha`
* `1` => `1.0.0`
* `  1    ` => `1.0.0`
* `     `=> `0.0.0`
* 
## Functions

The following functions are usable for semantic versioning.

* `semver(<lazy_version>)` parses a string or a semantic version object and returns a `<semantic version object>`
	- `semver(1.0)` => `{major:1,minor:0,patch:0}`
	- `semver(2-alpha+build3.linux)` => `{major:2,minor:0,patch:0,prerelease:['alpha'],metadata:['build3','linux']}`
	- `semver(2.3.1-beta.3+tobi.katha)` => `{major:2,minor:3,patch:1,prerelease:['beta','3'],metadata:['tobi','katha']}`
* `semver_compare(<lhs:semverish> <rhs:semverish>)` compares two semantiv versions.
	- returns `-1` if left is more up to date
	- returns `1` if right is more up to date
	- returns `0` if they are the same
* `semver_higher(<lhs:semverish> <rhs:semverish>)` returns the semantic version which is higher.
* `semver_gt(<lhs:semverish> <rhs:semverish>)` returns true iff left semver is greater than right semver
* `semver_cosntraint_evaluate(<version constraint> <lazy_version>)` returns true if `<lazy_version>` satisfies `<version cosntraint>`
	- `semver_constraint_evaluate("=0.0.1" "0.0.1")` -> true
	- `semver_constraint_evaluate("=0.0.1" "0.0.2")` -> false
  	- `semver_constraint_evaluate("!0.0.1" "0.0.1")` -> false
  	- `semver_constraint_evaluate("!0.0.1" "0.0.2")` -> true
    - `semver_constraint_evaluate(">0.0.1" "0.0.2")` -> true
  	- `semver_constraint_evaluate(">0.0.1" "0.0.1")` -> false
    - `semver_constraint_evaluate("<0.0.1" "0.0.0")` -> true
    - `semver_constraint_evaluate("<0.0.1" "0.0.1")` -> false
    - `semver_constraint_evaluate("<=3,>2" "3.0.0")` -> true
    - `semver_constraint_evaluate("<=3,>=2" "2.0.0")` -> true


## Caveats

* parsing, constraining and comparing semvers is slow. Do not use too much (you can  compile a semver constraint if it is to be evaluated agains many versions which helps a little with performance issues).  


# <a name="targets"></a> Targets

## target_list and project_list

CMake as of version 2.8.7 does not support a list of all defined targets.
Therfore I overwrote all target adding functions `add_library`, `add_executable`, `add_custom_target`, `add_test`, `install` ... which now register the name of the target globally in a list. You can access this list by using the function `target_list()` which returns the list of known target names .  Note that only targets defined before the `target_list()`  call are known.  

I did the same thing for the  `project()` command.

## target debug functions

To quickly get an overview of how your target is configured write `print_target(<target_name>)` it will print the json representation of the target as a message.

To see how were all your targetes are type `print_project_tree` which will show the json representation of all your prrojects and targets.

## target property functions

accessing target properties made easier by the following functions

* `target_get(<target> <prop-name>)` returns the value of the target property
* `target_set(<target> <prop-name> [<value> ...])` sets the value of the target property
* `target_append(<target> <prop-name> [<value> ...])` appends the values to the current value of `<prop-name>` 
* `target_has(<target> <prop-name>)->bool` returns true iff the target has a property called `<prop-name>`



# <a name="windowsregistry"></a> Windows Registry


Even though cmake and cmakepp are platform independent working with the windows registry is sometimes import/ e.g. setting environment variables. The cmake interface for manipulating registry values is not very nice (`cmake -E delete_regv` `write_regv`, `get_filename_component(result [HKEY_CURRENT_USER/Environment/Path] ABSOLUTE CACHE)` ) and hard to work with. Therefore I implemented a wrapper for the windows registry command line tool [REG](http://technet.microsoft.com/en-us/library/cc732643.aspx) and called it `reg()` it has the same call signature as `REG` with a minor difference: what is `reg add HKCU/Environment /v MyVar /f /d myval` is written `reg(add HKCU/Environment /v /MyVar /f /d myval)`. See also [wrap_executable](#executable)


## Availables Functions


Using this command I have added convinience functions for manipulating registry keys and values

* `reg()` access to REG command line tool under windows (fails on other OSs)
* `reg_write_value(key value_name value)` writes a registry value (overwrites if it exists)
* `reg_read_value(key value_name)` returns the value of a registry value
* `reg_query_values(key)` returns a map containing all values of a specific registry key
* `reg_append_value(key value_name [args...])` append the specified values to the registries value
* `reg_prepend_value(key value_name [args...])` prepends the specified values to the registries value
* `reg_append_if_not_exists(key value_name [args ...]) appends the specifeid values to the registries value if they are not already part of it, returns only the values which were appended as result
* `reg_remove_value(key value_name [args ...])` removes the specified values from the registries value
* `reg_contains_value(key value_name)` returns true iff the registry contains the specified value
* `reg_query(key)` returns a list of `<reg_entry>` objects which describe found values
* `<reg_entry>` is a object with the fields key, value_name, value, type which describes a registry entry



## Using windows registry functions example


```
set(kv HKCU/Environment testValue1)

## read/write
reg_write_value(${kv} "b;c")
reg_read_value(${kv})
ans(res)
assert(EQUALS ${res} b c)

## append
reg_append_value(${kv} "d")
reg_read_value(${kv})
ans(res)
assert(EQUALS ${res} b c d)

## prepend
reg_prepend_value(${kv} "a")
reg_read_value(${kv})
ans(res)
assert(EQUALS ${res} a b c d)


## append if not exists
reg_append_if_not_exists(${kv} b c e f)
ans(res)
assert(res)
assert(EQUALS ${res} e f)
reg_read_value(${kv})
ans(res)
assert(EQUALS ${res} a b c d e f)


## remove
reg_remove_value(${kv} b d f)
reg_read_value(${kv})
ans(res)
assert(EQUALS ${res} a c e)


## contains
reg_contains_value(${kv} e)  
ans(res)
assert(res)


## read key
reg_query_values(HKCU/Environment)
ans(res)
json_print(${res})
assert(EQUALS DEREF {res.testValue1} a c e)
```
# <a name="datetime"></a> Date/Time

I have provided you with a functions which returns a datetime object to get the current date and time on all OSs including windows. It uses file(TIMESTAMP) internally so the resolution is 1s.  It would be possible to enhance this functionality to included milliseconds however that is more system dependent and therefore a decieded against it.  

`datetime()` currently only returns the local time. extending it to return UTC would be easy but I have not yet needed it

In the future date time arithmetic might be added

## Functions

* `datetime()` returns the current date time as a `<datetime object>`
* `<datetime object>` an object containing the following fields: `yyyy` `MM` `dd` `hh` `mm` `ss`




# <a name="eval"></a> Eval

`eval()` is one of the most central functions in cmakepp.  It is the basis for many hacks an workarounds which cmakepp uses to enhance the scripting language.

`eval` is not native to cmake (native eval would greatly increase the performance of this library) 

Internally it works by writing cmake script to a file and including it

## Functions

* `eval(code)` executes the specified code. `set(x z PARENT_SCOPE)` is not however you can return a value. 

## Examples

Defining a Function and calling it

```
eval("
function(say_hello name)
	return(\"hello \${name}!\") # note: escape cmake double quotes and dolar sign in front of vars
endfunction()
")

say_hello(Tobias)
ans(res)
assert("${res}" STREQUAL "hello Tobias!")

```

dynamically calling a function

```
# three handlers
function(handler1 a)
	return("handler1 ${a}")
endfunction()
function(handler2 a)
	return("handler2 ${a}")
endfunction()
function(handler3 a)
	return("handler3 ${a}" )
endfunction()
# list of handlers
set(handlers handler1 handler2 handler3)
# intialize result
set(results)
# set input value
set(val 3)
foreach(handler ${handlers})
	# dynamically call handler
	eval("${handler}(${val})")	
	ans(res)
	# append result to list
	list(APPEND results ${res})
endforeach()
# check if list equals expected results
assert(EQUALS ${results} "handler1 3" "handler2 3" "handler3 3")
```


# <a name="events"></a> Events

Events are often usefull when working with modules. CMake of course has no need for events generally. Some of my projects (cutil/cps) needed them however. For example the package manager cps uses them to allow hooks on package install/uninstall/load events which the packages can register.


## Example


```
# create an event handler
function(my_event_handler arg)
 message("${event_name} called: ${arg}")
 return("answer1")
endfunction()

# add an event handler
event_addhandler(irrelevant_event_name my_event_handler)
# add lambda event handler
event_addhandler(irrelevant_event_name "(arg)->return($arg)")
# anything callable can be used as an event handler (even a cmake file containing a single function)

# emit event calls all registered event handlers in order
# and concatenates their return values
# side effects: prints irrelevent_event_name called: i am an argument
event_emit(irrelevant_event_name "i am an argument")
ans(result)


assert(EQUALS ${result} answer1 "i am an argument")
```

## Functions and Datatypes

* `<event id>` a globally unique identifier for an event (any name you want except `on_event` )
* `on event` a special event that gets fired on all events (mainly for debugging purposes)
* `event_addhandler(<event id> <callable>)` registers an event handler for the globally unique event identified by `<event id>` see definition for callable in [functions section](#functions)
* `event_removehandler(<event id> <callable>)` removes the specified event handler from the handler list (it is no longer invoked when event is emitted)
* `event_emit(<event id> [arg ...]) -> any[]` invokes the event identified by `<event id>` calls every handler passing along the argument list. every eventhandler's return value is concatenated and returned.  It is possible to register event handlers during call of the event itself the emit routine continues as long as their are uncalled registered event handlers but does not call them twice.
* ... (functions for dynamic events, access to all available events)

# <a name="vcs"></a> Version Control System utilities

Working with the version control system can be a crutch in CMake. Therefore I created helpers and convenience functions which allow simple usage. Consider the following CMake code which you would have to use to clone cutil's git repository

```

find_package(Git)
if(NOT GIT_FOUND)
	message(FATAL_ERROR "Git is required!")
endif()
set(cutil_base_dir "/some/path")
if(NOT IS_DIRECTORY "${cutil_base_dir}")
	if(EXISTS "${cutil_base_dir}")
		message(FATAL_ERROR "${cutil_base_dir} is a file")
	endif()
	file(MAKE_DIRECTORY "${cutil_base_dir}")
endif()
execute_process(COMMAND "${GIT_EXECUTABLE}" clone "https://github.com/toeb/cutil.git" "${cutil_base_dir}" RESULT_VARIABLE error ERROR_VARIABLE error)
if(error)
	message(FATAL_ERROR "could not clone https:// .... because "${error}")
endif()
execute_process(COMMAND "${GIT_EXECUTABLE}" submodule init WORKING_DIRECTORY "${cutil_base_dir}" RESULT_VARIABLE error)
if(error)
	message(FATAL_ERROR "could not init submodules because "${error}")
endif()
execute_process(COMMAND "${GIT_EXECUTABLE}" submodule update --recursive WORKING_DIRECTORY "${cutil_base_dir}" RESULT_VARIABLE error)
if(error)
	message(FATAL_ERROR "could not update submodules")
endif()
```

Using convenience functions this distills down to

```
# set the current directory to ${cutil_base_dir} and creates it if it does not exist
cd(${cutil_base_dir} --create) 
# automatically fails on error with error message
git(clone "http://github.com/toeb/cutil.git" .)
git(submodule init)
git(submodule update --recursive)
```

So alot of unecessary repeating code can be omitted.  

## Git

### Functions

* `git()` function for git command line client with same usage, except `git ...` -> `git(...)` (created using wrap_executable)
* `git_base_dir([<unqualified path>]) -> <qualified path>` returns the repositories base directory
* `git_dir([<unqualified path>]) -> <qualified path>` returns the repositories .git directory 
* `git_read_single_file(<repository uri> <branch|""> <repository path>) -> <content of file>` reads a file from a remote repository
* `git_remote_exists(<potential repository uri>) -> bool` returns true if the uri points to a valid git repository
* `git_remote_refs(<repository uri>) -> <remote ref>[]` returns a list of `<remote ref>` objects
* `<remote ref>` a objects containing the following fields
  * `type : HEAD | <branch name>` -> the type of ref
  * `name : <string>` -> the name of the ref 
  * `revision: <hash>` -> the revision associated with the ref
* `git_repository_name() -> <string>`  returns the name of the repository. 

## Subversion

* `svn()` function for svn command line client with same usage, except `svn ...` -> `svn(...)` (created using wrap_exetuable)
* `svn_get_revision(<uri>)` returns the revision number of the specifed `<uri>`
* `svn_info(<uri>)-><svn info>` returns an object containing the following fields
	- path: specified relative path
	- revision: revision number
	- kind
	- url: uri
	- root: repository root
	- uuid
* ...

## Mercurial

* `hg()` function for mercurial command line client with same usage except `hg ...` -> `hg(...)`
* ...




# <a name="filesystem"></a> Filesystem

I have always been a bit confused when working with cmake's file functions and the logic behind paths (sometimes they are found sometimes they are not...) For ease of use I reimplemented a own path managing system which behaves very similar to powershell and bash (see [ss64.com](http://ss64.com/bash/)) and is compatible to CMake's understanding of paths. It is based around a global path stack and path qualification. All of my functions which work with paths use this system. To better show you what I mean I created the following example:

```
# as soon as you include `cmakepp.cmake` the current directory is set to 
# "${CMAKE_SOURCE_DIR}" which is the directory from which you script file 
# is called in script mode (`cmake -P`) or the directory of the root 
# `CMakeLists.txt` file in configure and build steps.
pwd() # returns the current dir
ans(path)

assert("${path}" STREQUAL "${CMAKE_SOURCE_DIR}")


pushd("dir1" --create) # goto  ${CMAKE_SOURCE_DIR}/dir1; Create if not exists
ans(path)
assert("${path}" STREQUAL "${CMAKE_SOURCE_DIR}/dir1")

fwrite("README.md" "This is the readme file.") # creates the file README.md in dir1
assert(EXISTS "${CMAKE_SOURCE_DIR}/dir1/README.md") 


pushd(dir2 --create) # goto ${CMAKE_SOURCE_DIR}/dir1/dir2 and create it if it does not exist
fwrite("README2.md" "This is another readme file")

cd(../..) # use relative path specifiers to navigate path stack
ans(path)

assert(${path} STREQUAL "${CMAKE_SOURCE_DIR}") # up up -> we are where we started

popd() # path stack is popped. path before was ${CMAKE_SOURCE_DIR}/dir1
ans(path)

assert(${path} STREQUAL "${CMAKE_SOURCE_DIR}/dir1")


mkdir("dir3")
cd(dir3)
# current dir is now ${CMAKE_SOURCE_DIR}/dir1/dir3

# execute() uses the current pwd() as the working dir so the following
# clones the cmakepp repo into ${CMAKE_SOURCE_DIR}/dir1/dir3
git(clone https://github.com/toeb/cmakepp.git ".")


# remove all files and folders
rm(.)


popd() # pwd is now ${CMAKE_SOURCE_DIR} again and stack is empty

```


## Functions and datatypes

* `<directory> ::= <path|qualifies to an existing directory>` 
* `<file> ::= <path|qualifies to an existing file>`
* `<windows path>`  a windows path possibly with and possibly with drive name `C:\Users\Tobi\README.md`
* `<relative path>` a simple relative path '../dir2/./test.txt'
* `<home path>` a path starting with a tilde `~` which is resolved to the users home directory (under windows and posix)
* `<qualified path>` a fully qualified path depending on OS it only contains forward slashes and is cmake's `get_filename_component(result "${input} REAL_PATH)` returns. All symlinks are resolved. It is absolute
* `<unqualified path> ::= <windows path>|<relative path>|<home path>|<qualified path>` 
* `<path> ::= <unqualified path>`
* `path(<unqualified path>)-><qualified path>` qualifies a path and returns it.  if path is relative (with no drive letter under windows or no initial / on unix) it will be qualified with the current directory `pwd()`
* `pwd()-> <qualified path>` returns the top of the path stack. relative paths are relative to `pwd()`
* `cd(<unqualified> [--create]) -> <qualified path>` changes the top of the path stack.  returns the `<qualified path>` corresonding to input. if `--create` is specified the directory will be created if it does not exist. if `cd()` is navigated towards a non existing directory and `--create` is not specified it will cause a `FATAL_ERROR`
* `pushd(<unqualified path> [--create]) -> <qualified path>` works the same `cd()` except that it pushes the top of the path stack down instead of replacing it
* `popd()-><qualified path>` removes the top of the path stack and returns the new top path
* `dirs()-> <qualified path>[]` returns all paths in the path stack from bottom to top
* file functions
	- `fread(<unqualified path>)-><string>` returns the contents of the specified file
	- `lines(<unqualified path>)-><string>[]` returns the contents of the specified file in a list of lines
	- `download(<uri> [<target:unqualified path>] [--progress])` downloads the file to target, if target is an existing directory the downloaded filename will be extracted from uri else path is treated as the target filepath
	- `fappend(<unqualified path> <content:string>)->void` appends the specified content to the target file
	- `fwrite(<unqualified path> <content:string>)->void` writes the content to the target file (overwriting it)
	- `parent_dir(<unqualified path>)-><qualified path>` returns the parent directory of the specified path
	- `file_timestamp(<unqualified path>)-><timestampstring>` returns the timestamp string for the specified path yyyy-MM-ddThh:mm:ss
	- `ls([<unqualified path>])-><qualified path>[]` returns files and subfolders of specified path
	- `mkdir(<unqualified path>)-><qualfied path>` creates the specified dir and returns its qualified path
	- `mkdirs(<unqualified path>...)-><qualified path>[]` creates all of the directories specified
	- `mktemp([<unqualified path>])-><qualified path>` creates a temporary directory optionally you can specify where this directory is created (by default it is created in TMP_DIR)
	- `mv(<sourcefile> <targetfile>|[<sourcefile> ...] <existing targetdir>)->void` moves the specifeid path to the specified target if last argument is an existing directory all previous files will be moved there else only two arguments are allowed
	- `paths([<unqualified path> ...])-><qualified path>[]` returns the qualified path for every unqualified path received as input
	- `touch(<unqualified path> [--nocreate])-><qualified path>` touches the specified file creating it if it does not exist. if `--nocreate` is specified the file will not be created if it does not exist. the qualified path for the specified file is returned
	- `home_dir()-><qualified path>` returns the users home directory
	- `home_path(<relative path>)-><qualified path>` returns fully qualified  path relative to the user's home directory
	- ... (more functions are coming whenver they are needed)

# <a name="shell"></a> Shell


## <a name="console"></a> Console Interaction

Since I have been using cmake for what it has not been created (user interaction) I needed to enhance console output and "invent" console input.  using shell magic it became possible for me to read input from the shell during cmake execution.  You can see it in action in the interactive cmake shell `icmake` (start it by running cmake -P icmake.cmake) Also I was missing a way of writing to the shell without appending a linebreak - using `cmake -E echo_append` it was possibly for me to output data without ending the line.  

### Enhanced `message` function

When working with recursive calls and complex build processes it is sometimes useful to allow output to be indented which helps the user understand the output more easily.

Therfore I extended the `message` function to allow some extra flags which control  indentation on the console. The indentation functionality can also be controlled using the `message_indent*` functions.  Take the following example:

*Example*

```
function(add_some_lib)
	message(PUSH_AFTER "adding somelib")
	...
	message(POP_AFTER "done")
endfunction()
function(add_my_target)
  message(PUSH_AFTER "adding my target")
  ...
  message("gathering sources")
  add_some_lib()
  ...
  message(POP_AFTER "complete")
endfunction()

message("condiguring")
add_some_lib()
add_my_target()
message("finished")
```

*Output*:
```
adding somelib
adding my target
  gathering sources
  adding somelib
    done
  complete
finished

```

### Functions

* `read_line()-><string>` prompts the user to input text. waiting for a line break. the result is a string containing the line read from console
* `echo_append([args ...])` appends the specifeid arguments to stdout without a new line at the end
* `echo([args ...])` appends the specified arguments to stdout and adds a new line
* `message`
* `message(<flags?> <string> )` enhanced message function (with indentation)
	- `PUSH` 
* `print(str)` prints the specified string to console (default is stderr...) using `_message` 
* `message_indent_level():<uint>` returns the level of indentation
* `message_indent_get():<>` returns the indentation string `string_repeat("  " ${n})` (two spaces times the indentation level)
* `message_indent_push(<level?:[+-]?<uint>>):<uint>`  pushes the specified level on to the indentation stack making it the current level. if the number is preceded by `+` or `-` the value is relative to the current indentation level.
* `message_indent_pop():<uint>` removes the last level from the stack and returns the new current level
* `message_indent(<string>)` writes the string to the console indenting it
 


## <a name="aliases"></a> Aliases

Since I like to provide command line tools based on cmake (using cmake as a cross plattform shell in some sense) I also needed the ability to create aliases in a platform independent way. Even though I have a couple of limitations I have found a good posibillity to do what I want. See the following example of how to create a cross platform way to dowload a file:

```
fwrite("datetimescript.cmake" "
include(\${cmakepp_base_dir}/cmakepp.cmake)
datetime()
ans(dt)
json_print(${dt})
")
path("datetimescript.cmake")
ans(fullpath)
alias_create("my_datetime" "cmake -P \"${fullpath}\"")

```

After executing the above code the current shell will have access to the my_datetime alias and the following call will be possible without any reference to cmake - in this case the cmake command is called of course but `create_alias` can be used to create a alias for any type of executable as bash and windows commandprompts do not differ too much in this respect

```
shell> my_datetime
{
 "yyyy":"2014",
 "MM":"11",
 "dd":"27",
 "hh":"22",
 "mm":"51",
 "ss":"32",
 "ms":"0"
}
```

### Functions and Datatypes

* `alias_create(<alias name> <shell code>)`  - under windows this registers a directory in the users PATH variable. In this directory batch files are created. Under Unix the .bashrc is edited and a alias is inserted.
	- Not implemented yet:
		+ `alias_exists`
		+ `alias_remove`
		+ `alias_list`





# <a name="cmake"></a> CMake Command

Like the version control system I also wrappend cmake itself into an easy to use function called `cmake(...)`  this allows me to start subinstances of cmake

# <a name="tooling"><a> CMake Tooling

To create tools for CMake (wherever something cannot be done with cmake) I created a very simple function called `compile_tool(<name> <src>)`

This function does the following tasks

* creates a cmake project with CMakeLists file and a single executable target the target has a single source file (whatever you put in `<src>`)
* compiles this tool (the tool may only use standard headers currently)
* caches the compiled tool so that it is not recompiled unless src changes
* creates a wrapper function in cmake called `<name>` which evaluates the cmake code that the command outputs
* arguments passed to wrapper `<name>` are passed along as command line args for the main method.

*note*: this will change in the future as it is a very naive implementation.


## Example

Because cmake does not support getting the current time in milliseconds since the epoch the need arose for me to compile custom code. This code is the example for using the `compile_tool(..)` function.

```
## returns the number of milliseconds since epoch
function(millis)
  # initializer function pattern - because compile_tool
  # redefines the millis function this code is only executed once
  compile_tool(
  	# first argument: the name of the tool 
  	# and the function name to be defined  	
  	millis 
  	# second argument: the source code to compile
  	# with default compiler/generator under you system  	
  	"
    #include <iostream>
    #include <chrono>
    int main(int argc, const char ** argv){
     // use chrono to get the current time in milliseconds
     auto now = std::chrono::system_clock::now();
     auto duration = now.time_since_epoch();
     auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();
     // return cmake code which is to be evaluated by command wrapper
     // set_ans will let the eval function return the specified value
     std::cout<< \"set_ans(\" << millis << \")\";
     return 0;
    }
    "
    )
  ## compile_tool has either failed or succesfully defined the function
  ## wrapper called millis
  millis(${ARGN})
  return_ans()
endfunction()

# now you can use millis
millis()
ans(ms)
message("time since epoch in milliseconds: ${ms}")
```


# <a name="userdata"><a> User Data

User Data is usefull for reading and writing configuration per user.  It is available for all cmake execution and can be undestood as an extra variable scope. It however allows maps which help structure data more clearly.  User Data is stored in the users home directory (see `home_dir`) where a folder called `.cmakepp` inside are files in a quickmap format which can be edited in an editor of choice besides being managed by the following functions.  User Data is always read and persisted directly (which is slower but makes the system more consistent)

## Functions and Datatypes

* `<identifier>`  a string
* `user_data_get(<id:<identifier>> [<nav:<navigation expression>>|"."|""]):<any>` returns the user data for the specified identifier, if a navigation expression is specified the userdata map will be navigated to the specified map path and the data is returned (or null if the data does not exist). 
* `user_data_set(<id:<identifier>> <<nav:<navigation expression>>|"."|""|> [<data:any ...>]):<qualified path>` sets the user data identified by id and navigated to by  navigation
* `user_data_dir():<qualified path>` returns the path where the userdata is stored: `$HOME_DIR/.cmakepp`
* `user_data_ids():<identifier ...>` returns a set of identifiers where user data was stored
* `user_data_clear(<"--all"^<id:<identifier>>>):<void>` if `--all` is specified all user data is removed. (use with caution) else only the user data identified by `<id>` is removed
* `user_data_read(<id:<identifier>>):<any>` deserializes the user data identified by id and returns it (`user_data_get` and `user_data_set` are based on this function)
* `user_data_write(<id:<identifier>> [<data:<any> ...>]):<qualified path>` serializes and persists the specified data and associates it with `<id>`
* `user_data_path(<id:<identifier>> ):<qualified path>` returns the filename under which the user data identified by `<id>` is located

## Example

```

## store user data during cmake script execution/configuration/generation steps
## this call creates and stores data in the users home directory/.cmakepp
user_data_set(myuserdata configoptions.configvalue "my value" 34)


## any other file executed afterwards
user_data_get(myuserdata)
ans(res)

json_print(${res}) 

## outputs the following
# {
#	  configoptions:{
#	    configvalue:["my value",34]
#   }
# }

```

# <a name="process_management"><a> Process Management

This section how to manage processes and external programs.  Besides replacements for cmake's `execute_process` function this section defines a control system for parallel processes controlled from any cmake.  

## Common Definitions

The following definitions are common to the following subsections.  

* `<command>` a path or filename to an executable programm.
* `<process start info> ::= { <command>, <<args:<any ...>>, <cwd:<directory>>  }`  


## <a name="execute"></a> Wrapping and Executing External Programms

Using external applications is more complex than necessary in cmake in my opinion. I tried to make it as easy as possible. Using the convenience of the [filesystem functions](#filesystem) and maps wrapping an external programm and using it as well as pure execution is now very simple as you can see in the following example for git:

### Examples
This is all the code you need to create a function which wraps the git executable.  It uses the [initializer function pattern](#initializer_function). 

```
function(git)
  # initializer block (will only be executed once)
  find_package(Git)
  if(NOT GIT_FOUND)
    message(FATAL_ERROR "missing git")
  endif()
  # function redefinition inside wrap_executable
  wrap_executable(git "${GIT_EXECUTABLE}")
  # delegate to redefinition and return value
  git(${ARGN})
  return_ans()
endfunction() 
```

Another example showing usage of the `execute()` function:

```
find_package(Hg)
set(cmdline --version)
execute({path:$HG_EXECUTABLE, args: $cmdline} --result)
ans(res)
map_get(${res} result)
ans(error)
map_get(${res} output)
ans(stdout)
assert(NOT error) # error code is 0
assert("${stdout}" MATCHES "mercurial") # output contains mercurial
json_print(${res}) # outputs input and output of process

```

### Functions and Datatypes

* `execute(<process start info ?!> [--result|--return-code]) -> <stdout>|<process info>|<int>` executes the process described by `<process start ish>` and by default fails fatally if return code is not 0.  if `--result` flag is specified `<process info>` is returned and if `<return-code>` is specified the command's return code is returned.  (the second two options will not cause a fatal error)
	* example: `execute("{path:'<command>', args:['a','b']}")`  
* `wrap_executable(<name:string> <command>)`  takes the executable/command and wraps it inside a function called `<name>` it has the same signature as `execute(...)`
* `<process start info?!>` a string which can be converted to a `<process start>` object using the `process_start_info()` function.
* `<process start info>` a map/object containing the following fields
	- `command` command name / path of executable *required*
	- `args` command line arguments to pass along to command, use `string_semicolon_encode` if you want to have an argument with semicolons *optional*
	- `timeout:<int>` *optional* number of seconds to wait before failing
	- `cwd:<unqualified path>` *optional*  by default it is whatever `pwd()` currently returns
* `<process info>` contains all the fields of `<process start>` and additionaly
	- `output:<stdout>`  the output of the command execution. (merged error and stdout streams)
	- `result:<int>` the return code of the execution.  0 normally indicates success.
* `process_start_info(<process start info?!>):<process start info>` creates a valid `<process start info>` object from the input argument.  If the input is invalid the function fails fatally.

## Parallel Processes 

When working with large applications in cmake it can become necessary to work in parallel processes. Since all cmake target systems support multitasking from the command line it is possible to implement cmake functions to control it.  I implemented a 'platform independent' (platform on which either powershell or bash is available) control mechanism for starting, killing, querying and waiting for processes.  The lowlevel functions are platform specific the others are based on the abstraction layer that the provide.   

### Examples

This example starts a script into three separate cmake processes. The program ends when all scripts are done executing.
```
# define a script which counts to 10 and then 
# note that a fresh process means that cmake has not loaded cmakepp
set(script "
foreach(i RANGE 0 10)
  message(\${i})
  execute_process(COMMAND \${CMAKE_COMMAND} -E sleep 1)
endforeach()
message(end)
")

# start each script - fork_script returns without waiting for the process to finish.
# a handle to the created process is returned.
process_start_script("${script}")
ans(handle1)
process_start_script("${script}")
ans(handle2)
process_start_script("${script}")
ans(handle3)

# wait for every process to finish. returns the handles in order in which the process finishes
process_wait_all(${handle1} ${handle2} ${handle3})
ans(res)

## print the process handles in order of completion
json_print(${res})

```

This example shows a more usefull case:  Downloading multiple 'large' files parallely to save time

```

  ## define a function which downloads  
  ## all urls specified to the current dir
  ## returns the path for every downloaded files
  function(download_files_parallel)
    ## get current working dir
    pwd()
    ans(target_dir)

    ## process start loop 
    ## starts a new process for every url to download
    set(handles)
    foreach(url ${ARGN})
      ## start download by creating a cmake script
      process_start_script("
        include(${cmakepp_base_dir}/cmakepp.cmake) # include cmakepp
        download(\"${url}\" \"${target_dir}\")
        ans(result_path)
        message(STATUS ${target_dir}/\${result_path})
        ")
      ans(handle)
      ## store process handle 
      list(APPEND handles ${handle})
    endforeach()

    ## wait for all downloads to finish
    process_wait_all(${handles})

    set(result_paths)
    foreach(handle ${handles})
      ## get process stdout
      process_stdout(${handle})
      ans(output)

      ## remove '-- ' from beginning of output which is
      ## automatically prependend by message(STATUS) 
      string(SUBSTRING "${output}" 3 -1 output)

      ## store returned file path
      list(APPEND result_paths ${output})

    endforeach()

    ## return file paths of downloaded files
    return_ref(result_paths)
  endfunction()


  ## create and goto ./download_dir
  cd("download_dir" --create)

  ## start downloading files in parallel by calling previously defined function
  download_files_parallel(
    http://www.cmake.org/files/v3.0/cmake-3.0.2.tar.gz
    http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz
  )
  ans(paths)


  ## assert that every the files were downloaded
  foreach(path ${paths})
    assert(EXISTS "${path}")
  endforeach()


```


### Functions and Datatypes
* datatypes
	* `<process handle> ::= { state:<process state> , pid:<process id> }` process handle is a runtime unique map which is used to address a process.  The process handle may contain more properties than specified - only the specified ones are available on all systems - these properties contain values which are implementation specific.
	* `<process info> ::= { }` a map containing verbose information on a proccess. only the specified fields are available on all platforms.  More are available depending on the OS you use. You should not try to use these without examining their origin / validity.
	* `<process state> ::= "running"|"terminated"|"unknown"`
	* `<process id> ::= <string>` a unspecified systemwide unique string which identifies a process (normally a integer)
* platform specific low level functions 
	* `process_start(<process start info?!>):<process handle>` platfrom specific function which starts a process and returns a process handle
	* `process_kill(<process handle?!>)` platform specific function which stops a process.
	* `process_list():<process handle ...>` platform specific function which returns a process handle for all running processes on OS.
	* `process_info(<process handle?!>):<process info>` platform specific function which returns a verbose process info
	* `process_isrunning(<process handle?!>):<bool>` returns true iff process is running. 
* `process_timeout(<n:<seconds>>):<process handle>` starts a process which times out in `<n>` seconds. 
* `process_wait(<process handle~> [--timeout <n:seconds>]):<process handle>` waits for the specified process to finish or the specified timeout to run out. returns null if timeout runs out before process finishes.
* `process_wait_all(<process handle?!...> <[--timeout <n:seconds>] [--quietly]):<process handle ...>` waits for all specified process handles and returns them in the order that they completed.  If the `--timeout <n>` value is specified the function returns as soon as the timeout is reached returning only the process finished up to that point. The function normally prints status messages which can be supressed via the `--quietly` flag.    
* `process_wait_any(<process handle?!...> <?"--timeout" <n:<seconds>>> <?"--quietly">):<?process handle>` waits for any of the specified processes to finish, returning the handle of the first one to finished. If `--timeout <n>` is specified the function will return `null` after `n` seconds if no process completed up to that point in time. You can specify `--quietly` if you want to suppress the status messages. 
* `process_stdout(<process handle~>):<string>` returns all data written to standard output stream of the process specified up to the current point in time
* `process_stderr(<process handle~>):<string>` return all data written to standard error stream of the process specified up to the current point in time
*   `process_return_code(<process handle~>):<int?>` returns nothing or the process return code if the process is finished
*   `process_start_script(<cmake code>):<process handle>` starts a separate cmake process which runs the specified cmake code.

### Inter Process Communication

To communicate with you processes you can use any of the following well known mechanisms

* Environment Variables
	- the started processes have access to you current Environment. So when you call `set(ENV{VAR} value)` before starting a process that process will have read access to the variable `$ENV{VAR}` 
* Command Line Arguments
	- all variables passed to `start_process` will be passed allong
	- Command Line Variables are sometimes problematic as they must be escaped correctly and this does not always happen as expected. So you might want to choose another mechanism to transmit complex data to your process
	- Command Line Variables are limited by their string length depending on you host os.
* Files
	- Files are the easiest and safest way to communicate large amounts of data to another process. If you can try to use file communication
* stderr, stdout
	- The output of a process started with `start_process` becomes available to you when the process ends at latest, You can choose to poll stdout and take data as soon as it is written to the output streams 
* return code
	- the returns code tells you how you process finished and is often enough result information for a process you start
	
### Caveats

* process starting is slow - it can take seconds (it takes 900ms on my machine). The task needs to be a very large one for it to compensate the overhead.
* parallel processes use platform specific functions - It might cause problems on less well tested OSs and some may not be supported.  (currently only platforms with bash or powershell are supported ie Windows and Linux)



# <a name="uris"></a> Uniform Resource Identifiers (URIs)

Uniform Resource Identifiers are often used for more than just internet addresses.  They are able to identify any type of resource and are truly cross platform.  Even something as simple as parsing a path can take on complex forms in edge cases.  My motivation for writing an URI parser was that I needed a sure way to identify a path in a command line call. 

My work is based arround [RFC2396](https://www.ietf.org/rfc/rfc2396.txt) by Berners Lee et al.  The standard is enhanced by allowing delimited URIs and Windows Paths as URIs. You can always turn this behaviour off however and use flags to use the pure standard.

URI parsing with cmake is not something you should do thousands of times because alot of regex calls go into generating an uri object.

## Example

*Parse an URI and print it to the Console*
```
uri("https://www.google.de/u/0/mail/?arg1=123&arg2=arg4#readmails some other data")
ans(res)
json_print(${res})
```

*output*
```
{
 "input":"https://www.google.de/u/0/mail/?arg1=123&arg2=arg4#readmails some other data",
 "uri":"https://www.google.de/u/0/mail/?arg1=123&arg2=arg4#readmails",
 "rest":" some other data",
 "delimiters":null,
 "scheme":"https",
 "scheme_specific_part":"//www.google.de/u/0/mail/?arg1=123&arg2=arg4#readmails",
 "net_path":"www.google.de/u/0/mail/",
 "authority":"www.google.de",
 "path":"/u/0/mail/",
 "query":"arg1=123&arg2=arg4",
 "fragment":"readmails",
 "user_info":null,
 "user_name":null,
 "password":null,
 "host_port":"www.google.de",
 "host":"www.google.de",
 "labels":[
  "www",
  "google",
  "de"
 ],
 "top_label":"de",
 "domain":"google.de",
 "ip":null,
 "port":null,
 "trailing_slash":false,
 "last_segment":"mail",
 "segments":[
  "u",
  0,
  "mail"
 ],
 "encoded_segments":[
  "u",
  0,
  "mail"
 ],
 "file":"mail",
 "extension":null,
 "file_name":"mail"
}
```

*Absolute Windows Path*

```
# output for C:\windows\path
{
 "input":"C:\\windows\\path",
 "uri":"file:///C:/windows/path",
 "rest":null,
 "delimiters":null,
 "scheme":"file",
 "scheme_specific_part":"///C:/windows/path",
 "net_path":"/C:/windows/path",
 "authority":null,
 "path":"/C:/windows/path",
 "query":null,
 "fragment":null,
 "user_info":null,
 "user_name":null,
 "password":null,
 "host_port":null,
 "host":null,
 "labels":null,
 "top_label":null,
 "domain":null,
 "ip":null,
 "port":null,
 "trailing_slash":false,
 "last_segment":"path",
 "segments":[
  "C:",
  "windows",
  "path"
 ],
 "encoded_segments":[
  "C:",
  "windows",
  "path"
 ],
 "file":"path",
 "extension":null,
 "file_name":"path"
}
```


*Perverted Example*
```
uri("'scheme1+http://user:password@102.13.44.22:23%54/C:\\Program Files(x86)/dir number 1\\file.text.txt?asd=23#asd'")
ans(res)
json_print(${res})
```
*output*
```
{
 "input":"'scheme1+http://user:password@102.13.44.32:234/C:\\Progr%61m Files(x86)/dir number 1\\file.text.txt?asd=23#asd'",
 "uri":"scheme1+http://user:password@102.13.44.32:234/C:/Progr%61m%20Files(x86)/dir%20number%201/file.text.txt?asd=23#asd",
 "rest":null,
 "delimiters":null,
 "scheme":"scheme1+http",
 "scheme_specific_part":"//user:password@102.13.44.32:234/C:/Progr%61m%20Files(x86)/dir%20number%201/file.text.txt?asd=23#asd",
 "net_path":"user:password@102.13.44.32:234/C:/Progr%61m%20Files(x86)/dir%20number%201/file.text.txt",
 "authority":"user:password@102.13.44.32:234",
 "path":"/C:/Progr%61m%20Files(x86)/dir%20number%201/file.text.txt",
 "query":"asd=23",
 "fragment":"asd",
 "user_info":"user:password",
 "user_name":"user",
 "password":"password",
 "host_port":"102.13.44.32:234",
 "host":"102.13.44.32",
 "labels":null,
 "top_label":null,
 "domain":null,
 "ip":"102.13.44.32",
 "port":234,
 "trailing_slash":false,
 "last_segment":"file.text.txt",
 "segments":[
  "C:",
  "Program Files(x86)",
  "dir number 1",
  "file.text.txt"
 ],
 "encoded_segments":[
  "C:",
  "Progr%61m%20Files(x86)",
  "dir%20number%201",
  "file.text.txt"
 ],
 "file":"file.text.txt",
 "extension":"txt",
 "file_name":"file.text"
}
```


## DataTypes and Functions

* `<uri> ::= `
	* `uri:<string>` all of the uri as specified 
	* `scheme:<string>` the scheme part of the uri without the colon e.g. `https` from `https://github.com`	 
	* `scheme_specific_part` the part of the uri that comes after the scheme and its colon e.g. `//github.com` from the previous example
	* `autority:<string>` the domain, host,port and user info part of the domain 
	* `path:<string>` the hierarchical part of the uri 
	* `query:<string>` the query part of the uri
	* `fragment:<string>` the fragment part of the uri
* `<uri~> ::= <string>|<uri>` a uri or a string which can be converted into a valid uri
* `uri(<uri~>):<uri>` 
* `uri_parse(<uri_string:<string>> <?--notnull> <?--file> <?--escape-whitespace> <?--delimited> ):<uri?>`
	* `<--escape-whitespace>` 
	* `<--file>` 
	* `<--notnull>` 
	* `<--delimited>` 
* `uri_to_path(<uri~>):<string>`
* 


## Caveats

* Parsing is always a performance problem in CMake therfore parsing URIs is also a performance problem don't got parsing thousands of uris. I Tried to parse 100 URIs on my MBP 2011 and it took 6716 ms so 67ms to parse a single uri
* Non standard behaviour can always ensue when working with file paths and spaces and windows.  However this is the closest I came to having a general solution

## Future Work

* allow more options for parsing
* option for quick parse or slow parse 

# <a name="string_functions"></a> String Functions

# <a name="lists"></a> List and Set Functions

CMake's programming model is a bit ambigous but also very simple. Every variable can be interpreted as a list and a string.  This duality makes everything a little complex because you can never know what which of both is meant. However if you tell the client of you CMake functions what you expect  you start to programm by convention which is very usefull in a very simple dynamic language like CMake Script.

## Datatypes and Functions

* `<list>  := <string ...>`  a variable in cmake which semicolon separated strings.
* `<predicate> := (<any>):<bool>` a function which takes a single arg and returns a truth value 
* `<list ref> :: <list&>` the name of the variable that contains a list
* `<set> := <list>` a set is a list which contains only unique elements. You can create a set by using CMake's `list(REMOVE_DUPLICATES thelist)` function.
* `index_range(<lo:int> <hi:int>):<int...>` returns a list of indices which includes `lo` but excludes `hi`.
	- `index_range(3 5)`  -> `3;4`
* `list_all(<list ref> <predicate>):<bool>` returns true iff predicate evaluates to true for all elements of the list
* `list_any(<list ref> <predicate>):<bool>` returns true iff predicate evaluates to true for for at least one element of the list.
* `list_at(<list ref> <indices:<int...>>):<list>` returns all elements of the list which specified by their indices. Repetions are allowed.
	- `list_at(thelist 1 3 0 0)` -> `b;d;a;a` if the list contains the alphabet
* `list_combinations(<list ref...>):<list>` returns all possible combinations of all specified lists
	- `list_combinations(bin bin bin)` -> `000;001;010;011;100;101;110;111` if `bin = 0;1`   
* `list_contains(<list ref> <args:any...>):<bool>` returns true if list contains all args specified
* `list_count(<list ref> <predicate>):<int>` returns the number of elements for which the specified predicate evalautes to true
* `list_difference(<list ref> <predicate>):<list>`
* `list_equal(<lhs:<list ref>> <rhs:<list ref>>):<bool>` 
* `list_erase(<list ref> <start_index> <end_index>):<void>` removes the specified range from the list
* `list_erase_slice(<list ref> <start_index> <end_index>):<list>` removes the specified range from the list and returns the removed elements
* `list_except(<lhs:<list ref>> <rhs:<list ref>>):<list>` returns the elements of lhs which are not in rhs
* `list_extract(<list ref> <any&...>):<list>` removes the first n elements of the list and returns the rest of the list.  
* `list_extract_any_flag`
* `list_erase_slice(<list ref> <startindex:<int>> <endindex:<int>> <args:<any...>>):<list>` replaces the specified range of the list with the passed varargs.  returns the elements which were removed


## Caveats

* some list functions wrap default cmake behaviour. That means that they are slower.  So in some cases where you are doing alot of function calling you should use the default cmake functions to make everything faster.


### Range based List access

Ranges are an awesome way of accessing lists. Take for example the following task: `return the last element, the 3rd element and elements 8 to 6` using cmake this can become complicated having to check list lengths and compiling the list of indices needed.  However it is easier if you write `list_range_get(mylist $,2,8:6:-1)`


#### Functions and Datatypes

* `list_range_get()`
* `list_range_indices()`
* `list_range_partial_write()`
* `list_range_remove()`
* `list_range_replace()`
* `list_range_set()`
* `list_range_try_get()`


# <a href="packages"></a> Package Search and Retrieval

## Motivation

A best practice for retrieving and using third party libraries with a platform independent build system (for c++) is currently not available.  So I have decided to throw my hat in the ring by adding package control to cmake.  I compete with other great solutions in this area:

* [biicode]() a file based dependency management system depending on a central webservice. 
* [hunter]() a decentralized package manager with a central repository for `hunter gates` 
* [cpm]() a git, subversion and hg based package manager also indexes packages in a github repository

I want to be able to use decentralized package sources (ie not a centralized server through which all requests go) and be easily extinsible to incoporate other package services with minimal overhead.

I want package search and retrieval to be a very simple process so it can be applied generally. (no specialization on C++, no callbacks, installation, etc - these subjects are important and are adressed but not in respect to package search and retrieval) 

Using package search and retrieval as a base I will extend it by [dependency management](#) and [cpp project generation](#). 

## Implementation

I chose a very simple interface to handle packages *note: these functions exist for every `package source` (not globally) - except pull which is only implemented by writable data sources*:  

* `<package>` is an abstract term. It describes a set of files and meta information (`<package descriptor>`) which is identified by a `<package uri>`
* `<package descriptor>` meta information on a package. No constraint on the data is made. There are however some properties which have special meaning and are listed here
	* `id: <string>` the name of the `package` it should be uniqueish. At least in its usage context it should be unique.
	* `version: <semver>` the version of the package  	  
	* `...` other properties do not pertain to package search and retrieval but rather to project- and dependency-management these are described elsewhere.
* `<package uri>` is a `<uri>` of an existing uniquely identified `<package>` this uri identifies a `<package>`'s contents and `package descriptor` the content and meta information of the package SHOULD BE immutable. This constraint is needed to allow for dependency management and guaranteeing a package's reliability. Every ``package source`` will tell you what kind of guarantee it gives your.  
* `<package handle>`  a package handle is an object containing information on a package and has a unique key called `uri`.  The data varies for a package handle depending on the `package source` it stems from. Some sources might add more meta information than others. 
	- properties   
		* `uri :<package uri>` required. uniquely identifies this package
		* `package_descriptor: <package_descriptor?>` required after resolve (may be null or generated.)
		* `content_dir:<content dir>` required after successful pull 
		* `...`
* `query(<~uri> [--package-handle]) -> <package uri...>` takes a uri query and returns a list of unique unchanging `<package uri>` which will be valid now and generally in the future.  It is important to note the unchanging aspect as once a package is uniquely identified the user expects it only to change when he/she wants it to.
	* `--package-handle` will return a `<package handle>` instead of a `<package uri>`
	* `--refresh` will cause an update of any cache being used.  `package source`s which do not cache will silently ignore this flag. 	 
* `resolve(<~uri> [--refresh]) -> <package handle?>` takes a uri and returns a `<package handle>`  if the uri uniquely identifies a package.  If the uri specified is not unique null is returned.
	* `--refresh` will cause an update of any cache being used. `package source`s which do not cache will silently ignore this flag.	 
* `pull(<~uri> <target_dir?> [--refresh] [--reference]) -> <package handle>` takes a uri which is resolved to a package.  The content of the package is then loaded into the specified target dir (relative to current `pwd`) The returned package handle will contain a property called `content_dir` which will normally but not necessarily be the same to `target_dir`
	- `--refresh` will cause an update of any cache being used
	- `--reference` will set the `content_dir` of the package handle to a local path which already contains the content associated with the `package uri` if the `package source` does not support the reference flag it ifnore the `--reference` flag
* `push(<~package handle> ...) -> <package uri>` the implemenation of this function is not necessary and not available for all `package source`s - it allows upload of a package to a `package source`. After the successfull upload the `<package uri>` is returned. 
	- `...` arguments dependening on the `package source` being used.

The `package source`s described hitherto all have a constructor function which returns a `package source` object. The `pull`/`push`/`resolve`/`query` implementations have a longer function name and SHOULD NOT be used directly but by calling them on the `package source` object using `call(...)` or `assign(...)`.

If your are just interested in pulling packages from a remote to a target directory you should use the [default package methods](#packages_default_methods): `pull_package`, `resolve_package`, `query_package`  which work globally and need no special `package source` object. 

*Examples*

```
## create a github package source and use it to find all local repositories of a github user and print them to the console
set(user "toeb")
assign(source = github_package_source())
assign(package_uris = source.query("${user}"))
message("all packages for ${user}")
foreach(package_uri ${package_uris})
	message("  ${package_uri}")
endforeach()
```

### <a href="packages_default_methods"></a> Default Package Source nad Default Package Functions

The default package source combines access to github, bitbucket,webarchives, git, svn, hg, local archives and local dirs in a single package source. 

It can be accessed conveniently by these global functions

* `default_package_source() -> <default package source>`
* `query_package(<~uri>):<package uri...>`
* `resolve_package(<~uri>):<package handle?>`
* `pull_package(<~uri> <target dir?>):<package handle>`

*Examples*

```

## pull a github package to current user's home dir from github
pull_package("toeb/cmakepp" "~/current_cmakepp")

## pull a bitbucket package to pwd
pull_package("eigen/eigen")

## pull a package which exists in both bitbucket and github under the same user/name from github
pull_package("github:toeb/test_repo")

## find all packages from user toeb in bitbucket and github

assign(package_uris = query_package(toeb))
foreach(package_uri ${package_uris})
	message("  ${package_uri}")
endforeach()

```

### Package Sources

A `package source` is a set of methods and possibly some implementation specific properties.  The interface for a `package source` was already described and consists of the methods.
* `query`
* `resolve`
* `pull`
* `push` *optional*

In the following sections the package source implementations are briefly discussed. 

#### github package source

A package source which uses the github api to parse remote source packages. The idea is to use only the `<user>/<repo>` string to identify a source package.

* `query uri format` a combination of `<github user>/<github repo?>/<branch/tag/release?>`. specifying only the user returns all its repositories specifying user and repository will return the current default repository. specifying a branch will also check the branch
* `package uri format` a uri of the following format `github:<user>/<repo>/<ref?>`
* Functions
	- `github_package_source() -> <path package source>` returns a github package source object which the following implementations.  
	- `query: package_source_query_github(...)->...`
	- `resolve: package_source_resolve_github(...)-> <package handle?>` package handle contains a property called `repo_descriptor` which contains github specific data to the repository
	- `pull: package_source_pull_github(...)->...`


#### bitbucket package source

A package source which uses the bitbucket api to parse remote source packages. 

* `query uri format` a combination of `<bitbucket user>/<bitbucket repo?>/<branch/tag/release?>`. specifying only the user returns all its repositories specifying user and repository will return the current default repository. specifying a branch will also check the branch
* `package uri format` a uri of the following format `bitbucket:<user>/<repo>/<ref?>`
* Functions
	- `bitbucket_package_source() -> <path package source>` returns a bitbucket package source object which contains the following methods.
	- `package_source_query_bitbucket(...)->...`
	- `package_source_resolve_bitbucket(...)-> <package handle?>` package handle contains a property called `repo_descriptor` which contains bitbucket specific data to the repository
	- `package_source_pull_bitbucket(...)->...`


#### path package source

* `query uri format` - takes any local `<path>` (relative or absolute) or local path uri (`file://...`) that is points to an existing directory. (expects a `package descriptor file` in the local directory. 
* `package uri format` - a file schemed uri with no query which contains the absolute path of the package (no relative paths allowed in *unique* resource identifier)
* Functions
	- `path_package_source() -> <path package source>` returns a path package source object which ontains the methods described above 
	- `package_source_query_path(...)->...`
	- `package_source_resolve_path(...)->...`
	- `package_source_pull_path(...)->...`
	- `package_source_push_path(...)->...`

*Examples*

* valid query uris
	- `../pkg` relative path
	- `C:\path\to\package` absolute windows path
	- `pkg2` relative path
	- `/home/path/pkg3` absolute posix path
	- `~/pkgX` absolute home path 
	- `file:///C:/users/tobi/packages/pkg1` valid file uri 
	- `file://localhost/C:/users/tobi/packages/pkg1` valid file uri 
* valid package uris
	- `file:///usr/local/pkg1`
	- `file://localhost/usr/local/pkg1`
* valid local package dir
	- contains `package.cmake` - a json file describing the package meta data

#### archive package source

*Note: Currently only application/x-gzip files are supported - the support for other formats is automatically extended when decompress/compress functions support new formats*

* `query uri format` - takes any local `<path>`  (relative or absolute) or local path uri (`file://...`) that points to an existing archive file (see `compress`/`decompress` functions)
* `package uri format` - a file schemed uri which contains the absolute path to a readable archive file.
* Functions
	- `archive_package_source() -> <archive package source>`
	- `package_source_query_archive(...)->...`
	- `package_source_resolve_archive(...)->...`
	- `package_source_pull_archive(...)->...`
	- `package_source_push_archive(...)->...`

*Examples*

* valid query uris
	- `../pkg.tar.gz` relative path
	- `C:\path\to\package.gz` absolute windows path to existing tgz file
	- `pkg3.7z` (does not work until decompress works with 7z files however correct nonetheless)
	- `~/pkg4.gz` home path
	- `file:///path/to/tar/file.gz`
* valid package uris
	- `file:///user/local/pkg1.tar.gz`
	- `file://localhost/usr/local/pkg1.tar.gz`

#### web archive package source

*Note: same as local archive*

* `query uri format` - takes any uri which points to downloadable archive file. (including query) (normally the scheme would be `http` or `https` however only the protocol needs to be http as this package source sends a `HTTP GET` request to the specified uri.)  See `http_get` for more information on how to set up security tokens etc. 
* `package uri format` - same as `query uri format`
* Functions
	- `webarchive_package_source() -> <webarchive package source>`
	- `package_source_query_webarchive(...)->...`
	- `package_source_resolve_webarchive(...)->...` tries to read the `package descriptor` inside the archive.  If that fails tries to parse the filename as a package descriptor. 
	- `package_source_pull_webarchive(...)->...`
	- NOT IMPLEMENTED YET `package_source_push_webarchive(<~package handle> <target: <~uri>>)->...` uses `http_put` to upload a package to the specified uri

*Examples*

* valid query uris
	- `http://downloads.sourceforge.net/project/jsoncpp/jsoncpp/0.5.0/jsoncpp-src-0.5.0.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fjsoncpp%2F&ts=1422460575&use_mirror=switch`
	- `http://github.com/lloyd/yajl/tarball/2.1.0`

#### git package source

Uses the source code management sytem `git` to access a package.  A git repository is interpreted as a package with refs (tags/branches/hashes) being interpreted as different version.

* `query uri format` - takes any uri which git can use (`https`, `ssh`, `git`, `user@host:repo.git`) internally `git ls-remote` is used to check if the uri points to a valid repository. You can specify a ref, branch or tag by appending a query to the uri e.g. `?tag=v0.0.1`
* `package uri format` - same as `query uri format` but with the additional scheme `gitscm` added
* Functions
	- `git_package_source()`
	- `package_source_query_hg(<~uri>) -> <package uri...>` 
	- `package_source_resolve_hg(<~uri>) -> <package uri...>` 
	- `package_source_pull_hg(<~uri>) -> <package uri...>` 

#### mercurial package source

Uses the source code management system `mercurial` to access packages. 

* `query uri format` - any uri which the `hg` executable can use 
* `package uri format` - same as `query uri format` but with the additional scheme `hgscm` added. The query only contains `?<ref type>=<ref>` if a specific revision is targeted
* Functions
	- `hg_package_source()-> <hg package source>`
	- `package_source_query_hg(<~uri>) -> <package uri...>` 
	- `package_source_resolve_hg(<~uri>) -> <package uri...>` 
	- `package_source_pull_hg(<~uri>) -> <package uri...>` 

#### subversion package source

uses the source code management system `subversion` to access packages

* Functions
	- `svn_package_source()-> <hg package source>`
	- `package_source_query_svn(<~uri>) -> <package uri...>` 
	- `package_source_resolve_svn(<~uri>) -> <package uri...>` 
	- `package_source_pull_svn(<~uri>) -> <package uri...>` 


#### composite package source

A composite package source manages a list of sub data sources and uses a rating algorithm to select the correct source.  If one of the schemes of an uri matches a `package sources`'s `source_name` it is selected. Else the `package source`'s `rate_uri(<uri>)-><int>` method is called which returns a value from `0` to `999` where `0` means package source cannot handle the uri and `999` means package source is the only one which can handle the uri. The sources are ordered by the rating and queried in order.

* `query uri format`
* `<package handle>` contains the property `rating` which contains the rating of the uri and `package_source` which contains the package source which handles the `uri`
* 
 
#### cached package source

The cache package source caches the package query and resolve requests so that accessing them is quick.  

* Functions
	- `cache_package_source(<inner: <package source>>) -> <cached package source>`
	- `package_source_query_cached(...)->...`
	- `package_source_resolve_cached(...)->...`
	- `package_source_pull_cached(...)->...`


#### directory package source 

The directory package source has a `source_name` and a `directory` associated with it. It treets every `subdirectory` as a possible package and allows query, resolve and pull operations on them.  The `package descriptor` is sought for in the `subdirectory`s `package descriptor file`  The content is copied as is described by the `path package source`

* Functions
	- `<directory package source> ::= { source_name:<string>, directory:<path>, query:<function>, resolve:<function>, pull:<function>  }`
	- `directory_package_source(<source_name> <directory: <path>>) -> <directory package source>`
	- 

#### managed package source

A managed package source has a `source_name` and a `directory` which it manages.  The managed package source should be considered as a black box and should only be accessed via its (push, pull, query and resolve) methods.

* `query uri format`
* `package uri format` `<source_name>:<package hash>`
* `<package handle>` the package handle contains extra fields




## Datatypes and Functions

# <a name="shell"></a> Shell Functions

# <a name="expr"></a> Expression Syntax

# <a name="implementation_notes"></a> Implementation Notes


## <a href="initializer_function"></a> Initializer function

If you want to execute code only once for a function (e.g. create  a datastructure before executing the function or finding a package) you can use the Initializer Pattern. Which redefines the function itside itself after executing one time code. 

```
function(initalizing_function)
	# initialization code
	function(initializing_function)
		# actual function code
	endfunction()
	initializing_function(${ARGN})
	return_ans() # forwards the returned value
endfunction()
```

*Example*
```
function(global_counter)
	ref_set(global_counter_ref 0)
	function(global_counter)
		ref_get(global_counter_ref)
		ans(count)
		math(EXPR count "${count} + 1")
		ref_set(global_counter_ref ${count})
		return(${count})
	endfunction()
endfunction()
```


## <a href="pass_by_ref"></a> Passing By Ref



Passing a variable to a function can be done by value and or by reference.
```
function(byval var)
	message("${var}")
endfunction()

function(byref ref)
	message("${${ref}}")
endfunction()

set(some_val 3)

byval(${some_val}) # prints 3
byref(some_val) # prints 3

```

Passing 'by ref' is possible because a function inherits its parent scope. The problem with passing by ref is the following:

```
function(byref ref)
	set(val 1)
	message("${${ref}} ${val}")
endfunction()

set(val 2)
byref(val) #expected to print "2 1" but actually prints "2 2"
```

The `val` of the function's scope overwrites the `val` of the parent scope.
The workaround I chose was to mangle all variable names starting with a `__<function_name>_<varname>`  (however special care has to be taken with recursive functions). This stops accidental namespace collisions:

```
function(byref __byref_ref)
	set(__byref_val 1)
	message("${${__byref_ref}} ${__byref_val}")
endfunction()

```

So If you read some of the functions and see very strange variable names this is the explanation.




... more coming soon
