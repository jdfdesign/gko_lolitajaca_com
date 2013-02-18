# This migration comes from gko_stickers (originally 20110419175909)
class GkoStickersTranslate < ActiveRecord::Migration
  
  include Globalize::ActiveRecord::Migration
  
  class Sticker < ActiveRecord::Base
    @translated_fields = {
      :name => :string
    }

    def self.translated_fields
      @translated_fields
    end

    translates *@translated_fields.keys
  end
  
  
  def up

    # create translation table
    Sticker.reset_column_information
    Sticker.create_translation_table!(Sticker.translated_fields, :migrate_data => true)

    #add_index "sticker_translations", ["sticker_id"], :name => "index_sticker_translations_on_content_id"
    #add_index "sticker_translations", ["locale"], :name => "index_sticker_translations_on_locale"
  end

  def down
    Sticker.drop_translation_table!
  end
end