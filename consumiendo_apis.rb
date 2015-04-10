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

class Feed
  def initialize
    @newsarr = []
  end

  def new site
    case
     when site == "reddit"
       @r = Reddit.new
       @formato_reddit = @r.format @r.news
       @newsarr.push(@formato_reddit)
       puts @newsarr.first
     when site == "mashable"
       @m = Mashable.new
       @formato_mashable = @m.format @m.news
       @newsarr.push(@formato_mashable)
       puts @newsarr
     when site == "digg"
       @d = Digg.new
       @formato_digg = @d.format @d.news
       @newsarr.push(@formato_digg)
       puts @newsarr
     else
      return "Error en el nombre del site"
    end
  end

  # def author name
  #  # arr.map { |a| 2*a }
  #   @newsarr.map do |new| 
  #     if new["author"] == name
  #     end
  #   end 
  # end

end

class Noticias

  def res

  end
end

class Reddit
  include HTTParty
  base_uri 'http://www.reddit.com/.json?limit=20'


    def news
      response = self.class.get('')
      return response
    end

  def format response
    noticias = []
      response["data"]["children"].each do |new|
        res = {}      
        res["autor"] = new["data"]["author"]
        res["title"] = new["data"]["title"]
        res["date"] = Time.at(new["data"]["created_utc"])
        res["link"] = new["data"]["url"]
        res["feed"] = "reddit" 
        noticias.push(res)
      end
    return noticias
  end
end

class Mashable
  include HTTParty
  base_uri 'http://mashable.com/stories.json'


  def news
    response = self.class.get('')
    return response
  end

  def format response
    noticias = []
    response["new"].each do |new|
      res = {}
      res["author"] = new["author"]  
      res["title"] = new["title"]
      res["date"] = new["post_date"]
      res["link"] = new["link"]
      res["feed"] = "mashable"
      noticias.push(res)
    end

# Verificar como haher merge de todas las noticias
# de Mashable

    # response["hot"].each do |new|
    #   resn = {}
    #   resn["author"] = new["author"]  
    #   resn["title"] = new["title"]
    #   resn["date"] = new["post_date"]
    #   resn["link"] = new["link"]
    #   resn["feed"] = "mashable"
    #   noticias.push(resn)
    # end

    # response["rising"].each do |new|
    #   ress = {}
    #   ress["author"] = new["author"]  
    #   ress["title"] = new["title"]
    #   ress["date"] = new["post_date"]
    #   ress["link"] = new["link"]
    #   ress["feed"] = "mashable"
    #   noticias.push(ress)
    # end
    return noticias
  end
end

class Digg
  include HTTParty
  base_uri 'https://digg.com/api/news/popular.json'


  def news
    response = self.class.get('')
    return response
  end

  def format response
    noticias = []
    response["data"]["feed"].each do |new|
      res = {}
      res["author"] = new["content"]["author"] 
      res["title"] = new["content"]["title_alt"]
      res["date"] = Time.at(new["date_published"])
      res["link"] = new["content"]["url"]
      res["feed"] = "digg"
      noticias.push(res)
    end
    return noticias
  end
end

def main
  while true
    init = Feed.new
    puts "¿Que sitio de noticias desea ver? Opciones: reddit, mashable, digg.".colorize(:blue)
    site = gets.chomp.to_s.downcase
    puts init.new site
    puts "¿Que author quieres ver?"
    # author = gets.chomp.to_s.downcase
    # puts init.author author
  end
end

main

# r = Feed.new(:reddit)
# r.First.author

# d = Feed.now(:digg)
# d.First.author
# d.First.Feed



