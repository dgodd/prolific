require "./spec_helper"

describe Prolific::Writer do
  describe ".prolific" do
    it "outputs type and title" do
      story = Prolific::Story.new
      story.type = "chore"
      story.title = "Reticulate the Toaster's turboencabulator"

      io = IO::Memory.new
      Prolific::Writer.prolific(io, [story])
      io.to_s.should contain "[CHORE] Reticulate the Toaster's turboencabulator"
    end

    it "outputs description" do
      story = Prolific::Story.new
      story.description = "As a pivot\nI want to eat bacon"

      io = IO::Memory.new
      Prolific::Writer.prolific(io, [story])
      io.to_s.should contain "\nAs a pivot\nI want to eat bacon\n"
    end

    it "outputs tasks" do
      story = Prolific::Story.new
      story.tasks = ["buy bacon", "cook bacon", "eat bacon"]

      io = IO::Memory.new
      Prolific::Writer.prolific(io, [story])
      io.to_s.should contain "\n- [ ] buy bacon\n"
      io.to_s.should contain "\n- [ ] cook bacon\n"
      io.to_s.should contain "\n- [ ] eat bacon\n"
    end

    it "outputs labels" do
      story = Prolific::Story.new
      story.labels = ["bacon", "mvp"]

      io = IO::Memory.new
      Prolific::Writer.prolific(io, [story])
      io.to_s.should contain "\nL: bacon, mvp\n"
    end
  end
end
