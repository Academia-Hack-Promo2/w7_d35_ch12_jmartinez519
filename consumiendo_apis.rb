# Hace aproximadamente 100 años internet, o lo que es lo mismo unos 10 años del calendario gregoriano, estaba en pleno furor que los websites de noticias, o en general, tuvieran lo que se denominaba los RSS... Lo que permitía a los usuarios leer noticias centralizadas en un RSS Reader... Queda de parte de ustedes investigar sobre esta bonita parte de la historia del internet.

# Actualmente, ya este tipo de difusión no es tan popular... Y muchos sitios ofrecen sus noticias en formato JSON.

# Se requiere que ustedes hagan clases en ruby que permitan consumir las APIs de estos 3 populares sitios de noticias en internet:

# Sitio: Mashable, API-Endpoint: http://mashable.com/stories.json

# Sitio: digg, API-Endpoint: http://digg.com/api/news/popular.json

# Sitio: Reddit, API-Endpoint: http://www.reddit.com/.json

# De todos los sitios lo que nos interesa obtener es: Autor, título, fecha y link de la noticia.

# Deben ustedes entonces crear las clases en ruby que soporten este requerimiento.

# La entrega debe hacerse vía github

require 'httparty'
require 'colorize'



class Reddit
  include HTTParty
  base_uri 'http://www.reddit.com/.json?limit=20'


  def news
    puts "=====================================================================".colorize(:red)
    puts "\t\t\t\tReddit".colorize(:red)
    response = self.class.get('')
    response["data"]["children"].each do |new|
    puts "#{new["data"]["author"]}".colorize(:blue)  
    puts "#{new["data"]["title"]} "
    puts "#{Time.at(new["data"]["created_utc"])}"
    puts "#{"https://www.reddit.com"+new["data"]["permalink"]}\n\n"
    end
  end
end

class Mashable
  include HTTParty
  base_uri 'http://www.reddit.com/.json?limit=10'


  def news
    puts "=====================================================================".colorize(:red)
    puts "\t\t\t\tMashable".colorize(:red)

    response = HTTParty.get("http://mashable.com/stories.json?limit=10")
    response["new"].each do |new|
    puts "#{new["author"]}".colorize(:blue)  
    puts "#{new["title"]} "
    puts "#{new["post_date"]}"
    puts "#{new["link"]}\n\n"
    end
  end
end

class Digg
  include HTTParty
  base_uri 'https://digg.com/api/news/popular.json'


  def news
    puts "=====================================================================".colorize(:red)
    puts "\t\t\t\tDigg".colorize(:red)

    response = HTTParty.get("https://digg.com/api/news/popular.json")
    response["data"]["feed"].each do |new|
    puts "#{new["content"]["author"]}".colorize(:blue)  
    puts "#{new["content"]["title_alt"]}"
    puts "#{Time.at(new["date_published"])}"
    puts "#{new["content"]["url"]}\n\n"
    end
  end
end

class Feed 

  def find
  end

  def show
  end


end

def main
  reddit_feed = Reddit.new
  reddit_feed.news
  mashable_feed = Mashable.new
  mashable_feed.news
  digg_feed = Digg.new
  digg_feed.news
end

main



