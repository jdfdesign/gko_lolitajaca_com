# This migration comes from gko_catalog (originally 20130301102900)
class ResetProductsPositionValue < ActiveRecord::Migration
  def up
    add_index :products, [:position, :section_id] 
    Product.reset_column_information
    Product.all(:order => "created_at DESC").each_with_index do |p, i|
      puts p.title
      p.update_attribute(:position, i+1)
    end
  end

  def down
    remove_index :products, [:position, :section_id]
  end
end    
