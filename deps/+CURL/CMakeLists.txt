include(ExternalProject)

if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
  include(ProcessorCount)
  ProcessorCount(NPROC)
  
  ExternalProject_Add(rp_OpenSSL
      EXCLUDE_FROM_ALL ON
      URL "https://github.com/openssl/openssl/archive/OpenSSL_1_1_0g.tar.gz"
      URL_HASH SHA256=8e9516b8635bb9113c51a7b5b27f9027692a56b104e75b709e588c3ffd6a0422
      BUILD_IN_SOURCE ON
      CONFIGURE_COMMAND ./config
          "--prefix=${CMAKE_INSTALL_PREFIX}"
          no-shared
          no-ssl3-method
          no-dynamic-engine
          -Wa,--noexecstack
      BUILD_COMMAND make depend && make "-j${NPROC}"
      INSTALL_COMMAND make install_sw
  )

  require_dependency(OpenSSL)
endif ()

require_dependency(ZLIB)

Externalproject_Add( 
  rp_CURL
  GIT_REPOSITORY      https://github.com/curl/curl.git
  GIT_TAG             curl-7_67_0
  INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
  BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
  CMAKE_ARGS         
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_DEBUG_POSTFIX=d
    -DBUILD_TESTING:BOOL=OFF
)