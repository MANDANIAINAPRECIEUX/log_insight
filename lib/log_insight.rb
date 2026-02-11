require 'csv'
require 'json'

class LogInsight
  def self.run(file_path, filter_method: nil, filter_route: nil)
    unless File.exist?(file_path)
      puts "Error: file not found"
      return
    end

    total_lines = 0
    method_counts = Hash.new(0)
    status_counts = Hash.new(0)
    error_count = 0

    output_dir = "output"
    Dir.mkdir(output_dir) unless Dir.exist?(output_dir)

    File.foreach(file_path) do |line|
      parts = line.split(" ")
      next if parts.size < 5  

      method = parts[2]
      route  = parts[3]
      status = parts[4].to_i

     
      next if filter_method && method != filter_method
      next if filter_route  && route  != filter_route

     output_file = File.join(output_dir, "#{method}.log")

        File.open(output_file, "a") do |file|
        file.puts line
        end

      total_lines += 1
      method_counts[method] += 1
      status_counts[status] += 1
      error_count += 1 if status >= 400
    end

   
    puts "Log Insight Report"
    puts "------------------"
    puts "\nEntries by HTTP method:"
    method_counts.sort_by { |_, c| -c }.each { |m, c| puts "  #{m}: #{c}" }

    puts "\nEntries by status code:"
    status_counts.sort_by { |_, c| -c }.each { |s, c| puts "  #{s}: #{c}" }

    puts "\nErrors (status >= 400): #{error_count}"
    puts "Total log entries: #{total_lines}"

    # GRAPH
    puts "\nGraphical view of HTTP methods:"
    method_counts.sort_by { |_, c| -c }.each do |m, c|
      puts "#{m.ljust(6)} | #{'#' * c} (#{c})"
    end

   puts "\nGraphical view of Status codes:"
status_counts.sort_by { |_, c| -c }.each do |status, count|
  bars = count / 100
  bars = 1 if bars == 0 && count > 0 

  puts "#{status} | #{'#' * bars} (#{count})"
end

puts "\nNote: 1 # = 100 requests"


   
    CSV.open("report.csv", "w") do |csv|
      csv << ["Method", "Count"]
      method_counts.each { |m, c| csv << [m, c] }

      csv << []  
      csv << ["Status", "Count"]
      status_counts.each { |s, c| csv << [s, c] }
    end

   
    File.write("report.json", {
      methods: method_counts,
      status: status_counts,
      errors: error_count,
      total: total_lines
    }.to_json)

    puts "\nReports exported: report.csv, report.json"
  end
end


