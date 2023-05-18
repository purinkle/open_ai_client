require "output_tracker"

class OutputListener
  def initialize
    @listeners = []
  end

  def emit(*)
    @listeners.each do |tracker|
      tracker.add(*)
    end
  end

  def tracker
    OutputTracker.new.tap do |tracker|
      @listeners << tracker
    end
  end
end
