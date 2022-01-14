class EditFeaturedInProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :featured
    add_column :products, :featured, :boolean, default: false
  end
end
