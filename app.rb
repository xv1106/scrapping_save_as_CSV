require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__)
require 'scrapper' # Assure-toi que le nom du fichier est correctement orthographié

# Instanciation du scraper avec l'URL du site à scraper
url = "https://www.aude.fr/annuaire-mairies-du-departement"
scrapper = Scrapper.new(url)

# Récupération des emails
emails_hash = scrapper.scrape_emails

# Enregistrement des emails au format JSON
scrapper.save_as_csv(emails_hash)

puts "Scraping et enregistrement terminés avec succès !"
