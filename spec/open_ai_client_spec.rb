require "json_http_client"
require "json_http_request"
require "open_ai_client"
require "prompt_body"

RSpec.describe OpenAiClient do
  it "sends a prompt to Open AI" do
    http_client = JsonHttpClient.null
    http_requests = http_client.track_requests

    open_ai = OpenAiClient.new(http_client, "TEST_API_KEY")
    open_ai.prompt("TEST_PROMPT")

    expected_request = JsonHttpRequest.post(
      "https://api.openai.com/v1/chat/completions",
      {
        "Authorization" => "Bearer TEST_API_KEY",
        "Content-Type" => "application/json"
      },
      PromptBody.new(
        model: "gpt-3.5-turbo",
        messages: [
          PromptBody::Message.new(
            role: "user",
            content: "TEST_PROMPT"
          )
        ],
        temperature: 0.7
      )
    )
    expect(http_requests.output).to contain_exactly(expected_request)
  end
end
