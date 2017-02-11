require "./story"
require "csv"

module Prolific::Reader
  def self.prolific(io : IO) : Array(Story)
    stories = [] of Story
    each_group(io) do |lines|
      stories << Story.new(lines)
    end
    stories
  end

  def self.csv(io : IO) : Array(Story)
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

  private def self.each_group(file)
    lines = [] of String
    file.each_line(chomp: true) do |line|
      case line
      when /^---\s*/
        yield lines
        lines = [] of String
      else
        lines << line
      end
    end
    yield lines
  end
end
