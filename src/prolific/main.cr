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
      write_csv(stdout, parse(stdin))
    when /\.csv$/
      File.open(argv[0]) do |f|
        Writer.prolific(stdout, FromCSV.parse(f))
      end
    else
      File.open(argv[0]) do |f|
        write_csv(stdout, parse(f))
      end
    end
  end
end
