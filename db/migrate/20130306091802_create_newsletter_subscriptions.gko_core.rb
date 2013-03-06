# This migration comes from gko_core (originally 20130306100600)
class CreateNewsletterSubscriptions < ActiveRecord::Migration
  def change
    create_table :newsletter_subscriptions do |t|
      t.references :site
      t.string :email
      t.timestamps
    end
  end
end