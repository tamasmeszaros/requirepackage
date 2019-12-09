require_dependency(MPFR)
require_dependency(Boost)
rp_add_cmake_project(
    CGAL
    GIT_REPOSITORY https://github.com/CGAL/cgal.git
    GIT_TAG "releases/CGAL-5.0"
)