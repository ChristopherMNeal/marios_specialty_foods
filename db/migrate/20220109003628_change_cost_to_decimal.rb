class ChangeCostToDecimal < ActiveRecord::Migration[5.2]
  def change
    remove_column(:products, :cost)
    add_column(:products, :cost, :decimal, :precision => 8, :scale => 2)
  end
end
