class PromptBody < Data.define(:model, :messages, :temperature)
  def to_json(*)
    to_h.to_json(*)
  end

  class Message < Data.define(:role, :content)
    def to_json(*)
      to_h.to_json(*)
    end
  end
end
