require 'socket'

class Client
  def initialize(socket)
    @socket = socket

    puts "Type quit and enter to exit"
    
    @send_message = send_message
    @read_message = read_message

    @send_message.join
    @read_message.join
  end

  def send_message
    Thread.new do
      loop do
        message = $stdin.gets.chomp
        
        @socket.puts message
      end
    end
  end

  def read_message
    Thread.new do
      loop do
        puts @socket.gets
      end
    end.join
  end
end

socket = TCPSocket.open("localhost", 8080)
Client.new( socket )