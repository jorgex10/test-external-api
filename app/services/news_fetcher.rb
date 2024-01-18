class NewsFetcher
  include HTTParty

  attr_reader :articles, :error

  API_KEY = '98be3e92020841bbb12ea0b95131dfcd'.freeze

  STATUS_RESPONSE = {
    ok: 'ok',
    error: "error"
  }.freeze

  def initialize(key_word)
    @url = "https://newsapi.org/v2/everything?q=#{key_word}&from=2024-01-17&to=2024-01-17&sortBy=popularity&apiKey=#{API_KEY}"
    @articles = []
    @error = ''
  end

  def fetch
    response = HTTParty.get(@url)

    if response['status'] == STATUS_RESPONSE[:ok]
      @articles = response['articles']
    else
      @error = response['message']
    end
  end

  def save_on_db
    return unless @articles.present?

    @articles.each do |article|
      Article.create(
        author: article['author'],
        title: article['title'],
        description: article['description'],
        url: article['url'],
        published_at: Time.parse(article['publishedAt']),
      )
    end
  end
end
