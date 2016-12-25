require 'fileutils'

# addlist for filter
list_names = ["01", "03"]

# Let's declare variables - paths to get files and where are them copy
get_dir = Dir["/home/zloyleva/ruby_projects/files/data/*.*"]
out_dir = "/home/zloyleva/ruby_projects/files/copies/"

# We take every file in the directory and copy it
# get_dir.each do |filename|
#   # add regular filter from array list_names
#   FileUtils.cp(filename, out_dir + File.basename(filename)) if (list_names.include?(File.basename(filename).chomp.slice(/^\w+/)))
# end
puts get_dir.class
