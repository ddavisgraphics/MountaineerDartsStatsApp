require 'rubygems'
require 'nokogiri'
require 'csv'

f = File.open("/tmp/preview.html")
doc = Nokogiri::HTML(f)
csv = CSV.open("/tmp/output.csv", 'w',{:col_sep => ",", :quote_char => '\'', :force_quotes => true})

doc.xpath('//table/tbody/tr').each do |row|
  tarray = [] 
  row.xpath('td').each do |cell|
    tarray << cell.text
  end
  csv << tarray
end

csv.close