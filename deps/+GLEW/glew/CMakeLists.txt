cmake_minimum_required(VERSION 3.0)
project(GLEW)

add_library(glew src/glew.c)
target_include_directories(glew PRIVATE include/)

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