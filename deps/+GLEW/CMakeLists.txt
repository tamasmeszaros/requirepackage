require_dependency(OpenGL REQUIRED)

rp_add_cmake_project(GLEW
  # GIT_REPOSITORY https://github.com/nigels-com/glew.git
  # GIT_TAG 3a8eff7 # 2.1.0
  SOURCE_DIR          ${CMAKE_CURRENT_LIST_DIR}/glew
)
