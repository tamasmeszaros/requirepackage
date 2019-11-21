if(CMAKE_VERSION VERSION_GREATER 3.10)
    include(CMakeFindDependencyMacro)
    find_dependency(Boost ${PACKAGE_FIND_VERSION} CONFIG COMPONENTS ${Boost_FIND_COMPONENTS})
endif()