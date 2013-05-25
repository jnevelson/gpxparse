require 'nokogiri'

locations = []
Nokogiri::XML.parse(File.open(ARGV[0])).xpath("//xmlns:trkpt").each do |ele|
  dimensions = {
    :lat => ele.xpath('@lat')[0].content,
    :lon => ele.xpath('@lon')[0].content,
    :elevation => ele.xpath('xmlns:ele')[0].content,
    :time => ele.xpath('xmlns:time')[0].content
  }
  locations << dimensions
end

puts locations
