module Spree
  Product.class_eval do 
    has_many :hashtags, class_name: 'Spree::Twitter::Hashtag', 
      :foreign_key => "value", 
      :primary_key => "hashtag"

    has_many :tweets, through: :hashtags, class_name: 'Spree::Twitter::Tweet'
  end
end