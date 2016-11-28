require 'spec_helper'
require 'rack'

describe Fluentdly::Rack::Middleware do

  let(:request_parameters) do
    {
      :path   => 'PATH_INFO',
      :method => 'REQUEST_METHOD'
    }
  end

  let(:app) { proc{[200,{},['foo bar']]} }
  let(:config) { double 'config', :request_parameters => request_parameters }

  let(:stack) { Fluentdly::Rack::Middleware.new(app, config) }
  let(:request) { Rack::MockRequest.new(stack) }

  describe '#call' do
    let(:expected_params) do
      {
        :path   => '/foo.html',
        :method => 'GET',
      }
    end

    it 'logs users tasks properly' do
      expect(Fluentdly::Task).to receive(:log) do |severity, params, &block|
        expect(severity).to eq :info
        expect(params).to eq expected_params

        status, result = block.call
        expect(status).to eq 200
        result
      end

      response = request.get('/foo.html')
      expect(response.status).to eq 200
      expect(response.body).to eq 'foo bar'
    end
  end

end
