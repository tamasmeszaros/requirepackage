cmake_minimum_required(VERSION 3.0)
project(GLEW)

find_package(OpenGL REQUIRED)

add_library(glew src/glew.c)
target_include_directories(glew PRIVATE include/)
target_link_libraries(glew OpenGL::GL)

install(TARGETS glew
    RUNTIME DESTINATION bin 
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    INCLUDES DESTINATION include
)

install( 
    FILES
        ${PROJECT_SOURCE_DIR}/include/GL/glew.h
        ${PROJECT_SOURCE_DIR}/include/GL/wglew.h
        ${PROJECT_SOURCE_DIR}/include/GL/glxew.h
    DESTINATION
        "include/GL"
)

add_library(GLEW INTERFACE)
target_link_libraries(GLEW INTERFACE glew)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"     
    VERSION 1.13.0
    COMPATIBILITY AnyNewerVersion
)

install(TARGETS glew GLEW
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION bin 
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  INCLUDES DESTINATION include)

export(EXPORT ${PROJECT_NAME}Targets 
       FILE "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake" 
       NAMESPACE ${PROJECT_NAME}:: )

set(ConfigPackageLocation lib/cmake/${PROJECT_NAME})

install(EXPORT ${PROJECT_NAME}Targets
  FILE
    "${PROJECT_NAME}Config.cmake"
  NAMESPACE
    ${PROJECT_NAME}::
  DESTINATION
    ${ConfigPackageLocation}
)

install(
    FILES
      "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION
      ${ConfigPackageLocation}
)
