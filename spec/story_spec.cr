require "./spec_helper"

describe Prolific::Story do
  describe "#chore_title" do
    it "returns type and title" do
      story = Prolific::Story.new
      story.type = "chore"
      story.title = "Reticulate the Toaster's turboencabulator"
      story.type_title.should eq "[CHORE] Reticulate the Toaster's turboencabulator"
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

      story.parse("- Toast a bagel")
      story.tasks.should eq ["Toast a bagel"]

      story.parse("* Spread cheese")
      story.tasks.should eq ["Toast a bagel", "Spread cheese"]

      story.parse("- [ ] Eat bagel")
      story.tasks.should eq ["Toast a bagel", "Spread cheese", "Eat bagel"]
    end
  end

  describe "initialize" do
    it "handles complex example" do
      story = Prolific::Story.new("
[CHORE] Reticulate the Toaster's turboencabulator

A metabolic endocrinide that

- Re-enfarbulate the mitilandrinide
- Masticulate the retracto-mandible

the developrs will likely need to photoencapsulate.

L: mvp
      ".split(/\n/))
      story.type.should eq "chore"
      story.title.should eq "Reticulate the Toaster's turboencabulator"
      story.description.should eq "A metabolic endocrinide that\n\nthe developrs will likely need to photoencapsulate."
      story.tasks.should eq ["Re-enfarbulate the mitilandrinide", "Masticulate the retracto-mandible"]
      story.labels.should eq ["mvp"]
    end
  end
end
