class JsonHttpRequest < Data.define(:http_method, :url, :headers, :body)
  def self.post(*)
    new(Net::HTTP::Post, *)
  end
end
