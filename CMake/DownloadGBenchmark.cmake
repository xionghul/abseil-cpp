# Downloads and unpacks googletest at configure time.  Based on the instructions
# at https://github.com/google/googletest/tree/master/googletest#incorporating-into-an-existing-cmake-project

# Download the latest googlebenchmark from Github master
configure_file(
  ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt.in
  googlebenchmark-download/CMakeLists.txt
)

# Configure and build the downloaded googlebenckmark source
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googlebenchmark-download )
if(result)
  message(FATAL_ERROR "CMake step for googlebenchmark failed: ${result}")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googlebenchmark-download)
if(result)
  message(FATAL_ERROR "Build step for googlebenchmark failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googlebenchmark directly to our build. This defines the gtest and gtest_main
# targets.
add_subdirectory(${CMAKE_BINARY_DIR}/googlebenchmark-src
                 ${CMAKE_BINARY_DIR}/googlebenchmark-build
                 EXCLUDE_FROM_ALL)

