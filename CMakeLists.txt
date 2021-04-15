cmake_minimum_required(VERSION 3.5)

project(windows_pip_github_actions)

find_package(CGAL)
message("++ CGAL version ${CGAL_VERSION}")
message("++ CGAL found ${CGAL_FOUND}")
message("++ CGAL dir ${CGAL_DIR}")
message("++ CGAL root ${CGAL_ROOT}")

#list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/src/cmake/modules/")

# For third parties libraries management - To be done last as CGAL updates CMAKE_MODULE_PATH
#include(GUDHI_third_party_libraries NO_POLICY_SCOPE)

#include(GUDHI_compilation_flags)

