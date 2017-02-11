require "./*"

module Prolific
  def self.main(argv, stdin, stdout)
    if argv.size != 1
      stdout.puts USAGE
      return 1
    end

    case argv[0]
    when "help"
      stdout.puts USAGE
    when "template"
      stdout.puts "Writing template to stories.prolific"
      File.open("stories.prolific", "w") do |f|
        f.puts TEMPLATE
      end
    when "-"
      Writer.csv(stdout, Reader.prolific(stdin))
    when /\.csv$/
      File.open(argv[0]) do |f|
        Writer.prolific(stdout, Reader.csv(f))
      end
    else
      File.open(argv[0]) do |f|
        Writer.csv(stdout, Reader.prolific(f))
      end
    end
  end
end
