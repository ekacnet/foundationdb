find_package(msgpack 3.3.0 CONFIG QUIET)
if(NOT msgpack_FOUND)
    # Try Homebrew name
    find_package(msgpack-c 6.1.0 CONFIG REQUIRED)
    set(msgpack_FOUND TRUE)
  else()
    add_library(msgpack-c INTERFACE)
    target_include_directories(msgpack-c INTERFACE "${msgpack_DIR}/include")
    set(msgpack-c_FOUND TRUE)
endif()

if(msgpack-c_FOUND)
  message(STATUS "Found msgpack:  ${MSGPACK_TARGET}")
else()
  add_library(msgpack-c INTERFACE)
  message(FATAL_ERROR "do not use external downloaded msgpack")
  include(ExternalProject)
  ExternalProject_add(msgpackProject
    URL "https://github.com/msgpack/msgpack-c/releases/download/cpp-3.3.0/msgpack-3.3.0.tar.gz"
    URL_HASH SHA256=6e114d12a5ddb8cb11f669f83f32246e484a8addd0ce93f274996f1941c1f07b
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
  )

  ExternalProject_Get_property(msgpackProject SOURCE_DIR)
  target_include_directories(msgpack SYSTEM INTERFACE "${SOURCE_DIR}/include")
  add_dependencies(msgpack msgpackProject)
endif()
