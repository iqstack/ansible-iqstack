# Testing Playbooks

The Ansible Playbooks here are used to install, configure, run (in most cases) and uninstall. There is always a lot room for improvement and we will try to do that as we go.

## Testing Platforms:
###Apache JMeter

###Rally (OpenStack Benchmarking/Scenario/SLA project)
Rally uses SQL Backend Catalog Services instead of the template backend service. There is an ansible playbook (install-rally-sql-keystone-backend.yml) loads the files/rally/keystone_populate.sh and runs it on the head nodes so that it populates the MySQL database and still continue to use the template backend catalog.
If change from template to SQL Backend upstream then this script is no longer needed.

###Tempest (OpenStack main gating testing suite)
Tempest can be setup by Rally to run under Rally's control (sorta). Meaning, Rally can run a validation test and record the results into Rally's database.
By default, Tempest will only record basic stats on a test if 'testr' or another one that produces a test stream output. You can run 'testr load < <output of your test>' to load into the .testrepository found in the root project directory.

####hosts:
The hosts file contains the types of hosts and the full inventory of the clusters being tested (or at least it should be :)). Add the hosts that you need by replacing the individual inventory.

####files (directory):
This directory contains all of the files that need to be moved to the given remote hosts. Each testing platform has it's own directory (i.e., files/jmeter, files/rally, files/tempest). We can expand on this in the future.

####group_vars:
Each group of remote hosts (including 'all') has their file(s) and variables in those files. Variables in the 'all' file are common among all hosts. Each other file should reflect the name of the cluster which is a group of groups in the hosts file.
Modify the needed values for your given cluster unless you keep the values of the variables the same. Review to make sure.

####host_vars:
They are present but we don't really use it right now.

####output:
This is the output directory of the Rally tests if you call 'rally-run-a-test.sh' or 'rally-output.yml'. This will be expanded to include a sub-directory of all of the testing platforms and their individual tests.
'output/rally/samples', 'output/tempest', 'output/jmeter' are the current output directories used.

####roles:
Standard ansible roles directory which we will move to use more soon.

####templates:
Holds all of the templates used by the given test platform and given test within that platform.

####.gitignore:
Add to this file if you wish for artifacts to be ignored by git such as IDE specific things (i.e, Pycharm IDE - .idea subdirectory)

####playbooks:
Each playbook conforms to a consistent naming for the given test platform so that it's easy to remember. Please make sure to follow the defacto standard to stay consistent.


####rally-run-a-test.sh:
This script has 4 variables passed in and in order (test_type, test_module, test_name, test_name_type). It runs the rally test and then outputs the test to an HTML file and automatically loads it in Chrome if running on a linux desktop or Mac.
Example usage: ./rally-run-a-test.sh scenarios keystone create-and-list-users json

The test above in the example is an actual test in rally which is found (in a typical install): /opt/rally/samples/scenarios/keystone/create-and-list-users.json. Each rally test has a json and yaml file that drives the runners, etc that are used for a given type of test.


###Mac Users
If you wish to run some of these tests from your mac and you designate given hosts as 'ansible_ssh_pass' instead of 'ansible_ssh_private_key' then you will need to run ./install_sshpass.sh found in the main part of this repo. Apple removed sshpass so you need to add it back to use ssh_pass type things from a mac.

####Footnote: Variables and Host/Group Names:
Host and Group Names have '-' seperating each word that segments the category it belongs to and the role. Variables are similar but use '_' instead as a separator. So, if you see a jinja2 scoped variable {{ jmeter-master-node }} you know it means it's a host/group name but if you see {{ jmeter_master_node }} then it's a variable name instead.

