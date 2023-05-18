require "json_http_client"

RSpec.describe JsonHttpClient do
  it "tracks requests" do
    stub_const("ExampleBody", Data.define(:content))
    json_http_client = JsonHttpClient.null
    tracker = json_http_client.track_requests

    json_http_client.post(
      "/post-endpoint",
      nil,
      {
        "TEST_HEADER_KEY_1" => "TEST_HEADER_VALUE_1",
        "TEST_HEADER_KEY_2" => "TEST_HEADER_VALUE_2"
      },
      ExampleBody.new("TEST_POST")
    )

    expected_response = JsonHttpRequest.post(
      "/post-endpoint",
      {
        "TEST_HEADER_KEY_1" => "TEST_HEADER_VALUE_1",
        "TEST_HEADER_KEY_2" => "TEST_HEADER_VALUE_2"
      },
      ExampleBody.new("TEST_POST")
    )
    expect(tracker.output).to contain_exactly(expected_response)
  end

  context "when nulled" do
    it "returns nil" do
      stub_const("ExampleBody", Data.define(:content))
      json_http_client = JsonHttpClient.null

      response = json_http_client.post(
        "/post-endpoint",
        nil,
        {
          "TEST_HEADER_KEY_1" => "TEST_HEADER_VALUE_1",
          "TEST_HEADER_KEY_2" => "TEST_HEADER_VALUE_2"
        },
        ExampleBody.new("TEST_POST")
      )

      expect(response).to be_nil
    end
  end
end
