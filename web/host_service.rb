class Config
  @instance = new
  @count = 0
  
  binding.pry

  private_class_method :new

  def self.instance
    if @count == 1
      puts "You try to create a new singleton. It can exist in one example"
      return
    end

    @count += 1

    @instance
  end

  def show_settings
    puts "settings for #{self}"
  end
end

s1 = Config.instance
s2 = Config.instance

puts s1
puts s2

puts s1.show_settings
puts s2.show_settings

Config.new