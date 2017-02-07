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
  let(:warn) { Fluentdly::Severity.warn }

  describe '#log and others' do
    context "logs with content" do
      it 'logs properly' do
        expect(adapter).to receive(:post).
          with(info, :severity => info, :foo => 'bar', :service => 'test_app').
          twice

        subject.log(info, :foo => 'bar', :service => 'test_app')
        subject.info({:foo => 'bar', :service => 'test_app'})
      end
    end

    context "logs with block" do
      describe '#log' do
        it 'logs properly with block' do
          expect(adapter).to receive(:post).
            with(info, :severity => info, :message => 'foo', :service => 'test_app').
            twice

          subject.log(info) { "foo" }
          subject.info { "foo" }
        end
      end
    end
  end

  describe 'logging level and ? methods' do
    before { subject.level = warn }

    it 'does not log below the current level' do
      expect(adapter).to receive(:post).
        with(warn, :severity => warn, :message => 'bar', :service => 'test_app')

      expect(subject.info?).to eq false
      subject.log(info) { "foo" }

      expect(subject.warn?).to eq true
      subject.log(warn) { "bar" }
    end
  end

end
