# MinionServer

Tiny local server. Useful to mock servers in integration tests.

## Installation

You can install (and be happy):

    $ gem install minion_server

Or you can also use in your Gemfile:

    gem 'minion_server'
    # live on edge is also an option
    gem 'minion_server', :git => 'git@github.com:rogerleite/minion_server.git'

## Usage

``` ruby
    require 'minion_server'

    # build your integration app
    IntegrationApp = Rack::Builder.new do
      map "/" do
        run lambda { |env|
          [200, {"Content-Type" => "text/plain"}, ["Be happy!"]]
        }
      end
    end

    server = MinionServer.new(IntegrationApp)
    server.start("localhost", 1620)  # default: localhost, 4000

    # do your calls
    system "curl http://localhost:1620" # => "Be happy!"

    server.shutdown
```
