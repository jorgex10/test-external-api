class V1::ArticlesController < V1Controller
  def index
    key_word = params[:key_word] || 'apple'

    if Article.count.zero?
      news_fetcher = NewsFetcher.new(key_word)
      news_fetcher.fetch

      if news_fetcher.error.present?
        return render json: { error: news_fetcher.error }, status: :unprocessable_entity
      end

      news_fetcher.save_on_db
    end

    render json: Article.all, status: :ok
  end
end
