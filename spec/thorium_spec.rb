require 'spec_helper'

describe ThoriumCLI::Thorium do
  describe '#new' do
    it 'should be an instance of a Thor class' do
      expect(ThoriumCLI::Thorium.new).to be_a Thor
    end
  end
end
