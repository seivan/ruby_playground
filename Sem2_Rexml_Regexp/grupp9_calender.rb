#!/usr/bin/ruby

require 'rexml/document'
include REXML
require "open-uri"




def get_website(url)
  Document.new(open(url))
end

def print_page(website)
    stuff = Array.new
    doc = get_website(website)
    
    XPath.each(doc, "//div") do |e| 
      if e.attributes["class"] == "vevent"
        e[1].elements.each("child::node()//") do |e|
          #puts e
          
          if e.attributes["class"] == "summary"
            #puts
            #puts e[0]
            stuff << "\n"
            stuff << e[0]

          elsif e.attributes["class"] == "description"
            #puts e[1].text
            stuff << e[1].text
        
          elsif e.attributes["class"] == "dtstart"
            #puts e[0]
            stuff << e[0]
       
          elsif e.attributes["class"] == "locality"
            #puts e[0]
            stuff << e[0]
       
          elsif e.attributes["class"] == "region"
            #puts e[0]
            stuff << e[0]      
          end
        end
     
    elsif e.attributes["class"] == "vcard"
        e.elements.each("child::node()//") do |e|
          #puts e
      
          if  e.attributes["class"] == "org fn"
            #puts e[0]
            stuff << e[0]

          elsif e.attributes["class"] == "street-address"
            #puts e[0]
            stuff << e[0]
        end
      end
    end
  end
    puts stuff
end


print_page("http://www.ida.liu.se/~TDP007/material/seminarie2/events.html")
