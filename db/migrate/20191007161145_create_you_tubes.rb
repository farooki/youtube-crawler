class CreateYouTubes < ActiveRecord::Migration[6.0]
  def change
    create_table :you_tubes do |t|
      t.string :url
      t.string :name
      t.string :profile_url
      t.string :cover_url
      t.string :subscribers
      t.integer :description
      t.jsonb :emails, default: []
      t.integer :views
      t.datetime :joined_at
      t.string :location
      t.integer :videos
      t.jsonb :links, default: {}
      t.boolean :is_crawled, default: false

      t.timestamps
    end
  end
end
