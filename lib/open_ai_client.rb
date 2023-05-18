require "prompt_body"

class OpenAiClient
  OPEN_AI_ENDPOINT = "https://api.openai.com/v1/chat/completions"

  def initialize(http_client, api_key)
    @http_client = http_client
    @api_key = api_key
  end

  def prompt(prompt)
    @http_client.post(
      OPEN_AI_ENDPOINT,
      nil,
      {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      },
      PromptBody.new(
        model: "gpt-3.5-turbo",
        messages: [
          PromptBody::Message.new(
            role: "user",
            content: prompt
          )
        ],
        temperature: 0.7
      )
    )
  end
end
