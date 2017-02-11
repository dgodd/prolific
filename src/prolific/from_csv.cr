require "csv/parser"

module Prolific
  class FromCSV
    def self.parse(io : IO) : Array(Story)
      csv = CSV::Parser.new(io)
      header = csv.next_row
      return [] of Story if header.nil?
      header = header.as(Array(String))

      stories = [] of Story
      csv.each_row do |row|
        story = Story.new
        row.zip(header).each do |txt,name|
          case name
          when "Type"
            story.type = txt.downcase
          when "Title"
            story.title = txt
          when "Description"
            story.description = txt
          when "Labels"
            story.labels += txt.split(/\s*,\s*/).reject{|s|s==""}
          when "Task"
            story.tasks << txt
          end
        end
        stories << story
      end
      stories
    end
  end
end
