require 'open-uri.rb'

#
# Extract HTML tags from a webpage
#
def tag_names(html)
  re = /<([a-zA-Z]+)/
  test = html.scan(re)
  puts test
end

def parse_website(url)
  if url.scan(/^http:/).length > 0
    html = open(url) { |f| f.read }
    tag_names(html)
  end
end

# Extract username from a string
def extract_username(str)
  #s = "USERNAME: Brian\nUSERNAME: Mats\nUSERNAME:beta"
  matches = str.scan(/(USERNAME: [a-zA-Z0-9]+)/)
  return matches
end
