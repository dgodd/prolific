require "./spec_helper"

describe Prolific::Story do
  describe "#chore_title" do
    it "returns type and title" do
      story = Prolific::Story.new
      story.type = "chore"
      story.title = "Reticulate the Toaster's turboencabulator"
      story.type_title.should eq "[CHORE] Reticulate the Toaster's turboencabulator"
    end
    it "given only title" do
      story = Prolific::Story.new
      story.title = "Reticulate the Toaster's turboencabulator"
      story.type_title.should eq "Reticulate the Toaster's turboencabulator"
    end
  end

  describe "#chore_title=" do
    it "given type and title" do
      story = Prolific::Story.new
      story.type_title = "[CHORE] Reticulate the Toaster's turboencabulator"
      story.type.should eq "chore"
      story.title.should eq "Reticulate the Toaster's turboencabulator"
    end
    it "given only title" do
      story = Prolific::Story.new
      story.type_title = "As a user I can toast a bagel"
      story.type.should eq "feature"
      story.title.should eq "As a user I can toast a bagel"
    end
  end

  describe "#parse" do
    it "handles description" do
      story = Prolific::Story.new
      story.title = "Something"
      story.parse("When I insert a bagel into toaster")
      story.description.should eq "When I insert a bagel into toaster"

      story.parse("and press the on button")
      story.description.should eq "When I insert a bagel into toaster\nand press the on button"

      story.parse("- Toast a bagel")
      story.description.should eq "When I insert a bagel into toaster\nand press the on button\n- Toast a bagel"

      story.parse("* Spread cheese")
      story.description.should eq "When I insert a bagel into toaster\nand press the on button\n- Toast a bagel\n* Spread cheese"
    end
    it "handles labels" do
      story = Prolific::Story.new
      story.title = "Something"
      story.parse("L: mvp, clean-up")
      story.labels.should eq ["mvp", "clean-up"]
    end
    it "handles tasks" do
      story = Prolific::Story.new
      story.title = "Something"

      story.parse("- [ ] Spread cheese")
      story.tasks.should eq ["Spread cheese"]

      story.parse("- [ ] Eat bagel")
      story.tasks.should eq ["Spread cheese", "Eat bagel"]
    end
  end

  describe "initialize" do
    it "handles complex example" do
      story = Prolific::Story.new("
[CHORE] As a user I can set the desired color of my bagel
I should be able to manipulate a dial and choose one of:
- light
- dark
Pressing the on button gives me toast of the appropriate color.

- [ ] Add dial to page
- [ ] make dial work

L: mvp, toasting
      ".split(/\n/))
      story.type.should eq "chore"
      story.title.should eq "As a user I can set the desired color of my bagel"
      story.description.should eq "I should be able to manipulate a dial and choose one of:\n- light\n- dark\nPressing the on button gives me toast of the appropriate color."
      story.tasks.should eq ["Add dial to page", "make dial work"]
      story.labels.should eq ["mvp", "toasting"]
    end
  end
end
