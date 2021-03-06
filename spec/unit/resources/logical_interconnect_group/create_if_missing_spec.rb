require_relative './../../../spec_helper'

describe 'oneview_test::logical_interconnect_group_create_if_missing' do
  let(:resource_name) { 'logical_interconnect_group' }
  include_context 'chef context'

  it 'creates it when it does not exist' do
    expect_any_instance_of(OneviewSDK::LogicalInterconnectGroup).to receive(:exists?).and_return(false)
    expect_any_instance_of(OneviewSDK::LogicalInterconnectGroup).to receive(:create).and_return(true)
    expect(real_chef_run).to create_oneview_logical_interconnect_group_if_missing('LogicalInterconnectGroup2')
  end

  it 'does nothing when it exists' do
    expect_any_instance_of(OneviewSDK::LogicalInterconnectGroup).to receive(:exists?).and_return(true)
    expect_any_instance_of(OneviewSDK::LogicalInterconnectGroup).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(OneviewSDK::LogicalInterconnectGroup).to_not receive(:create)
    expect(real_chef_run).to create_oneview_logical_interconnect_group_if_missing('LogicalInterconnectGroup2')
  end
end
