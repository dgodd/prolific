require "spec"
require "../src/prolific/*"
require "tempfile"

def chtmpdir
  path = Tempfile.new("template").tap{|tmp|tmp.unlink}.path
  Dir.mkdir_p(path)
  Dir.cd(path) do
    yield
  end
end
