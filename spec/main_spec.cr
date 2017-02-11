require "./spec_helper"
require "csv"

describe Prolific do
  describe ".main" do
    it "when no args, prints usage " do
      stdin = IO::Memory.new(1024)
      stdout = IO::Memory.new(1024)
      Prolific.main([] of String, stdin, stdout)

      stdout.to_s.should match /Usage/
    end

    it "when help, prints usage" do
      stdin = IO::Memory.new(1024)
      stdout = IO::Memory.new(1024)
      Prolific.main(["help"] of String, stdin, stdout)

      stdout.to_s.should match /Usage/
    end

    it "when template, writes template out" do
      stdin = IO::Memory.new(1024)
      stdout = IO::Memory.new(1024)
      text = chtmpdir do
        Prolific.main(["template"] of String, stdin, stdout)
        File.read("stories.prolific")
      end

      stdout.to_s.should eq "Writing template to stories.prolific\n"
      text.should contain "[CHORE] Reticulate the Toaster's turboencabulator"
    end

    it "parses stdin" do
      stdin = File.open("spec/fixtures/stories.prolific")
      stdout = IO::Memory.new(1024)
      Prolific.main(["-"] of String, stdin, stdout)

      rows = csv_to_rows(stdout.to_s)
      rows.size.should eq 7
      rows[0].should eq ["Title", "Type", "Description", "Labels", "Task", "Task", "Task"]
      rows[1].should eq ["As a user I can toast a bagel", "feature", "When I insert a bagel into toaster and press the on button, I should get a toasted bagel", "mvp,toasting"]
    end

    it "parses input prolific file" do
      stdin = IO::Memory.new(1024)
      stdout = IO::Memory.new(1024)
      Prolific.main(["spec/fixtures/stories.prolific"] of String, stdin, stdout)

      rows = csv_to_rows(stdout.to_s)
      rows.size.should eq 7
      rows[0].should eq ["Title", "Type", "Description", "Labels", "Task", "Task", "Task"]
      rows[5].should eq ["Reticulate the Toaster's turboencabulator", "chore", "A metabolic endocrinide that the developrs will likely need to photoencapsulate.", "", "Re-enfarbulate the mitilandrinide", "Masticulate the retracto-mandible", "Effervesce all enteropolycarbides"]
    end

    it "parses input csv file" do
      stdin = IO::Memory.new(1024)
      stdout = IO::Memory.new(1024)
      Prolific.main(["spec/fixtures/project_20170211_1212.csv"] of String, stdin, stdout)

      stdout.to_s.should contain "---\n[CHORE] Reticulate the Toaster's turboencabulator"
    end
  end
end
