#
# Cookbook Name:: oneview_test
# Recipe:: volume_create
#
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
#

oneview_volume 'VOL1' do
  client node['oneview_test']['client']
  data(
    description: 'Volume created by Chef',
    shareable: true,
    provisionType: 'Thin',
    provisionedCapacity: 1024 * 1024 * 1024 * 2 # 2GB
  )
  storage_system_name 'StorageSystem1'
  storage_pool 'Pool1'
  snapshot_pool 'Pool2'
  volume_template 'Template1'
end
