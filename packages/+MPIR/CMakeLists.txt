set(_libtype "")
if (BUILD_SHARED_LIBS)
    set(_libtype "--enable-shared=yes --enable-static=no")
else ()
    set(_libtype "--enable-shared=no --enable-static=yes")
endif ()
ExternalProject_Add(rp_MPIR
    GIT_REPOSITORY  https://github.com/wbhart/mpir.git
    GIT_TAG         mpir-3.0.0
    PATCH_COMMAND   ${GIT_EXECUTABLE} checkout -f -- . && git clean -df && 
                    ${GIT_EXECUTABLE} apply --whitespace=fix ${CMAKE_CURRENT_SOURCE_DIR}/mpir-mods.patch
    BUILD_IN_SOURCE ON 
    CONFIGURE_COMMAND ./autogen.sh && ./configure ${_libtype} "--enable-gmpcompat" "--prefix=${CMAKE_INSTALL_PREFIX}"
    BUILD_COMMAND     make -j
    INSTALL_COMMAND   make install
)