#!/bin/sh

RES=0

#yamllint . || RES=$?
ansible-lint -x 403 tests/test.yml || RES=$?

exit $RES



