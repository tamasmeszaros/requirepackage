cmake_minimum_required(VERSION 3.1)

project(RequirePackageExample)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake-modules)

include(RequirePackage)

message(STATUS "CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}")

require_package(ZLIB VERSION 1.2.8)
require_package(NLopt VERSION 2.6 REQUIRED)
require_package(Clipper QUIET)
require_package(OpenCSG REQUIRED)
# require_package(EXPAT REQUIRED)
