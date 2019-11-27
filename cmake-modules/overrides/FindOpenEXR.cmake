
include(CMakeFindDependencyMacro)
find_dependency(IlmBase)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../)
find_dependency(OpenEXR ${OpenEXR_FIND_VERSION} COMPONENTS ${OpenEXR_FIND_COMPONENTS})