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

OneviewCookbook::ResourceBaseProperties.load(self)

default_action :add

action_class do
  include OneviewCookbook::Helper
  include OneviewCookbook::ResourceBase
end

action :add do
  item = load_resource
  temp = Marshal.load(Marshal.dump(item.data))

  if item.exists?
    item.retrieve!
    if item.like? temp
      Chef::Log.info("#{resource_name} '#{name}' is up to date")
    else
      Chef::Log.info "Editing #{resource_name} '#{name}'"
      converge_by "#{resource_name} '#{name}' was edited." do
        item.update(temp)
      end
    end
  else
    item.data.delete('name')
    Chef::Log.info "Adding #{resource_name} '#{name}'"
    converge_by "Added #{resource_name} '#{name}'" do
      item.add
    end
  end
end

action :add_if_missing do
  item = load_resource
  unless item.exists?
    item.data.delete('name')
    add_if_missing(item)
  end
end

action :edit_credentials do
  item = load_resource
  temp = {}
  temp['credentials'] = Marshal.load(Marshal.dump(item.data))
  temp = convert_keys(temp, :to_s)
  if item.exists?
    item.retrieve!
    temp['credentials']['ip_hostname'] ||= item['credentials']['ip_hostname']
    Chef::Log.info "Editing #{resource_name} '#{name}' credentials"
    converge_by "#{resource_name} '#{name}' credentials edited" do
      item.update(temp)
    end
  end
end

action :remove do
  remove
end
