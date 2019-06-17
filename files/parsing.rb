require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class Parsing
  def scrape(keyword)
    recipes = []
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.search("#m_page #m_content .m_rechercher_recette .m_resultats_recherche .m_resultats_liste_recherche .m_item .m_contenu_resultat").each do |element|
      title = element.search(".m_titre_resultat").text.strip
      description = element.search(".m_texte_resultat").text.strip
      cooking_time_wrong = element.search(".m_detail_time > div").text
      cooking_time = cooking_time_wrong.strip.split(' ').first
      cooking_time = "#{cooking_time} min"
      recipes << Recipe.new(title, description, cooking_time)
    end
    return recipes
  end
end


