require "./story"
require "csv"

module Prolific
  def self.parse(file)
    stories = [] of Story
    each_group(file) do |lines|
      stories << Story.new(lines)
    end
    stories
  end

  def self.write_csv(io, stories : Array(Story))
    CSV.build(io) do |csv|
      max_tasks = stories.map{|s|s.tasks.size}.max
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
