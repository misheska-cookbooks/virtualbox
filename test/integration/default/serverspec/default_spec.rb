require 'spec_helper'

describe 'virtualbox' do
  it 'installs vboxmanage' do
    expect(command('vboxmanage --version').exit_status).to eq 0
  end
end
