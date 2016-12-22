require 'fileutils'

# Let's declare variables - paths to get files and where are them copy
get_dir = Dir["/home/zloyleva/ruby_projects/files/data/*.*"]
out_dir = "/home/zloyleva/ruby_projects/files/copies/"

# We take every file in the directory and copy it
get_dir.each do |filename|
  FileUtils.cp(filename, out_dir + File.basename(filename))
end
