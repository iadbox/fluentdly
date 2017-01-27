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

  let(:debug)  { true }
  let(:logger) { double 'logger', :debug? => debug }

  let :config do
    double 'config', :request_parameters => request_parameters,
                     :task_logger        => logger
  end

  let(:stack) { Fluentdly::Rack::Middleware.new(app, config) }
  let(:request) { Rack::MockRequest.new(stack) }

  describe '#call' do
    context 'on debug' do
      let(:debug)  { true }

      it 'logs everything' do
        expect(logger).to receive(:info) do |params|
          expect(params[:path]  ).to eq "/foo.html"
          expect(params[:method]).to eq "GET"
          expect(params[:status]).to eq "200"

          message = params[:message]
          expect(message).to match /GET \/foo.html/
          expect(message).to match /{"bar"=>"baz"}/
          expect(message).to match /Responded in [\d\.]+ms/
          expect(message).to match /200/
          expect(message).to match /foo bar/
        end

        response = request.get('/foo.html?bar=baz')
        expect(response.status).to eq 200
        expect(response.body).to eq 'foo bar'
      end
    end

    context 'on info' do
      let(:debug) { false }

      let :message_regex do
        /Completed GET \/foo.html\?bar=baz with 200 in [\d\.]+ms/
      end

      it 'logs some information' do
        expect(logger).to receive(:info) do |params|
          expect(params[:path]   ).to eq "/foo.html"
          expect(params[:method] ).to eq "GET"
          expect(params[:status] ).to eq "200"
          expect(params[:message]).to match message_regex
        end

        response = request.get('/foo.html?bar=baz')
        expect(response.status).to eq 200
        expect(response.body).to eq 'foo bar'
      end
    end
  end

end
