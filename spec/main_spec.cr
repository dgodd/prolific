require "./spec_helper"

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

    # it "parses stdin" do
    #   pending
    # end

    # it "parses input file" do
    #   pending
    # end
  end
end
