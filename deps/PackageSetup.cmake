set(RP_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/destdir/usr/local" CACHE STRING "")

set(RP_Boost_VERSION 1.70)

if (NOT RP_Boost_COMPONENTS)
    set(RP_Boost_COMPONENTS system iostreams filesystem thread log locale regex)
endif ()

set (RP_OpenVDB_COMPONENTS openvdb)
set (RP_wxWidgets_VERSION 3.1.1)

# set(RP_FORCE_DOWNLOADING ON CACHE BOOL "")
#set(RP_FIND_QUIETLY ON CACHE BOOL "")

#if(NOT WIN32)
#    list(REMOVE_ITEM RP_PACKAGES ZLIB)
#     # list(REMOVE_ITEM RP_PACKAGES wxWidgets)
#endif()

set(RP_ALL_TARGETS ${RP_PACKAGES})
