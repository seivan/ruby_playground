

 #  students = File.new("studenter.txt")
#students.each do |x| puts x.split(/:+/)[0..5] end


test = {"Ake" => "kerström", "Karl" => "Karlsson", "Axel" => "Axelson"}
#puts test.sort do |k, v| k[1]<=>v[1] end

class Students
  def initialize(file)
    @students = File.new(file)
    @list = {}
   end

  def get_names(data, rows)
    return data.split(/\:+/)[rows]
  end

  
  def insert
    @students.each do 
    |data|
    @list[get_names(data, 1)] = get_names(data, 2)
    end
    return @list
  end

  def sorter
    @sorted_list = insert.sort do |k, v| k[1] <=> v[1] end
    return @sorted_list
end
    
    
end

def tester()
test = Students.new("studenter.txt")
puts test.insert.inspect
test.sorter.each do |name, surname| puts "#{name} #{surname}" end
end

tester
