require_relative 'stored_data'

sd = StoredData.new('https://www.dropbox.com/s/vh068xr1ijdgn7p/random_large_file?dl=1')
if sd.get == sd.get
  puts "equal"
else
  puts "not equal"
end
