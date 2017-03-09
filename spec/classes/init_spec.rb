require 'spec_helper'
describe 'simple_nodejs' do

  context 'with defaults for all parameters' do
    it { should contain_class('simple_nodejs') }
  end
end
