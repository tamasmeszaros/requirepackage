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

rp_add_cmake_project(Blosc
    GIT_REPOSITORY https://github.com/Blosc/c-blosc.git
    GIT_TAG ${_blosc_tag}
    PATCH_COMMAND       ${GIT_EXECUTABLE} reset --hard && ${GIT_EXECUTABLE} clean -df &&
                        ${GIT_EXECUTABLE} apply --whitespace=nowarn ${CMAKE_CURRENT_SOURCE_DIR}/blosc-mods.patch
    CMAKE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DBUILD_SHARED=${_build_shared} 
        -DBUILD_STATIC=${_build_static}
        -DBUILD_TESTS=OFF 
        -DBUILD_BENCHMARKS=OFF 
        -DPREFER_EXTERNAL_ZLIB=ON
)
