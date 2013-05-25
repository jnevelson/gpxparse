require 'nokogiri'

def build
  @points = []
  Nokogiri::XML.parse(File.open(ARGV[0])).xpath("//xmlns:trkpt").each_with_index do |ele, idx|
    dimensions = {
      :lat => ele.xpath('@lat')[0].content,
      :lon => ele.xpath('@lon')[0].content,
      :elevation => ele.xpath('xmlns:ele')[0].content.to_i,
      :time => ele.xpath('xmlns:time')[0].content
    }
    @points << dimensions
  end
end

def elevation_gain
  gain = 0
  @points.each_cons(2) do |p1, p2|
    d = p2[:elevation] - p1[:elevation]
    gain += d if d > 0
  end
  gain
end

build
puts elevation_gain
