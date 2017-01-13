require 'spec_helper'

describe Fluentdly::Logger do

  let(:config) { {:app_name => 'test_app', :host => '172.17.12.0', :port => 24224} }

  subject { described_class.new(config) }

  let(:adapter) { double 'adapter' }

  before do
    allow(Fluent::Logger::FluentLogger).to receive(:new).
      with(config[:app_name],:host => config[:host], :port => config[:port]).and_return(adapter)
  end

  let(:info) { Fluentdly::Severity.info }

  describe '#log' do
    it 'logs properly' do
      expect(adapter).to receive(:post).
        with(info, :severity => info, :foo => 'bar', :service => 'test_app')

      subject.log(info, :foo => 'bar', :service => 'test_app')
    end
  end

  describe 'logging levels' do
    it 'logs with debug, error, warn, fatal, unknown' do
      expect(adapter).to receive(:post).
        with(info, :severity => info, :foo => 'bar', :service => 'test_app')

      subject.info({:foo => 'bar', :service => 'test_app'})
    end
  end

  describe 'level ? methods' do
    it 'returns true' do
      expect(subject.warn?).to eq true
    end
  end

end
