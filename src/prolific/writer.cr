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

  def self.csv(io, stories : Array(Story))
    CSV.build(io) do |csv|
      max_tasks = stories.map { |s| s.tasks.size }.max
      csv.row(["Title", "Type", "Description", "Labels"] + (["Task"] * max_tasks))
      stories.each do |story|
        csv.row([
          story.title,
          story.type,
          story.description,
          story.labels.join(","),
        ] + story.tasks)
      end
    end
  end
end
