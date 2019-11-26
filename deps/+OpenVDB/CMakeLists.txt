require_dependency(Blosc)
require_dependency(TBB)
require_dependency(Boost)
require_dependency(OpenEXR)

if(BUILD_SHARED_LIBS)
    set(_build_shared ON)
    set(_build_static OFF)
else()
    set(_build_shared OFF)
    set(_build_static ON)
endif()

set(_openvdb_tag 
aebaf8d95be5e57fd33949281ec357db4a576c2e #v6.2.1
)

rp_add_cmake_project(OpenVDB
    GIT_REPOSITORY https://github.com/AcademySoftwareFoundation/openvdb.git
    GIT_TAG ${_openvdb_tag}
    PATCH_COMMAND       ${GIT_EXECUTABLE} reset --hard && ${GIT_EXECUTABLE} clean -df &&
                        ${GIT_EXECUTABLE} apply --whitespace=nowarn ${CMAKE_CURRENT_SOURCE_DIR}/openvdb-mods.patch
    CMAKE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON 
        -DOPENVDB_BUILD_PYTHON_MODULE=OFF
        # -DCMAKE_CXX_FLAGS=-D_USE_MATH_DEFINES
        -DUSE_BLOSC=ON
        -DOPENVDB_CORE_SHARED=${_build_shared} 
        -DOPENVDB_CORE_STATIC=${_build_static}
        -DTBB_STATIC=${_build_static}
        -DOPENVDB_BUILD_VDB_PRINT=ON
        -DDISABLE_DEPENDENCY_VERSION_CHECKS=ON # Centos6 has old zlib
)
