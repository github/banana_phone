module BananaPhone
  class Error < StandardError
    attr_accessor :code, :original_exception

    def initialize(msg = nil, klass = nil, bt = [])
      case msg
        when Array
          code, message = msg
        else
          code, message = [0, msg]
      end

      if klass
        self.original_exception = RemoteError.new("#{klass}: #{message}")
        self.original_exception.set_backtrace(bt)
      else
        self.original_exception = self
      end

      self.code = code
      super(message)
    end
  end

  class RemoteError < Error
  end

  class ConnectionError < Error
    attr_reader :host, :port
    def initialize(host, port)
      @host, @port = host, port
      super("Unable to connect to #{host}:#{port}")
    end
  end

  # Raised when we don't get a response from a server in a timely
  # manner. This typically occurs in spite of a successful connection.
  class ReadTimeoutError < Error
    attr_reader :host, :port, :timeout
    def initialize(host, port, timeout)
      @host, @port, @timeout = host, port, timeout
      super("No response from #{host}:#{port} in #{timeout}s")
    end
  end

  # Raised when unexpected EOF is reached on the socket.
  class ReadError < Error
    attr_reader :host, :port
    def initialize(host, port)
      @host, @port = host, port
      super("Unable to read from #{host}:#{port}")
    end
  end

  class ProtocolError < Error
    NO_HEADER = [0, "Unable to read length header from server."]
    NO_DATA = [1, "Unable to read data from server."]
  end

  class ServerError < Error
  end

  class UserError < Error
  end

  class ProxyError < Error
  end

  class InvalidOption < Error
  end
end
