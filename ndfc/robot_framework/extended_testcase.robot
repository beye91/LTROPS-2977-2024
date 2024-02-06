*** Settings ***
# Importing test libraries, resource files and variable files.
Library         pyats.robot.pyATSRobot
Library         unicon.robot.UniconRobot
Library         genie.libs.robot.GenieRobot

*** Variables ***
# Define the pyATS testbed file to use for this run
${testbed}              n9000v-0_testbed.yaml
${vlan}                 105
${branch_client}        172.18.205.101
${datacenter_client}    172.18.105.101
${source_interface}     172.18.105.2

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

Validate VLAN on device
    ${output}=      parse "show vlan" on device "nxos9000-0"
    ${response}=      dq query    data=${output}    filters=contains('datacenter_server_net')
    Should Not Be Empty    ${response}    msg=VLAN not found

Validate VLAN interface on device
    ${output}=      parse "show interface vlan ${vlan}" on device "nxos9000-0"
    Should be Equal    ${output}[Vlan${vlan}][link_state]    up 
    Should Not Be Empty    ${output}    msg=VLAN interface not found

Validate reachability of branch client
    ${output}=      parse "ping ${branch_client} source ${source_interface} count 10" on device "nxos9000-0"
    ${success_rate}=    Set Variable    ${output}[ping][statistics][success_rate_percent]
    Log    Success rate: ${success_rate}%
    Should Be Equal as Numbers    ${success_rate}    100.0    msg=Ping success rate is not 100%

Validate reachability of datacenter client
    ${output}=      parse "ping ${datacenter_client} source ${source_interface} count 10" on device "nxos9000-0"    
    ${success_rate}=    Set Variable    ${output}[ping][statistics][success_rate_percent]
    Log    Success rate: ${success_rate}%
    Should Be Equal as Numbers    ${success_rate}    100.0    msg=Ping success rate is not 100%