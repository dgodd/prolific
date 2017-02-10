require "spec"
require "../src/prolific/*"
require "tempfile"
require "csv"

def chtmpdir
  path = Tempfile.new("template").tap{|tmp|tmp.unlink}.path
  Dir.mkdir_p(path)
  Dir.cd(path) do
    yield
  end
end

def csv_to_rows(str : String)
  csv = CSV.new(str)
  Array(Array(String)).new.tap do |rows|
    while csv.next
      rows << csv.row.to_a
    end
  end
end
