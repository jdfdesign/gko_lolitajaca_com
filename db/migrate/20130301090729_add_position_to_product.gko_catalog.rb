# This migration comes from gko_catalog (originally 20130301085800)
class AddPositionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :position, :integer, :default => 1, :null => false
    add_column :products, :visible, :boolean, :default => 1, :null => false
    add_column :products, :options, :text
  end
end