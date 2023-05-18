require "http_wrapper"
require "json"
require "json_http_request"
require "output_listener"

class JsonHttpClient
  def self.null
    new(StubbedHttp.new)
  end

  def initialize(http = HttpWrapper.new)
    @listener = OutputListener.new
    @http = http
  end

  def post(url, response_type, headers, body)
    @listener.emit(JsonHttpRequest.post(url, headers, body))
    @http.post(url, body.to_json, headers).body
  end

  def track_requests
    @listener.tracker
  end

  class StubbedHttp
    def post(url, body, headers)
      StubbedResponse.new
    end
  end

  class StubbedResponse
    def body
    end
  end
end
