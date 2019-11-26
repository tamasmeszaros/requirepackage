if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
  include(ProcessorCount)
  ProcessorCount(NPROC)
  
  ExternalProject_Add(rp_OpenSSL
      EXCLUDE_FROM_ALL ON
      URL https://www.openssl.org/source/openssl-1.1.1d.tar.gz
      URL_HASH SHA256=1e3a91bc1f9dfce01af26026f856e064eab4c8ee0a8f457b5ae30b40b8b711f2
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

rp_add_cmake_project(CURL
  GIT_REPOSITORY      https://github.com/curl/curl.git
  GIT_TAG             curl-7_58_0
  PATCH_COMMAND       ${GIT_EXECUTABLE} checkout -f -- . && git clean -df && 
                      ${GIT_EXECUTABLE} apply --whitespace=fix ${CMAKE_CURRENT_SOURCE_DIR}/curl-mods.patch
  CMAKE_ARGS
    -DBUILD_TESTING:BOOL=OFF
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DCURL_STATICLIB=${_curl_static}
    ${_curl_platform_flags}
)
