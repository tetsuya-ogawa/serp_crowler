# require 'nokogiri'
# require 'open-uri'

require './serp_item'
require 'uri'
require 'mechanize'

class SerpItemRepository
  def self.fetch(kw:)
    fetch_by_google(kw: kw)
  end

  private

  def self.fetch_by_google(kw:)
    search_url = "https://www.google.co.jp/search?hl=jp&gl=JP&"
    query = URI.encode_www_form(q: kw)
    search_url += query


    agent = Mechanize.new 
    doc = agent.get(search_url)

    [].tap do |me|
      doc.search('div.rc div.r').each_with_index do |item, index|
        title = item.search('h3').inner_text
        url = item.at('a').get_attribute(:href)
        me << SerpItem.new(title: title, url: url, rank: index + 1, kw: kw)
      end
    end
  end

  # def self.fetch_by_google(kw:)
  #   user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'

  #   search_url = "https://www.google.co.jp/search?hl=jp&gl=JP&"
  #   query = URI.encode_www_form(q: kw)
  #   search_url += query

  #   charset = nil

  #   begin
  #     html = open(search_url, 'User-Agent' => user_agent) do |f|
  #       charset = f.charset
  #       f.read
  #     end
  #   rescue => e
  #     p e
  #     raise e
  #   end

  #   doc = Nokogiri::HTML.parse(html, nil, charset)
  #   [].tap do |me|
  #     doc.css('div.rc div.r').each_with_index do |item, index|
  #       title = item.css('h3').inner_text
  #       url = item.at_css('a')[:href]
  #       me << SerpItem.new(title: title, url: url, rank: index + 1, kw: kw)
  #     end
  #   end
  # end
end
