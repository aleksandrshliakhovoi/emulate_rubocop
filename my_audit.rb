require 'pry'

# binding.pry
# send && public_send

# 1 get all files from each dir
# 2 separate each file by line
# 3 convert each line into array 
# 4 find in array value
# 5 raise en error, return file name and error

#filenames = Dir.entries(".rb")
#Dir.entries(".rb")


arr_of_files = Dir["./app/*.rb"] + Dir["./web/*.rb"]
#puts arr_of_files
hsh_with_err = {}

arr_of_files.each do |file_path|
  file = File.open(file_path, 'r')
  file_data_array = file.readlines

  file_data_array.each_with_index do |el, idx|
    if el.include?('binding.pry')
      hsh_with_err[:binding_pry] = "#{file_path}:#{idx+1}"
    elsif el.include?('.send')
      hsh_with_err[:send] = "#{file_path}:#{idx+1}"
    elsif el.include?('.public_send')
      hsh_with_err[:public_send] = "#{file_path}:#{idx+1}"
    end
  end
end

hsh_with_err.each {| key, value | puts "#{key} founded on the #{value}"  }