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

client = {
  url: '',
  user: '',
  password: ''
}

oneview_ethernet_network 'Eth1' do
  data ({
    vlanId:  '1001',
    purpose:  'General',
    smartLink:  false,
    privateNetwork:  false
  })
  client client
  action :create
end

oneview_ethernet_network 'Eth1' do
  client client
  action :delete
end

## Bulk creation ##
oneview_ethernet_network 'BulkEth' do
  client client
  data ({
    vlanIdRange: '10-12',
    purpose: 'General',
    smartLink: false,
    privateNetwork: false
  })
  action :bulk_create
end

oneview_ethernet_network 'BulkEth_10' do
  client client
  action :delete
end

oneview_ethernet_network 'BulkEth_11' do
  client client
  action :delete
end

oneview_ethernet_network 'BulkEth_12' do
  client client
  action :delete
end
