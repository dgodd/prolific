require "./story"
require "csv"

module Prolific::Writer
  def self.prolific(io, stories : Array(Story))
    stories.each_with_index do |story,idx|
      io.puts "---" if idx > 0
      io.puts story.type_title
      io.puts story.description if story.description != ""
      story.tasks.each do |task|
        io.puts "- [ ] #{task}"
      end
      io.puts "L: #{story.labels.join(", ")}" if story.labels.size > 0
    end
  end
end
