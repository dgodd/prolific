require "./spec_helper"

describe Prolific::FromCSV do
  it ".parse" do
    stories = File.open("spec/fixtures/project_20170211_1212.csv") do |fh|
      Prolific::FromCSV.parse(fh)
    end

    stories.size.should eq 6

    stories[0].type.should eq "feature"
    stories[0].title.should eq "As a user I can toast a bagel"
    stories[0].labels.should eq ["mvp", "toasting"]

    stories[4].description.should eq "A metabolic endocrinide that the developrs will likely need to photoencapsulate."
    stories[4].tasks.should eq ["Re-enfarbulate the mitilandrinide", "Masticulate the retracto-mandible", "Effervesce all enteropolycarbides"]
    stories[4].labels.should eq [] of String

    stories[5].type.should eq "release"
    stories[5].title.should eq "Toaster MVP is Ready"
    stories[5].labels.should eq ["mvp"]
  end
end

