require 'amazon_product'
require 'pp'

YOUR_AMAZON_KEY           = ENV['AMAZON_KEY']
YOUR_AMAZON_SECRET        = ENV['AMAZON_SECRET']
YOUR_AMAZON_ASSOCIATE_TAG = ENV['AMAZON_ASSOCIATE_TAG']

# A minimal shell.
def in_your_shell
  started_at = Time.now
  resp = yield

  if resp.is_a? AmazonProduct::Response
    puts '>> resp.valid?', "=> #{resp.valid?}"
  else
    puts "#{(Time.now - started_at).round(1)}s"
  end

  loop do
    begin
      print '>> '
      line = STDIN.gets.strip
      break if line.empty? || %w{q e quit exit}.include?(line)
      out = eval(line)
      if out.is_a?(Hash) || out.is_a?(Array)
        pp out
      else
        print '=> '
        puts out.nil? ? 'nil' : out
      end
    rescue Exception => msg
      puts msg
    end
  end
end