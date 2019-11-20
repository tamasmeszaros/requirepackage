list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../cmake-modules)
set(DESTDIR "${CMAKE_CURRENT_BINARY_DIR}/destdir" CACHE PATH "Destination directory")
set(CMAKE_INSTALL_PREFIX "${DESTDIR}/usr/local" CACHE STRING "" FORCE)

set(RP_Boost_VERSION 1.70)

if (NOT RP_Boost_COMPONENTS)
    set(RP_Boost_COMPONENTS system iostreams filesystem thread log locale regex)
endif ()

set(BUILD_SHARED_LIBS OFF CACHE BOOL "")
set(RP_FORCE_DOWNLOADING ON CACHE BOOL "")
set(RP_FIND_QUIETLY ON CACHE BOOL "")

# if(NOT WIN32)
#     list(REMOVE_ITEM RP_PACKAGES ZLIB)
#     # list(REMOVE_ITEM RP_PACKAGES wxWidgets)
# endif()

set(RP_ALL_TARGETS ${RP_PACKAGES})
