include(ExternalProject)

ExternalProject_Add(rp_Qhull
    # URL "https://github.com/qhull/qhull/archive/v7.3.2.tar.gz"
    # URL_HASH SHA256=619c8a954880d545194bc03359404ef36a1abd2dde03678089459757fd790cb0
    GIT_REPOSITORY  https://github.com/qhull/qhull.git
    GIT_TAG         7afedcc73666e46a9f1d74632412ebecf53b1b30 # v7.3.2 plus the mac build patch
    INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
    BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON 
        -DCMAKE_DEBUG_POSTFIX=d
)