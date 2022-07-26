require 'pry'
require_relative 'error_handler'

# binding.pry
# send && public_send

class FileAudior
  def initialize
    @arr_of_files_path = check_file_path?(ARGV[0]) || Dir['./app/*.rb'] + Dir['./web/*.rb']
    @founded_errors = {}
    @specific_cop = ARGV[1]
  end

  def call
    find_warnings
    show_errors
  end

  private

  attr_reader :arr_of_files_path, :founded_errors, :specific_cop

  def find_warnings
    arr_of_files_path.each do |file_path|
      file = File.open(file_path, 'r')
      file_data_array = file.readlines

      file_data_array.each_with_index do |el, idx|
        case
        when el.include?('binding.pry')
          founded_errors[:binding_pry] = message(file_path, idx, ErrorHandler::BindingError.new)
        when el.include?('.send')
          founded_errors[:send] = message(file_path, idx, ErrorHandler::SendMethodError.new)
        when el.include?('.public_send')
          founded_errors[:public_send] = message(file_path, idx, ErrorHandler::SendMethodError.new)
        end
      end
      file.close
    end
  end

  def check_file_path?(file_path)
    file_path ? [file_path] : nil
    #raise ErrorHandler::NotFoundError.new(file_path)
  end

  def message(file_path, index, error)
    "#{file_path}:#{index+1}: #{error}:"
  end

  def show_errors
    if specific_cop
      puts "#{founded_errors[specific_cop.to_sym]} found #{specific_cop}"
    else
      founded_errors.each { |key, value| puts "#{value} found #{key}" }
    end
  end
end

FileAudior.new.call