#!/usr/bin/env bash
# Example: ./rally-run-a-test.sh scenarios keystone create-and-list-users json
# For now - output directory is hard coded but in the future we could run this through the jinja2 template engine to fix it.

set -e

if [ "$#" -ne 4 ]; then
    echo "Must pass in 4 parameters in order: <test_type> <test_module> <test_name> <test_name_type>"
    exit 1
fi

ansible-playbook rally-run-test.yml -e "test_type=$1 test_module=$2 test_name=$3 test_name_type=$4"

ansible-playbook rally-output.yml -e "file_src=$1-$2-$3.html file_dest=$1-$2-$3.html"

open -a Google\ Chrome output/rally/samples/$1-$2-$3.html

