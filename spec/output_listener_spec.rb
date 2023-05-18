require "output_listener"

RSpec.describe OutputListener do
  context "when we are yet to track anything" do
    it "is empty" do
      output_listener = OutputListener.new
      tracker = output_listener.tracker

      output = tracker.output
      expect(output).to be_empty
    end
  end

  context "when we track something" do
    it "contains only that item" do
      output_listener = OutputListener.new
      tracker = output_listener.tracker

      output_listener.emit("TEST_DATA")

      output = tracker.output
      expect(output).to contain_exactly("TEST_DATA")
    end
  end

  context "when we track many things" do
    it "contains only those items" do
      output_listener = OutputListener.new
      tracker = output_listener.tracker

      output_listener.emit("TEST_DATA_1")
      output_listener.emit("TEST_DATA_2")

      output = tracker.output
      expect(output).to contain_exactly("TEST_DATA_1", "TEST_DATA_2")
    end
  end

  context "when we have many trackers" do
    it "tracks items independent of each other" do
      output_listener = OutputListener.new

      tracker_1 = output_listener.tracker
      output_listener.emit("TEST_DATA_1")
      tracker_2 = output_listener.tracker
      output_listener.emit("TEST_DATA_2")

      expect(tracker_1.output).to contain_exactly("TEST_DATA_1", "TEST_DATA_2")
      expect(tracker_2.output).to contain_exactly("TEST_DATA_2")
    end
  end
end
