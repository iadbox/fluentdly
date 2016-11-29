# Fluentdly

Fluentdly is a wrapper for easily structured logging HTTP and non HTTP requests using fluent-logger.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluentdly'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluentdly

## Examples
###Configure logger

Setup `fluent-logger` parameters. See [link](https://github.com/fluent/fluent-logger-ruby "fluent-logger doc")

```ruby
$logger = Fluentdly::Logger.new({:host => 'myhost', :port => 24224, :app_name => 'my_app'})

```
Configure fluentdly task logger:

```ruby

Fluentdly.configure do |config|
  config.task_logger = $logger
end

```
###Configure middleware HTTP params to log

Custom parameters will merge with default ones: `:method, :query_string and :path`

```ruby
require 'fluentdly'

  Fluentdly.configure do |config|
    custom_parameters = {
      :user_agent => 'HTTP_USER_AGENT',
      :uri        => 'REQUEST_URI'
    }

    config.request_parameters custom_parameters
  end
```
###Task logging example

```ruby

Fluentdly::Task.log(:info, {:log_param => 'log_information' ... }) do
  your_business_logic_here
end

```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

