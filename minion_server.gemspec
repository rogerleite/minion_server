Gem::Specification.new do |gem|
  gem.name          = "minion_server"
  gem.version       = "0.0.1"
  gem.authors       = ["Roger Leite"]
  gem.email         = ["roger.barreto@gmail.com"]
  gem.description   = %q{Tiny local server. Useful to mock servers in integration tests.}
  gem.summary       = %q{Tiny local server. Useful to mock servers in integration tests.}
  gem.homepage      = "https://github.com/rogerleite/minion_server"

  gem.files         = ["lib/minion_server.rb"]
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "rack"
  gem.add_development_dependency "rake"
end
