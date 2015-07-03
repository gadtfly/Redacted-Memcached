require 'open-uri'
require 'dalli'

class StoredData
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def client
    @client ||= Dalli::Client.new('localhost:11211')
  end

  def get
    if data = get_
      data
    else
      puts 'talking to web'
      data = open(self.url).read
      set_(data)
    end
    data
  end

private

  def chunk_key(n)
    "#{url}#{n}"
  end

  def get_
    chunks = []
    n = 0
    while chunk = client.get(chunk_key(n))
      n += 1
      chunks << chunk
    end

    if n == 0
      nil
    else
      chunks.join
    end
  end

  def set_(data)
    chunks_for(data).each_with_index do |chunk, n|
      client.set(chunk_key(n), chunk)
    end
  end

  def chunks_for(data)
    data.chars.each_slice(100000).map(&:join)
  end
end
