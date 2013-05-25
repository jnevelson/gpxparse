require 'nokogiri'

class GpxParser
  attr_accessor :points

  def initialize
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

  def elevation_diff
    gain = 0
    loss = 0
    @points.each_cons(2) do |p1, p2|
      d = p2[:elevation] - p1[:elevation]
      gain += d if d > 0
      loss += d if d < 0
    end
    [gain, loss]
  end
end

gain, loss = GpxParser.new.elevation_diff
puts "Elevation gain: #{gain}m"
puts "Elevation loss: #{loss}m"
