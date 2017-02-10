module Prolific
  class Story
    property type = ""
    property title = ""
    property description = ""
    property labels = [] of String
    property tasks = [] of String

    def type_title
      "[#{type.upcase}] #{title}"
    end

    def type_title=(line)
      if line =~ /^\[(.*?)\]\s*(.*)/
        self.type = $1.downcase
        self.title = $2
      else
        self.type = "feature"
        self.title = line
      end
    end

    def parse(line)
      return self.type_title = line if title == ""
      case line
      when /^L:\s*(.*)/
        self.labels += $1.split(/,\s*/)
      when /^[-*](?:\s*\[\s*\])?\s*(.*)/
        self.tasks += [$1]
      else
        self.description += "\n" if self.description != ""
        self.description += line
      end
    end

    def initialize
    end

    def initialize(lines : Array(String))
      lines.each do |line|
        parse(line)
      end
      self.description = description.gsub(/\n\n\n+/, "\n\n").gsub(/[\s\n]+$/, "")
    end
  end
end
