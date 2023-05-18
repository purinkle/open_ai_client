require "net/http"

class HttpWrapper
  def post(url, body, headers)
    Net::HTTP.post(URI.parse(url), body, headers)
  end
end
