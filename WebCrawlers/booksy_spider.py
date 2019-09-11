import scrapy


class BooksySpider(scrapy.Spider):
	name = "booksy"
	start_urls = [
		'https://booksy.net/pt-br/1047773_sao-paulo' ,
	]
#	def start_requests(self):
#		url = 'https://booksy.net/pt-br/1047773_sao-paulo'
#		yield scrapy.Request(url=url, callback=self.parse)

	def parse(self, response):
		div = response.css('div.col-md-7')
		urls = div.css('a.search__list__header__title__link::attr(href)').extract()
		for url in urls:
			url = response.urljoin(url)
			yield scrapy.Request(url, callback=self.parse_content, dont_filter=True)
		next_page = response.css('li.next a::attr(href)').extract_first()
		if next_page is not None:
			next_page = response.urljoin(next_page)
			yield scrapy.Request(next_page, callback=self.parse)

	def parse_content(self, response):
		box = response.css('div.box')
		telefone = box.css('a::text')
		endereco = box.css('span::text')
		nome = box.css('strong::text')
		yield{
			'Nome': nome.extract(),
			'Telefone': telefone[1].extract(),
			'Endereco': endereco[0].extract(),
		}
