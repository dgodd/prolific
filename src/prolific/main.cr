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
      parse(stdin)
    else
      File.open(argv[0]) do |f|
        parse(f)
      end
    end
  end
end
