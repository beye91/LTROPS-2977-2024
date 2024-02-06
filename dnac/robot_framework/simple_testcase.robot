*** Settings ***
# Importing test libraries, resource files and variable files.
Library        pyats.robot.pyATSRobot
Library        genie.libs.robot.GenieRobot

*** Variables ***
# Define the pyATS testbed file to use for this run
${testbed}     cat8000v-0_testbed.yaml

*** Test Cases ***
# Creating test cases from available keywords.

Connect
    # Initializes the pyATS/Genie Testbed
    use testbed "${testbed}"

    # Connect to both device
    connect to device "cat8000v-0"

# Verify Bgp Neighbors
Verify the counts of Bgp 'established' neighbors for cat8000v-0
    verify count "1" "bgp neighbors" on device "cat8000v-0"

Verify the counts of Bgp 'routes' neighbors for cat8000v-0    
    verify count "2" "bgp routes" on device "cat8000v-0"

# Verify Interfaces
Verify the counts of 'up' Interace for cat8000v-0
    verify count "3" "interface up" on device "cat8000v-0" 