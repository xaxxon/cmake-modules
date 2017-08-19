
# Get the target triple for the current host by calling clang -v and then stripping out the Target: value from its output

# $ clang -v
# clang version 4.0.0 (tags/RELEASE_400/final)
# Target: x86_64-apple-darwin15.6.0
# Thread model: posix
# InstalledDir: /Users/xaxxon/Downloads/clang+llvm-4.0.0-x86_64-apple-darwin/bin


if(UNIX)
    # Store all the results of running `clang -v` into CLANG_VERSION_INFO
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -v ERROR_VARIABLE CLANG_VERSION_INFO)

    # Parse out the target triple from the raw output of `clang -v`
    # cmake regexes are missing a lot of common syntax options for regexes
    string(REGEX REPLACE ".*Target:[\r\n\t ]*([^\r\n\t]*).*Thread model.*" "\\1" TARGET_TRIPLE ${CLANG_VERSION_INFO})


    message(STATUS "clang -target value: '${TARGET_TRIPLE}'")
endif()