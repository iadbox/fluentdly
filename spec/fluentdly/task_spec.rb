require 'spec_helper'

describe Fluentdly::Task do

  let(:severity) { :info }
  let(:parameters) { {:foo => 'bar'} }
  let(:block) { -> { ['ack', :fake_result] } }
  let(:logger) { double 'logger' }
  let(:config) { double 'config', :task_logger => logger}
  let(:fake_message) { 'fake_message' }

  subject  { described_class.new(severity, parameters, block, config) }

  before do
    allow(Time).to receive(:now).and_return 1
    allow(subject).to receive(:format_message).and_return fake_message
  end

  describe '#call' do
    it 'sends data to logger' do
      expect(logger).to receive(:log).
        with(:info, :foo => 'bar', :status => 'ack', :time => 0, :message => fake_message)

      expect(subject.call).to eq :fake_result
    end
  end

end
