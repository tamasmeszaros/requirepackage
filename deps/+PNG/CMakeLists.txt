if (BUILD_SHARED_LIBS)
    set(PNG_SHARED ON)
    set(PNG_STATIC OFF)
else ()
    set(PNG_SHARED OFF)
    set(PNG_STATIC ON)
endif()

require_dependency(ZLIB)

rp_add_cmake_project(PNG 
    GIT_REPOSITORY https://github.com/glennrp/libpng.git 
    GIT_TAG v1.6.35
    CMAKE_ARGS
        -DPNG_SHARED=${PNG_SHARED}
        -DPNG_STATIC=${PNG_STATIC}
        -DPNG_TESTS=OFF
)
