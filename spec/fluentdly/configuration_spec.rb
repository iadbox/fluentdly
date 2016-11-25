require 'spec_helper'
describe Fluentdly::Configuration do

  let(:logger) { double 'logger' }

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

end
