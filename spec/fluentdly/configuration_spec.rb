require 'spec_helper'
describe Fluentdly::Configuration do

  let(:logger)     { double 'logger' }
  let(:parameters) { { :foo => 'bar' } }

  describe '#task_logger' do
    context 'user configures logger' do
      it 'returns custom logger' do
        expect(subject.task_logger = logger).to eq logger
      end
    end

    context 'default logger' do
      it 'returns the default stdout logger' do
        expect(subject.task_logger).to respond_to :log
      end
    end
  end

  describe '#request_parameters' do
    context 'custom parameters' do
      it 'returns custom request params' do
        expect(subject.request_parameters parameters).to include(parameters)
      end
    end
  end

end
