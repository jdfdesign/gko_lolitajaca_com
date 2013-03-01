# This migration comes from gko_catalog (originally 20130301090200)
class TranslateOptionTypes < ActiveRecord::Migration
  
  include Globalize::ActiveRecord::Migration
  
  class OptionType < ActiveRecord::Base
    @translated_fields = {
      :presentation => :string
    }

    def self.translated_fields
      @translated_fields
    end

    translates *@translated_fields.keys
  end

  def up
    OptionType.reset_column_information
    OptionType.create_translation_table!(OptionType.translated_fields, :migrate_data => true)
  end

  def down
    OptionType.drop_translation_table!
  end
end