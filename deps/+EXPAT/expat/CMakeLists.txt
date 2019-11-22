cmake_minimum_required(VERSION 3.0)

project(EXPAT)

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

add_library(EXPAT INTERFACE)
target_link_libraries(EXPAT INTERFACE expat)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"     
    VERSION 1.95
    COMPATIBILITY AnyNewerVersion
)

install(TARGETS expat EXPAT
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

