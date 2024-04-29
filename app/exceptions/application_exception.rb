module ApplicationException
  # Custom exception class that extends StandardError.
  #
  # This class is intended to be used as a base class for other custom exception classes.
  # It provides attributes for status, code, and message, along with a to_h method to
  # convert the exception information to a hash.
  class BaseException < StandardError
    attr_reader :status, :code, :message

    def initialize(status, code, message)
      super()
      @status = status
      @code = code
      @message = message
    end

    def to_h
      { code: status, message: "[#{@code}] - #{@message}" }
    end
  end
  
  # Custom exception class for handling Forbidden (403) errors.
  class ForbiddenException < BaseException
   def initialize
     super(HttpStatus::FORBIDDEN, 'ERR001', 'You don\'t have the necessary permissions to access this resource.')
   end
  end

  # Custom exception class for handling routing errors.
  class RoutingException < BaseException
    attr_reader :request_method, :path_info

    def initialize(request_method, path_info)
      @request_method = request_method
      @path_info = path_info
      super(HttpStatus::NOT_FOUND, 'ERR002', "No route matches [#{request_method}] \"#{path_info}\"")
    end
  end

  # Custom exception class for handling Bad Request (400) errors.
  class BadRequestException < BaseException
    CODE = 'ERR003'

    def initialize(message)
      super(HttpStatus::BAD_REQUEST, CODE, message)
    end

    def self.to_h
      { code: HttpStatus::BAD_REQUEST, message: "[#{CODE}] - Bad Request message" }
    end
  end

  # Custom exception class for handling Internal Server Error (500) errors.
  class InternalServerErrorException < BaseException
    def initialize
      super(HttpStatus::INTERNAL_SERVER_ERROR, 'ERR004', 'Internal Server Error')
    end
  end
end


