require 'fileutils'

reg = %r{[^\s]?[^\t].+[^(\sUAH)]} #Input data for slice
pahtForInput = './for data/03-for0.txt' #Path to input file
file_data = []
rep_arr = []
get_dir = Dir["/home/zloyleva/ruby_projects/files/data/*.*"] #Dir for get image
out_dir = "/home/zloyleva/ruby_projects/files/copies/"  #Dir for copy image

#block for searching image file for articule products
def searchFile(articule, get_dir, out_dir)
  return_arr = []
  get_dir.each do |filename|
    if (articule == File.basename(filename).chomp.slice(/^\w+/))
      FileUtils.cp(filename, out_dir + File.basename(filename))
      puts "#{articule} is finded #{File.basename(filename)}"
      return_arr[0] = true
      return_arr[1] = File.basename(filename)
    else
      return_arr[0] = false
      return_arr[1] = "Sorry but image for art. #{articule} isn't finding"
    end
  end
  return return_arr
end

#Open price file and work with him
input = File.open(pahtForInput, 'r')
while (line = input.gets)
  #slice first tab in the start of line and (\sUAH). Add data to Array
  file_data << line.slice(reg).split("\t")
end
input.close

#Declareted variables for parcing price
cat = ''
subc1 = ''
subc2 = ''
subc3 = ''
products = []
quotes_s = '"'

#Work with getting data
file_data.each do |data_line|
  temp_arr = []
  if (!data_line[2])
    cat = data_line[0].chomp if data_line[0] =~ /^\b.+/
    subc1 = data_line[0].chomp.slice(/\b.+/) if data_line[0] =~ /^\s{4}\b.+/
    subc2 = data_line[0].chomp.slice(/\b.+/) if data_line[0] =~ /^\s{8}\b.+/
    subc3 = data_line[0].chomp.slice(/\b.+/) if data_line[0] =~ /^\s{12}\b.+/
    puts "Its a Category #{data_line[0]}"
  else
    #Call "copy" function Add reporting line if dont find image
    temp_arr = searchFile(data_line[2], get_dir, out_dir)
    if (temp_arr[0])
      data_line << temp_arr[1]
    else
      data_line << "image not found"
      rep_arr << temp_arr[1]
    end

    #Block who created name of category
    space_cont = data_line[0].slice(/^\s+/).size
    data_line[0] = data_line[0].slice(/\b.+/).to_s
    # data_line[3] = data_line[3].slice(/\b\S+/)
    data_line.unshift('') # Add first elemet - category
    data_line[0] = cat
    data_line[0] += + "->" + subc1 if space_cont > 7
    data_line[0] += + "->" + subc2 if space_cont > 11
    data_line[0] += + "->" + subc3 if space_cont > 15

    # Add full data to products array
    products << data_line
  end
end

# Create report file
report = File.open('report.txt', 'w')
rep_arr.each do |rep_line|
  report.puts rep_line
end

# puts file_data.to_s
# puts rep_arr.to_s
puts products.to_s
