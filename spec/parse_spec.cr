require "./spec_helper"

describe Prolific do
  it ".parse" do
    stories = File.open("spec/fixtures/stories.prolific") do |fh|
      Prolific.parse(fh)
    end

    stories.size.should eq 6

    stories[0].type.should eq "feature"
    stories[0].title.should eq "As a user I can toast a bagel"
    stories[0].labels.should eq ["mvp", "toasting"]

    stories[5].type.should eq "release"
    stories[5].title.should eq "Toaster MVP is Ready"
    stories[5].labels.should eq ["mvp"]
  end
end
