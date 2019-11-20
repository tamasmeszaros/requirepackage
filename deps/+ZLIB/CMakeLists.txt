include(ExternalProject)

Externalproject_Add( 
  rp_ZLIB
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.2.11
  INSTALL_DIR         ${CMAKE_INSTALL_PREFIX}
  BINARY_DIR          ${RP_PACKAGE_BUILD_DIR}
  PATCH_COMMAND       ${GIT_EXECUTABLE} checkout -f -- . && git clean -df && 
                      ${GIT_EXECUTABLE} apply --whitespace=fix ${CMAKE_CURRENT_SOURCE_DIR}/0001-Respect-BUILD_SHARED_LIBS.patch
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} 
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DSKIP_INSTALL_FILES=ON         # Prevent installation of man pages et al.
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON 
    -DCMAKE_DEBUG_POSTFIX=d
)

