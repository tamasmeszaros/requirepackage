if (NOT RP_Cereal_VERSION)
    set(RP_Cereal_VERSION 1.2.1) #should be the latest release
endif ()

rp_add_cmake_project(Cereal
    GIT_REPOSITORY https://github.com/USCiLab/cereal.git
    GIT_TAG v${RP_Cereal_VERSION}
    CMAKE_ARGS -DJUST_INSTALL_CEREAL=ON
)
