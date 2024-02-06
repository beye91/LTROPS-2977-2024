*** Settings ***
# Importing test libraries, resource files and variable files.
Library        pyats.robot.pyATSRobot
Library        genie.libs.robot.GenieRobot

*** Variables ***
# Define the pyATS testbed file to use for this run
${testbed}     n9000v-0_testbed.yaml

*** Test Cases ***
# Creating test cases from available keywords.

Connect
    # Initializes the pyATS/Genie Testbed
    use testbed "${testbed}"

    # Connect to both device
    connect to device "nxos9000-0"

# Verify VPC domain
Verify that the VPC domain is up on nxos9000-0
        ${output}=      parse "show vpc" on device "nxos9000-0"
        ${response}=      dq query    data=${output}    filters=contains('peer adjacency formed ok')
        Should Not Be Empty    ${response}    msg=VPC not up

# Verify Interfaces
Verify the counts of 'up' Interace for nxos9000-0
    verify count "6" "interface up" on device "nxos9000-0" 