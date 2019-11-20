include(ExternalProject)

if (NOT RP_Cereal_VERSION)
    set(RP_Cereal_VERSION 1.2.1) #should be the latest release
endif ()

ExternalProject_Add(rp_Cereal
    GIT_REPOSITORY https://github.com/USCiLab/cereal.git
    GIT_TAG v${RP_Cereal_VERSION}
    INSTALL_DIR     ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS
        -DJUST_INSTALL_CEREAL=ON
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
)
