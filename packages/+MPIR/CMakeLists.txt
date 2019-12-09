ExternalProject_Add(rp_MPIR
    GIT_REPOSITORY  https://github.com/wbhart/mpir.git
    GIT_TAG         mpir-3.0.0
    BUILD_IN_SOURCE ON 
    CONFIGURE_COMMAND ./autogen.sh && ./configure "--enable-gmpcompat" "--prefix=${CMAKE_INSTALL_PREFIX}"
    BUILD_COMMAND     make
    INSTALL_COMMAND   make install
)