require_dependency(MPIR)

if(NOT MSVC)
    ExternalProject_Add(rp_MPFR
        URL https://www.mpfr.org/mpfr-current/mpfr-4.0.2.tar.bz2
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX} --with-gmp=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make -j
        INSTALL_COMMAND make install
    )
else()
# ExternalProject_Add(rp_MPFR
#         URL https://github.com/BrianGladman/mpfr
#         GIT_TAG 9fe9541
#         BUILD_IN_SOURCE ON
#         CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=${CMAKE_INSTALL_PREFIX}
#         BUILD_COMMAND make -j
#         INSTALL_COMMAND make install
#     )
endif()