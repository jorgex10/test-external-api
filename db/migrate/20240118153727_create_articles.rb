class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.text :description
      t.string :url
      t.datetime :published_at

      t.timestamps
    end
  end
end
