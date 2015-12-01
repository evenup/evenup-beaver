require 'spec_helper'

describe 'beaver', :type => :class do

  context 'stanzas' do
    let(:params) { { :stanzas => { 'a' => { 'type' => 'syslog'}, 'b' => {'type' => 'auth'} } } }
    it { should contain_beaver__stanza('a') }
    it { should contain_beaver__stanza('b') }
  end
end
