require_dependency(ZLIB)
require_dependency(PNG)
require_dependency(OpenGL)

rp_add_cmake_project(TIFF
    GIT_REPOSITORY https://gitlab.com/libtiff/libtiff.git
    GIT_TAG v4.1.0
)
