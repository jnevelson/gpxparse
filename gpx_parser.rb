require 'nokogiri'
require 'active_support/core_ext'

class GpxParser
  attr_accessor :points

  def initialize
    @points = Hash.from_xml(File.open(ARGV[0]))
  end

  def elevation_diff
    gain = loss = 0
    points['gpx']['trk']['trkseg']['trkpt'].each_cons(2) do |p1, p2|
      d = p2['ele'].to_i - p1['ele'].to_i
      d > 0 ? gain += d : loss -= d
    end
    [gain, loss]
  end
end

