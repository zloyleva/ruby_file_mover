require 'fileutils'

reg = %r{[^\t].+[^(\sUAH)]} #Input data for slice
pahtForInput = './for data/03-for0.txt' #Path to input file
file_data = []
rep_arr = []
get_dir = Dir["/home/zloyleva/ruby_projects/files/data/*.*"]
out_dir = "/home/zloyleva/ruby_projects/files/copies/"

#block for searching image file for articule products
def searchFile(articule, get_dir, out_dir)
  get_dir.each do |filename|
    if (articule == File.basename(filename).chomp.slice(/^\w+/))
      FileUtils.cp(filename, out_dir + File.basename(filename))
      puts "#{articule} is finded"
      return
    end
  end
  return "Sorry but image for art. #{articule} isn't finding"
end

input = File.open(pahtForInput, 'r')
while (line = input.gets)
  #slice first tab in the start of line and (\sUAH). Add data to Array
  file_data << line.slice(reg).split("\t")
end
input.close

file_data.each do |data_line|
  if (data_line[2])
    rep_arr << searchFile(data_line[2], get_dir, out_dir) if (searchFile(data_line[2], get_dir, out_dir))
  else
    puts "Its a Category #{data_line[0]}"
  end
end

# Create report file
report = File.open('report.txt', 'w')
rep_arr.each do |rep_line|
  report.puts rep_line
end

# puts file_data.to_s
# puts rep_arr.to_s
