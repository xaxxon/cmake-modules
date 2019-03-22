
# Input variables:
# V8_DIR is the base dir for the version to use.
#   - it should have an 'include' dir that has the proper include files for all builds of the version
#   - and directories for each build available, such as x64.release, x64.debug, etc. 
# V8_BUILD_TYPE is the build type to use, such as x64.release or x64.debug
#   - must be a directory in V8_DIR which contains the library and blob files from the corresponding build

# Output variables
# V8_INCLUDE_DIR is the location of the header files
# V8_LIB_DIR is the location of the library and blob files

# Make sure that V8_DIR directory is specified
IF (NOT V8_DIR)
    message(FATAL_ERROR "V8_DIR not specified, cannot find v8 library files")
ENDIF()

# and that it is a directory
IF (NOT IS_DIRECTORY ${V8_DIR})
    message(FATAL_ERROR "Specified V8_DIR '${V8_DIR}' isn't a directory")
ENDIF()


# Set the include directory
file(TO_CMAKE_PATH "${V8_DIR}/include" V8_INCLUDE_DIR)

# then sanity check that it at least has v8.h in it
IF (NOT EXISTS "${V8_INCLUDE_DIR}/v8.h")
    message(FATAL_ERROR "Could not find v8.h in ${V8_INCLUDE_DIR}")
ENDIF()



# make sure that V8_BUILD_TYPE is specified
IF (NOT V8_BUILD_TYPE)
   message(FATAL_ERROR "V8_BUILD_TYPE not specified, cannot determine build variant to use (e.g. x64.release)")
ENDIF()

# Set the library directory
FILE(TO_CMAKE_PATH "${V8_DIR}/${V8_BUILD_TYPE}" V8_LIB_DIR )

# make sure it's a directory
IF (NOT IS_DIRECTORY ${V8_LIB_DIR})
    message(FATAL_ERROR "Build type directory '${V8_LIB_DIR}' doesn't exist")
ENDIF()

# Each library file will be checked for below, so no need to sanity check the lib dir



# Enumeration of all v8 library files
set(V8_LIB_NAMES icui18n icuuc v8 v8_libbase v8_libplatform)

# Check that each library exists
FOREACH(LIB_NAME ${V8_LIB_NAMES})
    FIND_LIBRARY(FOUND_LIB_${LIB_NAME} ${LIB_NAME} PATHS ${V8_LIB_DIR})

    IF(NOT FOUND_LIB_${LIB_NAME})
        MESSAGE(FATAL_ERROR "LIBRARY: '${LIB_NAME}' NOT FOUND")
    ENDIF()

    add_library(v8::${LIB_NAME} UNKNOWN IMPORTED)
    set_target_properties(v8::${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION "${FOUND_LIB_${LIB_NAME}}"
            INTERFACE_COMPILE_OPTIONS ""
            INTERFACE_INCLUDE_DIRECTORIES ${V8_INCLUDE_DIR})

    LIST(APPEND V8_LIBS v8::${LIB_NAME})
ENDFOREACH(LIB_NAME)

# Enumeration of all the v8 blob files
set(V8_BLOB_FILES natives_blob.bin snapshot_blob.bin)

FOREACH(BLOB_NAME ${V8_BLOB_FILES})
    IF (NOT EXISTS "${V8_LIB_DIR}/${BLOB_NAME}")
        MESSAGE(FATAL_ERROR "Blob file ${BLOB_NAME} not found in ${V8_LIB_DIR}")
    ENDIF()
ENDFOREACH(BLOB_NAME)

MESSAGE("Found v8 headers in ${V8_INCLUDE_DIR} and libs in ${V8_LIB_DIR}")

