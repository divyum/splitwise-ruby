module Splitwise
  class Error < StandardError

    attr_reader :code

    def self.codes
      {
        400 => Splitwise::InvalidParameters,
        401 => Splitwise::InvalidAPIKey,
        403 => Splitwise::AccessForbidden,
        404 => Splitwise::ResourceNotFound,
        405 => Splitwise::MethodNotAllowed,
        406 => Splitwise::FormatNotAcceptable,
        410 => Splitwise::ResourceRemovedFromServer,
        429 => Splitwise::RateLimitExceeded,
        500 => Splitwise::InternalServerError,
        503 => Splitwise::ServiceTemporarilyUnavailable
      }
    end

    def self.initialize(message, code=nil)
      @code = code
      super(message)
    end

  end

  # Raised when - Missing or invalid parameters in API call
  class InvalidParameters < Error; end

  # Raised when - Missing or invalid API key
  class InvalidAPIKey < Error; end

  # Raised when - You don't have any free credits left
  class NoFreeCreditsLeft < Error; end

  # Raised when - You don’t have permission to access the resource
  class AccessForbidden < Error; end

  # Raised when - The resource does not exist
  class ResourceNotFound < Error; end

  # Raised when - You tried to access a resource with an invalid method
  class MethodNotAllowed < Error; end

  # Raised when - You requested a format that isn’t json
  class FormatNotAcceptable < Error; end

  # Raised when - The requested resource has been removed from our servers
  class ResourceRemovedFromServer < Error; end

  # Raised when - You have hit the rate limit for your account
  class RateLimitExceeded < Error; end

  # Raised when - There was an error on the server and we have been notified. Try again later.
  class InternalServerError < Error; end

  # Raised when - We are temporarily offline for maintenance. Please try again later.
  class ServiceTemporarilyUnavailable < Error; end

  # Raised when - We get an unknown response code from the API
  class UnknownError < Error; end

  # Raised when - We get an invalid JSON in response from API
  class InvalidJSONResponse < Error; end
end
