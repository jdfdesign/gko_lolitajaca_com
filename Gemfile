source :rubygems

group :assets do
 gem 'sass-rails', '~> 3.2.6'
 gem 'coffee-rails', '~> 3.2.2'
 gem 'uglifier', '>= 1.0.3'
end

group :production do
  git "git@github.com:jdfdesign/gko_cms3.git", :branch => "master" do
    gem "gko_core"
    gem "gko_categories"
    gem "gko_stickers"
  end
  gem "gko_catalog", :git => 'git@github.com:jdfdesign/gko_catalog.git', :branch => "master"
end

gem 'therubyracer'
gem 'execjs'
#group :development, :test do
#  gem "gko_core", :path => '~/Github/gko_cms3/gko_core'
#  gem "gko_catalog", :path => '~/Github/gko/gko_catalog' 
#  gem "gko_categories", :path => '~/Github/gko_cms3/gko_categories'
#  gem "gko_stickers", :path => '~/Github/gko_cms3/gko_stickers'
#end
