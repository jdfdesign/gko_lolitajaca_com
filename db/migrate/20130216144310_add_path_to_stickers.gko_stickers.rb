# This migration comes from gko_stickers (originally 20130203153200)
class AddPathToStickers < ActiveRecord::Migration
  
  include Globalize::ActiveRecord::Migration
  
  class Sticker < ActiveRecord::Base
    @translated_fields = { :path => :string }

    def self.translated_fields
      @translated_fields
    end

    translates *@translated_fields.keys
  end
    
  def up
    add_column :stickers, :path, :string

    Sticker.reset_column_information
    Sticker.translated_fields.each_pair { |field, type| add_column :sticker_translations, field, type }
  end

  def down
    # Do stuff to put the data back using the migrator from Globalize
    Sticker.reset_column_information
    # And remove unused columns
    Sticker.translated_fields.keys.each { |field| remove_column :sticker_translations, field }
    remove_column :stickers, :path

  end
end
