#!/usr/bin/env bats

@test 'assert_file_exist()' {
  assert_file_exist login.sh
}
