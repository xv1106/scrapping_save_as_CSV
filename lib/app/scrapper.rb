require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapper
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def scrape_emails
    doc = Nokogiri::HTML(URI.open(url))
    mairies_page = doc.xpath('//div[contains(@class, "directory-block")]')

    mairies_hash = {}
  
    mairies_page.each do |info|
      city = info.xpath('.//h2').text.strip
      email = info.xpath('.//p[3]/a').text.strip
      unless mairies_hash.key?(city)
        mairies_hash[city] = email
      end
    end

    mairies_hash
  end

  def save_as_json(emails_hash)
    File.open('db/emails.json', 'w') do |file|
      file.write(emails_hash.to_json)
    end
  end

  def save_as_csv(emails_hash)
    CSV.open('db/emails.csv', 'w') do |csv|
      csv << ['City', 'Email'] # Écriture de l'en-tête du fichier CSV
      emails_hash.each do |city, email|
        csv << [city, email] # Écriture de chaque ligne du fichier CSV
      end
    end
  end
end
