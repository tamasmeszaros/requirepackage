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

  list(APPEND RP_PACKAGES "OpenSSL")
  require_dependency(OpenSSL)
endif ()

set(_curl_platform_flags "")
if (APPLE)
    set(_curl_platform_flags 
        -DCMAKE_USE_DARWINSSL:BOOL=ON 
        -DCMAKE_USE_OPENSSL:BOOL=OFF
        -DCURL_CA_PATH:STRING=none
        -DENABLE_IPV6:BOOL=ON
        # -DENABLE_THREADED_RESOLVER:BOOL=ON
        -DCURL_DISABLE_LDAP:BOOL=ON
        -DCURL_DISABLE_LDAPS:BOOL=ON
        -DENABLE_MANUAL:BOOL=OFF
        # -DCURL_DISABLE_RTSP:BOOL=ON
        # -DCURL_DISABLE_DICT:BOOL=ON
        # -DCURL_DISABLE_TELNET:BOOL=ON
        # -DCURL_DISABLE_POP3:BOOL=ON
        # -DCURL_DISABLE_TELNET:BOOL=ON
        # -DCURL_DISABLE_IMAP:BOOL=ON
        # -DCURL_DISABLE_IMAP:BOOL=ON
        # -DCURL_DISABLE_GOPHER:BOOL=ON
        # -DCURL_DISABLE_CRYPTO_AUTH:BOOL=ON
        # -DCMAKE_USE_GSSAPI:BOOL=OFF
        # -DCMAKE_USE_LIBSSH2:BOOL=OFF
        # -DUSE_NGHTTP2:BOOL=OFF

        # --enable-versioned-symbols
        
        # --disable-imap
        # --disable-smb
        # --disable-smtp
        # --disable-gopher
        # --disable-crypto-auth
        # --without-gssapi
        # --without-libpsl
        # --without-libidn2
        # --without-gnutls
        # --without-polarssl
        # --without-mbedtls
        # --without-cyassl
        # --without-nss
        # --without-axtls
        # --without-brotli
        # --without-libmetalink
        # --without-libssh
        # --without-libssh2
        # --without-librtmp
        # --without-nghttp2
        # --without-zsh-functions-dir
        )
endif ()

require_dependency(ZLIB)

if (BUILD_SHARED_LIBS)
  set(_curl_static OFF)
else()
  set(_curl_static ON)
endif()

Externalproject_Add( 
  rp_CURL
  GIT_REPOSITORY      https://github.com/curl/curl.git
  GIT_TAG             curl-7_58_0
  INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
  BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
  PATCH_COMMAND       ${GIT_EXECUTABLE} checkout -f -- . && git clean -df && 
                      ${GIT_EXECUTABLE} apply --whitespace=fix ${CMAKE_CURRENT_SOURCE_DIR}/curl-mods.patch
  CMAKE_ARGS         
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_DEBUG_POSTFIX=d
    -DBUILD_TESTING:BOOL=OFF
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DCURL_STATICLIB=${_curl_static}
    ${_curl_platform_flags}
)