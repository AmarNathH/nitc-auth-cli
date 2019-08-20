#!/usr/bin/env bats

@test "Check if all the required scripts are there" {
	assert_exists "login.sh"
}
