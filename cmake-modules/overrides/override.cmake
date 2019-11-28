set(_q "")
if(${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
    set(_q QUIET)
endif()
find_package(${CMAKE_FIND_PACKAGE_NAME} ${${CMAKE_FIND_PACKAGE_NAME}_FIND_VERSION} CONFIG ${_q})

if(NOT ${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
    if (NOT ${CMAKE_FIND_PACKAGE_NAME}_FOUND)
        message(STATUS "Falling back to MODULE search for ${CMAKE_FIND_PACKAGE_NAME}...")
    else()
        message(STATUS "${CMAKE_FIND_PACKAGE_NAME} found in ${${CMAKE_FIND_PACKAGE_NAME}_DIR}")
    endif()
endif()

if (NOT ${CMAKE_FIND_PACKAGE_NAME}_FOUND)
    
    function(tmpscope_find)
        include(CMakeFindDependencyMacro)
        set(CMAKE_MODULE_PATH "")    
        find_dependency(${CMAKE_FIND_PACKAGE_NAME} ${${CMAKE_FIND_PACKAGE_NAME}_FIND_VERSION} MODULE ${_q})
        set(${CMAKE_FIND_PACKAGE_NAME}_FOUND ${${CMAKE_FIND_PACKAGE_NAME}_FOUND} PARENT_SCOPE)
    endfunction()

    tmpscope_find()
    
endif()
