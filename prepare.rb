reg = %r{[^\t]+.+[^(\sUAH)]} #Input data for slice
pahtForInput = './for data/03-for.txt' #Path to input file
file_data = []

input = File.open(pahtForInput, 'r')
while (line = input.gets)
  #slice first tab in the start of line and (\sUAH). Add data to Array
  file_data << line.slice(reg).split("\t")
end
input.close
