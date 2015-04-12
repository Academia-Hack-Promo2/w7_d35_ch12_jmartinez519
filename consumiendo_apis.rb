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

# Instacia las clases Reddit, Mashable y Digg.

class Feed
   
  def initialize site
    @newsarr = []
    case
     when site == :reddit
       @r = Reddit.new
       @formato_reddit = @r.format @r.getjson
       @newsarr.push(@formato_reddit)
       puts
       puts "===============================================".colorize(:yellow)
       puts "\t\t\tReddit".colorize(:yellow)
       puts "===============================================".colorize(:yellow)
       puts @newsarr
     when site == :mashable
       @m = Mashable.new
       @formato_mashable = @m.format @m.getjson
       @newsarr.push(@formato_mashable)
       puts "===============================================".colorize(:blue)
       puts "\t\t Mashable".colorize(:blue)
       puts "===============================================".colorize(:blue)
       puts @newsarr
     when site == :digg
       @d = Digg.new
       @formato_digg = @d.format @d.getjson
       @newsarr.push(@formato_digg)
       puts "===============================================".colorize(:red)
       puts "\t\t\tDigg".colorize(:red)
       puts "===============================================".colorize(:red)
       puts @newsarr
     else
      return "Error en el nombre del site"
    end
  end

  def first
    puts @newsarr
  end

end

# Instancia cada noticia para poder acceder a sus atributos.
class News

  attr_reader :author, :title, :date, :link, :feed 

  def initialize(author, title, date, link, feed)
    @author = author
    @title = title
    @date = date
    @link = link
    @feed = feed
  end

  def to_s
     format_news = "\n#{@author}"\
                   "\n#{@title}"\
                   "\n#{@date}"\
                   "\n#{@link}"\
                   "\n#{@feed}"
    return format_news
  end

end

class Reddit
  include HTTParty
  base_uri 'http://www.reddit.com/.json?limit=10'


    def getjson
      response = self.class.get('')
      return response
    end

  def format response
    noticias_reddit = []
      response["data"]["children"].each do |new|     
        author = new["data"]["author"]
        title = new["data"]["title"]
        date = Time.at(new["data"]["created_utc"])
        link = new["data"]["url"]
        feed = "reddit" 
        noticias_reddit.push(new_instance = News.new(author, title, date, 
                            link, feed))
      end
    return noticias_reddit
  end
end

class Mashable
  include HTTParty
  base_uri 'http://mashable.com/stories.json?limit=10'


  def getjson
    response = self.class.get('')
    return response
  end

  def format response
    noticias_mashable = []
    response["new"].each do |new|
      author = new["author"]  
      title = new["title"]
      date = new["post_date"]
      link = new["link"]
      feed = "mashable"
      noticias_mashable.push(new_instance = News.new(author, title, date, 
                            link, feed))
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
    #   noticias_mashable.push(resn)
    # end

    # response["rising"].each do |new|
    #   ress = {}
    #   ress["author"] = new["author"]  
    #   ress["title"] = new["title"]
    #   ress["date"] = new["post_date"]
    #   ress["link"] = new["link"]
    #   ress["feed"] = "mashable"
    #   noticias_mashable.push(ress)
    # end
    return noticias_mashable
  end
end

class Digg
  include HTTParty
  base_uri 'https://digg.com/api/news/popular.json?limit=10'


  def getjson
    response = self.class.get('')
    return response
  end

  def format response
    noticias_digg = []
    response["data"]["feed"].each do |new|
      author = new["content"]["author"] 
      title = new["content"]["title_alt"]
      date = Time.at(new["date_published"])
      link = new["content"]["url"]
      feed = "digg"
      noticias_digg.push(new_instance = News.new(author, title, date, link, 
                        feed))
    end
    return noticias_digg
  end
end

def main
  1.times do
    r = Feed.new(:reddit)

    m = Feed.new(:mashable)

    d = Feed.new(:digg)
  end
end

main

