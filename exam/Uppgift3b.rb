require 'rexml/document'
include REXML

def print_page(file)
    collector = []
    doc = Document.new(File.new(file))
    #puts doc

    XPath.each(doc, "//span") do |e| 
      if e.attributes["class"] == "txtbold"
        puts e.text
        end
      # e.elements.each("child::node()") do |e|
       #  puts e
      
      #end
    #end
    end
end

puts print_page("tdp007.html")
