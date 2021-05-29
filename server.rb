require 'socket'

class Server
  def initialize(address, port)
    @server = TCPServer.open(address, port)

    @clients = {}
    run
  end

  def run
    @clients[:client_1] = @server.accept
    @clients[:client_2] = @server.accept

    Thread.start(@clients[:client_1]) do |client_conn|
      communicate(:client_1, client_conn)
    end
    
    Thread.start(@clients[:client_2]) do |client_conn|
      communicate(:client_2, client_conn)
    end.join
  end

  def communicate(client_id, client_conn)
    loop do
      message = client_conn.gets

      @client.each do |id, conn|
        next if id == client_id
        conn.puts "#{client_id}: #{message}"
      end
    end
  end
end

Server.new("localhost", 8080)