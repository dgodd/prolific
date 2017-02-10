require "./story"

module Prolific
  def self.parse(file)
    stories = [] of Story
    each_group(file) do |lines|
      stories << Story.new(lines)
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
