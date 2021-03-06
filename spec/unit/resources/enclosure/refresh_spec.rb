require_relative './../../../spec_helper'

describe 'oneview_test::enclosure_refresh' do
  let(:resource_name) { 'enclosure' }
  include_context 'chef context'

  it 'refresh enclosure already triggered' do
    expect_any_instance_of(OneviewSDK::Enclosure).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::Enclosure).to receive(:[]).with('refreshState')
      .and_return('RefreshPending')
    allow_any_instance_of(OneviewSDK::Enclosure).to receive(:[]).with('name')
      .and_return('Enclosure1')
    expect_any_instance_of(OneviewSDK::Enclosure).to_not receive(:set_refresh_state)
    expect(real_chef_run).to refresh_oneview_enclosure('Enclosure1')
  end

  it 'refresh enclosure with default options' do
    expect_any_instance_of(OneviewSDK::Enclosure).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::Enclosure).to receive(:[]).with('refreshState')
      .and_return('NotRefreshing')
    allow_any_instance_of(OneviewSDK::Enclosure).to receive(:[]).with('name')
      .and_return('Enclosure1')
    expect_any_instance_of(OneviewSDK::Enclosure).to receive(:set_refresh_state).and_return(true)
    expect(real_chef_run).to refresh_oneview_enclosure('Enclosure1')
  end
end
