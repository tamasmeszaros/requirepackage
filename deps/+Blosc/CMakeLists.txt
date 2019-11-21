include(ExternalProject)

if(BUILD_SHARED_LIBS)
    set(_build_shared ON)
    set(_build_static OFF)
else()
    set(_build_shared OFF)
    set(_build_static ON)
endif()

require_dependency(ZLIB)

set(_blosc_tag 
e63775855294b50820ef44d1b157f4de1cc38d3e #v1.17.0
)

ExternalProject_Add(rp_Blosc
    GIT_REPOSITORY https://github.com/Blosc/c-blosc.git
    GIT_TAG ${_blosc_tag}
    INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
    BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
    PATCH_COMMAND       ${GIT_EXECUTABLE} reset --hard ${_blosc_tag} && ${GIT_EXECUTABLE} clean -df && 
                        ${GIT_EXECUTABLE} am ${CMAKE_CURRENT_SOURCE_DIR}/blosc-mods.patch
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON 
        -DCMAKE_DEBUG_POSTFIX=d
        -DBUILD_SHARED=${_build_shared} 
        -DBUILD_STATIC=${_build_static}
        -DBUILD_TESTS=OFF 
        -DBUILD_BENCHMARKS=OFF 
        -DPREFER_EXTERNAL_ZLIB=ON
)
