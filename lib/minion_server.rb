require "socket"
require "rack"

class MinionServer
  VERSION = "0.0.1"

  def initialize(app)
    @app = app
  end

  def start(host = "localhost", port = 4000)
    #puts "== Starting #{@app.inspect}"
    @pid_server = fork do
      Rack::Server.start(:app => @app, :server => 'webrick', :environment => :none, :daemonize => false, :Host => host, :Port => port)
    end
    wait_for_service(host, port)
    self
  end

  def shutdown
    #puts "== Stopping #{@app.inspect}\n\n"
    Process.kill(:INT, @pid_server) # send ctrl+c to webrick
    Process.waitpid(@pid_server) # waiting his life go to void ...
  end

  protected

  def listening?(host, port)
    begin
      socket = ::TCPSocket.new(host, port)
      socket.close unless socket.nil?
      true
    rescue Errno::ECONNREFUSED,
      Errno::EBADF,           # Windows
      Errno::EADDRNOTAVAIL    # Windows
      false
    end
  end

  def wait_for_service(host, port, timeout = 5)
    start_time = Time.now

    until listening?(host, port)
      if timeout && (Time.now > (start_time + timeout))
        raise SocketError.new("Socket did not open within #{timeout} seconds")
      end
    end

    true
  end

end
