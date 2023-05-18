class OutputTracker
  attr_reader :output

  def initialize
    @output = []
  end

  def add(data)
    @output << data
  end
end
