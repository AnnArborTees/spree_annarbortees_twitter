class AddHashtagToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :hashtag, :string
  end
end
