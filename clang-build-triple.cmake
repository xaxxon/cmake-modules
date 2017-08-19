
if(UNIX)
	# Get the target triple for the current host by calling clang -v and then stripping out the Target: value from its output
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -v ERROR_VARIABLE CLANG_VERSION_INFO)
    string(REGEX REPLACE ".*Target:[\r\n\t ]*([^\r\n\t]*).*Thread model.*" "\\1" TARGET_TRIPLE ${CLANG_VERSION_INFO})
    message(STATUS "TARGET TRIPLE: '${TARGET_TRIPLE}' END")
endif()