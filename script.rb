require_relative 'stored_data'

sd = StoredData.new('https://triplebyte.com/robots.txt')
if sd.get == sd.get
  puts "equal"
else
  puts "not equal"
end
