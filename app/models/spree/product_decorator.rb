module Spree
  Product.class_eval do 
    has_one :hashtags, class_name: 'Spree::Twitter::Hashtag', 
      :foreign_key => "value", 
      :primary_key => "hashtag"

    has_many :tweets, through: :hashtags, class_name: 'Spree::Twitter::Tweet',
      :order => 'created_at DESC'

    before_save :assign_hashtag

    private

    def assign_hashtag
      hashtag = master.sku if hashtag.blank?
    end
  end
end