require 'bases'
require 'json'

class Shrink
  @@bucket = {}
  def self.generate_for_url(url)
    Bases.val(url.hash.abs.to_s).in_base(10).to_base(Bases::B62)
  end

  def self.save(url, remap)
    @@bucket[remap] = url
    File.open('shrunk.urls','a') do |f|
      f.write("#{JSON.generate({link: remap, url: url})}\n")
    end
  end

  def self.resolve(remap)
    IO.readlines('shrunk.urls','r+') do |line|
      shr = JSON.parse(line)
      @@bucket[shr['link']] = shr['url']
    end
    puts "Entire bucket #{@@bucket}"
    @@bucket[remap]
  end
end
