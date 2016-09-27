require "net/http"
require "uri"

module Splitwise
  class Request
    attr_accessor :uri

    def initialize
      @uri = Splitwise::BASE_URL+ "/" + Splitwise::API_VERSION + "/"
      @accessor_token = Splitwise.access_token
    end

    def fetch(params)
      url = get_path(params)
      if @accessor_token.nil?
        url = URI.parse(url)
        response = request(:get, url)
      else
        response = request(:get, url)
      end
      parse_response(response)
      response.body
    end

    def update(params, data)
      url = get_path(params)
      response = request(:post, url, data)
      parse_response(response)
      response.body
    end

    def get_path(params)
      url = @uri + params
    end

    def request(req_method, uri, post_data=nil)
      if @accessor_token.nil?
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        if http.use_ssl?
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        else
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        if req_method == :get
          request = Net::HTTP::Get.new(uri)
        end
        response = http.request(request)
      else
        if req_method == :get
          response = @accessor_token.get(uri)
        else
          header = {'Content-Type' => 'text/json'}
          response = @accessor_token.post(uri, post_data, header)
        end
      end
      response
    end

    def parse_response(response)
      response_code = response.code.to_i
      if valid_response_code?(response_code)
        begin
          JSON.parse(response.body)
        rescue JSON::ParserError => e
          raise Splitwise::InvalidJSONResponse(response.body)
        end
      else
        error_class = Splitwise::Error.codes[response_code] || Splitwise::UnknownError
        raise error_class.new(response.body, response_code)
      end
    end

    def valid_response_code?(code)
      [200, 201].include?(code)
    end

  end
end
