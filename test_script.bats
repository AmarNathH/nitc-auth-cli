#!/usr/bin/env bats

# Don't edit this, this is is a unit test script

@test "Login script exists" {
   [ -e login.sh ]
}

@test "Logout script exists" {
   [ -e logout.sh ]
}
