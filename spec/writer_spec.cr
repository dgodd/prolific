require "./spec_helper"

describe Prolific::Writer do
  describe ".csv" do
    story = Prolific::Story.new
    story.type = "chore"
    story.title = "Eat Bacon"
    story.description = "Bacon is\ntoo prevalent"
    story.tasks = ["grab","eat"]
    story.labels = ["mvp","easy"]

    io = IO::Memory.new
    Prolific::Writer.csv(io, [story])
    io.to_s.should eq "Title,Type,Description,Labels,Task,Task\nEat Bacon,chore,\"Bacon is\ntoo prevalent\",\"mvp,easy\",grab,eat\n"
  end

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
