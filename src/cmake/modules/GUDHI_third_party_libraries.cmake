# This files manage third party libraries required by GUDHI

find_package(Boost 1.56.0 QUIET OPTIONAL_COMPONENTS filesystem unit_test_framework program_options)

# Boost_FOUND is not reliable
if(NOT Boost_VERSION)
  message(FATAL_ERROR "NOTICE: This program requires Boost and will not be compiled.")
endif(NOT Boost_VERSION)

find_package(GMP)
if(GMP_FOUND)
  INCLUDE_DIRECTORIES(${GMP_INCLUDE_DIR})
  find_package(GMPXX)
  if(GMPXX_FOUND)
    INCLUDE_DIRECTORIES(${GMPXX_INCLUDE_DIR})
  endif()
endif()

# In CMakeLists.txt, when include(${CGAL_USE_FILE}), CMAKE_CXX_FLAGS are overwritten.
# cf. http://doc.cgal.org/latest/Manual/installation.html#title40
# A workaround is to include(${CGAL_USE_FILE}) before adding "-std=c++11".
# A fix would be to use https://cmake.org/cmake/help/v3.1/prop_gbl/CMAKE_CXX_KNOWN_FEATURES.html
# or even better https://cmake.org/cmake/help/v3.1/variable/CMAKE_CXX_STANDARD.html
# but it implies to use cmake version 3.1 at least.
find_package(CGAL QUIET)

# Only CGAL versions > 4.11 supports what Gudhi uses from CGAL
if (CGAL_FOUND AND CGAL_VERSION VERSION_LESS 4.11.0)
  message("++ CGAL version ${CGAL_VERSION} is considered too old to be used by Gudhi.")
  unset(CGAL_FOUND)
  unset(CGAL_VERSION)
endif()

if(CGAL_FOUND)
  message(STATUS "CGAL version: ${CGAL_VERSION}.")
  include( ${CGAL_USE_FILE} )
endif()

set(CGAL_WITH_EIGEN3_VERSION 0.0.0)
find_package(Eigen3 3.1.0)
if (EIGEN3_FOUND)
  include( ${EIGEN3_USE_FILE} )
  set(CGAL_WITH_EIGEN3_VERSION ${CGAL_VERSION})
endif (EIGEN3_FOUND)

# BOOST ISSUE result_of vs C++11
add_definitions(-DBOOST_RESULT_OF_USE_DECLTYPE)
# BOOST ISSUE with Libraries name resolution under Windows
add_definitions(-DBOOST_ALL_NO_LIB)
# problem with Visual Studio link on Boost program_options
add_definitions( -DBOOST_ALL_DYN_LINK )
# problem on Mac with boost_system and boost_thread
add_definitions( -DBOOST_SYSTEM_NO_DEPRECATED )

message(STATUS "boost include dirs:" ${Boost_INCLUDE_DIRS})
message(STATUS "boost library dirs:" ${Boost_LIBRARY_DIRS})