import scrapy
from bs4 import BeautifulSoup

class TrinksSpider(scrapy.Spider):
	name = 'trinks'
	start_urls = [
		'http://www.trinks.com/sp/sao-paulo'
	]

	def parse(self, response):
		soup = BeautifulSoup( response.body, 'html.parser' )
		saloes = soup.findAll( 'div', {'class' : 'lista-item'})
		for salao in saloes:
			nome = salao.find('a', {'class' : 'nome-cliente'}).string
			endereco = salao.find('p', {'class' : 'endereco'}).string
			yield{
					 'Nome' : nome,
					 'Endereco' : endereco
				 }

