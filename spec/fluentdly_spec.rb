require 'spec_helper'
require 'fluent-logger'

describe Fluentdly::Logger do

  let(:config) { {:host => '172.17.12.0', :port => 24224} }

  subject { described_class.new(config) }

  let(:adapter) { double 'adapter' }

  before do
    allow(Fluent::Logger::FluentLogger).to receive(:new).
      with('myapp',config).and_return(adapter)
  end

  describe '#log' do
    it 'logs properly' do
      expect(adapter).to receive(:log_post).
        with(:severity => :info, :foo => 'bar')

      subject.log(:info, :foo => 'bar')
    end
  end

end
