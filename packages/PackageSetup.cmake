set(RP_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/destdir/usr/local" CACHE STRING "")
set(RP_DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/downloads CACHE STRING "Dependencies download location")

# TODO: set package option defaults

set(RP_ALL_TARGETS ${RP_PACKAGES})
