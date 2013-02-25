# This migration comes from gko_catalog (originally 20130106090300)
class CreateCatalogTables < ActiveRecord::Migration
  
  def change

    create_table :products, :force => true  do |t|
      t.integer :section_id, :null => false
      t.integer :site_id, :null => false
      t.text :body
      t.string :title
      t.string :meta_title
      t.string :meta_description
      t.string :slug
      t.date :available_on
      t.timestamps
    end
    add_index :products, :section_id, :name => "index_products_on_section"
    add_index :products, :site_id, :name => "index_products_on_site_id"
    
    create_table :variants do |t|
      t.string     :sku, :default => '', :null => false
      t.boolean    :is_master, :default => false, :null => false
      t.references :product
      t.integer    :position
      t.decimal    :price
    end

    add_index :variants, [:product_id], :name => 'index_variants_on_product_id'

    create_table :option_values_variants, :id => false, :force => true do |t|
      t.integer :variant_id
      t.integer :option_value_id
    end

    add_index "option_values_variants", ["variant_id", "option_value_id"], :name => "index_option_values_variants_on_variant_id_and_option_value_id"
    add_index "option_values_variants", ["variant_id"], :name => "index_option_values_variants_on_variant_id"
    
    create_table :option_types, :force => true  do |t|
      t.integer   :site_id, :null => false
      t.string    :name,         :limit => 100
      t.string    :presentation, :limit => 100
      t.integer   :position, :default => 0, :null => false
      t.timestamps
    end
    
    add_index :option_types, :site_id, :name => "index_option_types_on_site_id"
    
    create_table :option_values, :force => true  do |t|
      t.integer    :position
      t.string     :name
      t.string     :presentation
      t.references :option_type
      t.timestamps
    end

    create_table :product_option_types, :force => true  do |t|
      t.integer    :position
      t.references :product
      t.references :option_type
      t.timestamps
    end
    add_index :product_option_types, [:product_id], :name => "index_product_option_types_product_id"
    
    create_table :properties, :force => true  do |t|
      t.references :site
      t.string     :name
      t.string     :value_type, :default => 'string', :null => false
      t.string     :presentation, :null => false
      t.timestamps
    end
    
    add_index :properties, :site_id, :name => "index_properties_on_site_id"
    
    create_table :product_properties, :force => true  do |t|
      t.string     :value
      t.references :product
      t.references :property
      t.timestamps
    end

    add_index :product_properties, [:product_id], :name => 'index_product_properties_on_product_id'    
    
    create_table :option_types_prototypes, :id => false, :force => true  do |t|
      t.references :prototype
      t.references :option_type
    end
    
    create_table :properties_prototypes, :id => false, :force => true  do |t|
      t.references :prototype
      t.references :property
    end
    
    create_table :prototypes, :force => true  do |t|
      t.references :site
      t.string     :name
      t.timestamps
    end
    
    add_index :prototypes, :site_id, :name => "index_prototypes_on_site_id"
    
    create_table :product_translations, :force => true  do |t|
      t.integer :product_id, :null => false
      t.string :locale, :null => false
      t.string :title
      t.text :body
      t.string :meta_title
      t.string :meta_description
      t.string :slug
      t.timestamps
    end
    add_index :product_translations, [:product_id, :locale], :name => "index_product_translations_on_product_and_locale"
  
    create_table :option_value_translations, :force => true  do |t|
      t.integer :option_value_id, :null => false
      t.string :locale, :null => false
      t.string  :presentation
      t.timestamps
    end
    add_index :option_value_translations, [:option_value_id, :locale], :name => "index_option_value_translations_on_option_value_and_locale"
  
    create_table :property_translations, :force => true  do |t|
      t.integer :property_id, :null => false
      t.string :locale, :null => false
      t.string :presentation
      t.timestamps
    end
    add_index :property_translations, [:property_id, :locale], :name => "index_property_translations_on_property_and_locale"
  end
end