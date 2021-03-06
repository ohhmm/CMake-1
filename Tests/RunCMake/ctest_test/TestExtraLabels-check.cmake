file(READ "${RunCMake_TEST_BINARY_DIR}/Testing/TAG" _tag)
string(REGEX REPLACE "^([^\n]*)\n.*$" "\\1" _date "${_tag}")
file(READ "${RunCMake_TEST_BINARY_DIR}/Testing/${_date}/Test.xml" _test_contents)

# Check labels.
STRING(REGEX MATCHALL [[<Label>label1</Label>]] matches "${_test_contents}")
list(LENGTH matches n_matches)
if(NOT n_matches EQUAL 1)
  string(APPEND RunCMake_TEST_FAILED  "expected 1 match for label1, found ${n_matches}")
endif()
STRING(REGEX MATCHALL [[<Label>label2</Label>]] matches "${_test_contents}")
list(LENGTH matches n_matches)
if(NOT n_matches EQUAL 1)
  string(APPEND RunCMake_TEST_FAILED  "expected 1 match for label2, found ${n_matches}")
endif()
STRING(REGEX MATCHALL [[<Label>label3</Label>]] matches "${_test_contents}")
list(LENGTH matches n_matches)
if(NOT n_matches EQUAL 1)
  string(APPEND RunCMake_TEST_FAILED  "expected 1 match for label3, found ${n_matches}")
endif()

# Check test output.
if(NOT _test_contents MATCHES "before")
  string(APPEND RunCMake_TEST_FAILED "Could not find expected string 'before' in Test.xml")
endif()
if(NOT _test_contents MATCHES "after")
  string(APPEND RunCMake_TEST_FAILED "Could not find expected string 'after' in Test.xml")
endif()
