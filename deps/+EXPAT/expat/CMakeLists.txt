cmake_minimum_required(VERSION 3.0)

add_library(expat
    xmlparse.c
    xmlrole.c
    xmltok.c
)

target_include_directories(expat PRIVATE ${PROJECT_SOURCE_DIR})

install(TARGETS expat
    RUNTIME DESTINATION bin 
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    INCLUDES DESTINATION include
)

install( 
    FILES
        ${PROJECT_SOURCE_DIR}/expat.h
        ${PROJECT_SOURCE_DIR}/expat_config.h
        ${PROJECT_SOURCE_DIR}/expat_external.h
    DESTINATION
        "include"
)
