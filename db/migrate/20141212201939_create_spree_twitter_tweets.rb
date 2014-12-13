class CreateSpreeTwitterTweets < ActiveRecord::Migration
  def change
    create_table :spree_twitter_tweets do |t|
      t.string :in_reply_to_screen_name
      t.integer :in_reply_to_status_id
      t.integer :in_reply_to_user_id
      t.string :lang
      t.integer :retweet_count
      t.string :source
      t.text :text
      t.text :attrs
      t.string :full_text
      t.string :url
      t.timestamps
    end
  end
end
