# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

my_client = {
  url: '',
  user: '',
  password: ''
}

# Example: Add server hardware to OneView for management
# Note that the default action is :add_if_missing, and there is no :add action available.
# This is because ServerHardware resources cannot be updated after being added.
oneview_server_hardware '172.18.6.4' do
  client my_client
  data(
    hostname: '172.18.6.4',
    username: 'user',
    password: 'password',
    licensingIntent: 'OneViewStandard',
    configurationState: 'Monitored'
  )
end

# Example: Make sure the server is powered on
# Note: The data hash is not required or used with this action or any of the following.
oneview_server_hardware '172.18.6.4' do
  client my_client
  power_state 'on'
  action :set_power_state
end

# Example: Refresh the server hardware to fix configuration issues
oneview_server_hardware '172.18.6.4' do
  client my_client
  action :refresh
end

# Example: Refresh the server hardware to fix configuration issues, and pass in refresh_options.
# See the API docs for other options (these will get passed into the request body)
oneview_server_hardware '172.18.6.4' do
  client my_client
  refresh_options(
    refreshActions: [:ClearSyslog, :PowerOff]
  )
  action :refresh
end

# Example: Update the iLO firmware on a physical server to a minimum ILO firmware
# version required by OneView to manage the server
oneview_server_hardware '172.18.6.4' do
  client my_client
  action :update_ilo_firmware
end

# Example: Remove the server hardware from OneView
oneview_server_hardware '172.18.6.4' do
  client my_client
  action :remove
end
