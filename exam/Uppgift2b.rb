class Button
  def initialize(&block)
    #block.call
    @pressed = false
    @caller = block
    end

 
  def push()
    if @pressed == false
      @pressed = true
      @caller.call
    elsif @pressed == true
    @pressed = false
    end
  end

end

test = Button.new do puts "It's on biatch" end
5.times do puts test.push end
