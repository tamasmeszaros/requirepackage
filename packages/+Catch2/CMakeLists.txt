
rp_add_cmake_project(Catch2
    URL "https://github.com/catchorg/Catch2/archive/refs/tags/v2.13.9.zip"
    URL_HASH SHA256=860e3917f07d7ee75654f86900d50a03acf0047f6fe5ba31d437e1e9cda5b456
    CMAKE_ARGS
        -DCATCH_INSTALL_DOCS=OFF 
        -DCATCH_BUILD_TESTING=OFF
        -DCATCH_INSTALL_HELPERS=ON
)
