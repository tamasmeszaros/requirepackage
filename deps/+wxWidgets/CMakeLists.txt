include(ExternalProject)

if (NOT RP_wxWidgets_VERSION)
   set(RP_wxWidgets_VERSION 3.1.2) # should be the latest release
endif()

set(_wx_git_tag v${RP_wxWidgets_VERSION})

if(WIN32 OR RP_wxWidgets_VERSION VERSION_EQUAL 3.1.1)
    set(_wx_git_tag v3.1.1-patched_tm)
endif()

set(_patch_command "")
set(_wx_toolkit "")
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # set(_patch_command  ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/wxwidgets-pngprefix.h" src/png/pngprefix.h)
    set(_wx_toolkit "-DwxBUILD_TOOLKIT=gtk2")
endif()

require_dependency(ZLIB)
require_dependency(EXPAT)

if (WIN32)
    ExternalProject_Add(rp_wxWidgets
        GIT_REPOSITORY "https://github.com/prusa3d/wxWidgets"
        GIT_TAG ${_wx_git_tag}
        INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
        BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
        PATCH_COMMAND "${_patch_command}"
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
            -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
            -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
            -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} 
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DwxBUILD_PRECOMP=OFF
            ${_wx_toolkit}
            -DwxUSE_DETECT_SM=OFF
            -DwxUSE_UNICODE=ON
            -DwxUSE_OPENGL=ON
            -DwxUSE_LIBPNG=builtin
            -DwxUSE_ZLIB=sys
            -DwxUSE_REGEX=builtin
            -DwxUSE_LIBPNG=builtin
            -DwxUSE_LIBXPM=builtin
            -DwxUSE_LIBJPEG=builtin
            -DwxUSE_LIBTIFF=builtin
            -DwxUSE_EXPAT=sys
            -DCMAKE_DEBUG_POSTFIX=d
    )
else() # Temporary solution
    set (_wx_flags "")
    if (NOT BUILD_SHARED_LIBS)
        set(_wx_flags --disable-shared )
    endif ()
    if (APPLE)
        set(_wx_toolkit --with-osx_cocoa --with-macosx-sdk=${CMAKE_OSX_SYSROOT} 
                        "--with-macosx-version-min=${DEP_OSX_TARGET}")
    else()
        set(_wx_toolkit --with-gtk=2)
    endif()

    include(ProcessorCount)
    ProcessorCount(NPROC)
    
    ExternalProject_Add(rp_wxWidgets
        GIT_REPOSITORY "https://github.com/prusa3d/wxWidgets"
        GIT_TAG ${_wx_git_tag}
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ./configure
            "--prefix=${CMAKE_INSTALL_PREFIX}"
            ${_wx_flags}
            ${_wx_toolkit}
            --with-opengl
            --enable-unicode
            --enable-graphics_ctx
            --with-regex=builtin
            --with-libpng=builtin
            --with-libxpm=builtin
            --with-libjpeg=builtin
            --with-libtiff=builtin
            --with-zlib=sys
            --with-expat=sys
            --disable-precomp-headers
            --enable-debug_info
            --enable-debug_gdb
            --disable-debug
            --disable-debug_flag
        BUILD_COMMAND make "-j${NPROC}" && make -C locale allmo
        INSTALL_COMMAND make install
    )
endif()
