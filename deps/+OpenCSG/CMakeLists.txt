require_dependency(GLEW VERSION 1.13.0 REQUIRED)
set(_cmake_args_line "")
if (BUILD_SHARED_LIBS)
set(_cmake_args_line CMAKE_ARGS -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON)
endif ()
rp_add_cmake_project(OpenCSG
    GIT_REPOSITORY https://github.com/floriankirsch/OpenCSG.git
    GIT_TAG 83e274457b46c9ad11a4ee599203250b1618f3b9 #v1.4.2
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt.in ./CMakeLists.txt
    ${_cmake_args_line}
)
