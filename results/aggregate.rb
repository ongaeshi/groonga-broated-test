results = {}

ARGV.each do |filename|
  results[filename] = []

  open(filename).each_line do |line|
    results[filename] << $1.to_i if line =~ /(\d+)M\s+.\/db/
  end
end

(1..results.first[1].size).each do |index| 
  puts results.map {|key, value|
    value[index]
  }.join(", ")
end
