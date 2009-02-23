class Sorter
  attr_reader :values, :keys, :list_hash
  
  def initialize(file)
    @file = File.open(file) { |io| io.read } #Send the buffer to the beginning
    @values = Array.new()
    @keys = Array.new()
    @filename = file
    @list = sort()
  end
  
  def parse_values(value, first, second)
   if value.split(/\s+/)[first].to_i != nil
     #puts (value.split(/\s+/)[first].to_i - value.split(/\s+/)[second].to_i).abs
     return (value.split(/\s+/)[first].to_i - value.split(/\s+/)[second].to_i).abs
   end
  end

  def parse_keys(key, first)
    #puts key.split(/\s+/)[first]
    return key.split(/\s+/)[first]
  end

  def make_hash(keys, values)
    @list_hash = {}
    keys.size.times { |i| @list_hash[ keys[i] ] = values[i] }
    @list_hash
  end
  
  def sort_football()
    @file.each do 
    |data|
    @values << parse_values(data, 7, 9) if parse_values(data, 7, 9) > 0 
    @keys << parse_keys(data, 2)  if parse_keys(data, 2) =~ /^[A-Z][a-z_]+/
    end
    make_hash(@keys, @values).sort { |a,b| a[1] <=> b[1] }
  end
  
  def sort_weather()
    @file.each do 
    |data|
    if parse_values(data, 2, 3) > 0 && parse_values(data, 7, 9) != 2002
    @values << parse_values(data, 2, 3) 
    @keys << parse_keys(data, 1) if parse_keys(data, 1) =~ /\d+/
  end
    end
      @values = @values[1..-2]
    make_hash(@keys, @values).sort { |a,b| a[1] <=> b[1] }
  end
  
  def sort()
    if @filename.eql?("weather.txt")
      sort_weather() 
    
    elsif @filename.eql?("football.txt")
      sort_football()       
    end
  end 
    
  def print_result()
    puts "The Winner is: #{@list[0][0]}\n______________________"
    @list.each {|element| puts "Key: #{element[0]} =>  Value: #{element[1]}" }
  end
end


#http://www.xml.com/pub/a/2005/11/09/rexml-processing-xml-in-ruby.html
