# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

I18n.locale = :fr
@site = Site.first 

@catalog = @site.catalogs.find_or_create_by_name!(
    :name => "collection",
    :title => "Collection",
    :parent_id => @site.sections.root.id,
    :accept_categories => true,
    :accept_stickers => false,
    :published_at => Time.zone.now)


@site.prototypes.all.map(&:destroy)
@site.properties.all.map(&:destroy)
@catalog.categories.all.map(&:destroy)
@catalog.products.all.map(&:destroy)

def create_image(name)
  image = @site.images.where("images.image_name like ?", "%#{name}%").first
  return image if image
  image = @site.images.create!(:image => File.new("#{File.dirname(__FILE__)}/images/product_#{name}.jpg"))
  return image
end

new_product_category = @catalog.categories.create(:name => "new", :title => "New Shapes")
best_product_category = @catalog.categories.create(:name => "best", :title => "Best Sellers")
cotton_limited_product_category = @catalog.categories.create(:name => "cotton_limited", :title => "Cotton Limited Edition")
silk_limited_product_category = @catalog.categories.create(:name => "silk_limited", :title => "Silk Limited Edition")

fabric_category = @catalog.categories.create!(:name => "fabric", :title => "Fabrics")
fabric_cotton_category = fabric_category.children.create!(:name => "fabric_cotton_category", :title => "Cotton", :section_id => @catalog.id)
fabric_silk_category = fabric_category.children.create(:name => "fabric_silk_category", :title => "Silk", :section_id => @catalog.id)
fabric_mix_category = fabric_category.children.create(:name => "fabric_mix_category", :title => "Mix", :section_id => @catalog.id)

shape_category = @catalog.categories.create(:name => "shapes", :title => "Shapes")
dress_shape_category = shape_category.children.create(:name => "dress_shape_category", :title => "Dress", :section_id => @catalog.id)
skirt_shape_category = shape_category.children.create(:name => "skirt_shape_category", :title => "Skirt", :section_id => @catalog.id)
pant_shape_category = shape_category.children.create(:name => "pant_shape_category", :title => "Pant / Short", :section_id => @catalog.id)
top_shape_category = shape_category.children.create(:name => "top_shape_category", :title => "Top", :section_id => @catalog.id)
tunic_shape_category = shape_category.children.create(:name => "tunic_shape_category", :title => "Tunic", :section_id => @catalog.id)
kimono_shape_category = shape_category.children.create(:name => "kimono_shape_category", :title => "Kimono", :section_id => @catalog.id)
combi_shape_category = shape_category.children.create(:name => "combi_shape_category", :title => "Combi", :section_id => @catalog.id)
poncho_shape_category = shape_category.children.create(:name => "poncho_shape_category", :title => "Poncho / Cover", :section_id => @catalog.id)
bikini_shape_category = shape_category.children.create(:name => "bikini_shape_category", :title => "Bikini", :section_id => @catalog.id)


@size_property = @site.properties.create({ :name => :size, :presentation => "Taille", :value_type => 'string' })
@option_type_fabric =  @site.option_types.create({ :name => :fabric, :presentation => "Tissu"})
@option_value_lace =  @option_type_fabric.option_values.create({ :name => :fabric, :presentation => "Lace"})   
@option_value_cotton_lurex =  @option_type_fabric.option_values.create({ :name => :fabric, :presentation => "Cotton lurex"})  
@option_value_crepe_chiffon =  @option_type_fabric.option_values.create({ :name => :fabric, :presentation => "Crepe chiffon"})  
@proto = @site.prototypes.create({ :name => :moto, :presentation => "Fabric" })

#-------

tunic_ivana = @catalog.products.create(
  :title => "Tunic Ivana", 
  :price => 75,
  :prototype_id => @proto.id
)

tunic_ivana.image_assignments.create(:image => create_image("tunic_ivana"))
tunic_ivana.categorizations.create(:category => new_product_category)
tunic_ivana.categorizations.create(:category => tunic_shape_category)  
tunic_ivana.product_properties.create(:property_id => @size_property.id, :value => "XS,S,M,L")

#-------

dress_leti = @catalog.products.create(
  :title => "Dress Leti", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_leti.image_assignments.create(:image => create_image("dress_leti"))
dress_leti.categorizations.create(:category => new_product_category)
dress_leti.categorizations.create(:category => dress_shape_category)  
dress_leti.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_magnolia = @catalog.products.create(
  :title => "Top Magnolia",  
  :price => 75,
  :prototype_id => @proto.id
)

top_magnolia.image_assignments.create(:image => create_image("top_magnolia"))

top_magnolia.categorizations.create(:category => new_product_category)
top_magnolia.categorizations.create(:category => top_shape_category)
top_magnolia.product_properties.create(:property_id => @size_property.id, :value => "S,M/L")

v = top_magnolia.variants.create(:price => 75) 
v.option_values << @option_value_lace  
v = top_magnolia.variants.create(:price => 75) 
v.option_values << @option_value_cotton_lurex 
v = top_magnolia.variants.create(:price => 75) 
v.option_values << @option_value_crepe_chiffon 
#-------

dress_rania = @catalog.products.create(
  :title => "Dress Rania", 
  :price => 95,
  :prototype_id => @proto.id
)

dress_rania.image_assignments.create(:image => create_image("dress_rania"))
# dress_rania.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 95)
dress_rania.categorizations.create(:category => new_product_category)
dress_rania.categorizations.create(:category => dress_shape_category)
dress_rania.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 

#-------

bikini_maya = @catalog.products.create(
  :title => "Bikini Maya", 
  :price => 75,
  :prototype_id => @proto.id
)

bikini_maya.image_assignments.create(:image => create_image("bikini_maya"))
# bikini_maya.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 75)
bikini_maya.categorizations.create(:category => new_product_category)
bikini_maya.categorizations.create(:category => bikini_shape_category)
bikini_maya.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_agatha = @catalog.products.create(
  :title => "Top Agatha", 
  :price => 75,
  :prototype_id => @proto.id
)

top_agatha.image_assignments.create(:image => create_image("top_agatha"))
# top_agatha.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 80)
top_agatha.categorizations.create(:category => new_product_category)
top_agatha.categorizations.create(:category => top_shape_category)
top_agatha.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_gardenia = @catalog.products.create(
  :title => "Dress Gardenia", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_gardenia.image_assignments.create(:image => create_image("dress_gardenia"))
# dress_gardenia.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 80)
dress_gardenia.categorizations.create(:category => new_product_category)
dress_gardenia.categorizations.create(:category => dress_shape_category)
dress_gardenia.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_darice = @catalog.products.create(
  :title => "Dress Darice", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_darice.image_assignments.create(:image => create_image("dress_darice"))
# dress_darice.print_assignments.create(:fabric => fabric_crochet, :price => 190)
# dress_darice.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 135)
# dress_darice.print_assignments.create(:fabric => fabric_lace, :price => 165)
dress_darice.categorizations.create(:category => new_product_category)
dress_darice.categorizations.create(:category => dress_shape_category)
dress_darice.product_properties.create(:property_id => @size_property.id, :value => "XS,S,M,L") 
#-------

short_lana = @catalog.products.create(
  :title => "Short Lana", 
  :price => 75,
  :prototype_id => @proto.id
)

short_lana.image_assignments.create(:image => create_image("short_lana"))
# short_lana.print_assignments.create(:fabric => fabric_lace, :price => 125)
short_lana.categorizations.create(:category => best_product_category)
short_lana.categorizations.create(:category => pant_shape_category)
short_lana.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_petula = @catalog.products.create(
  :title => "Top Petula", 
  :price => 75,
  :prototype_id => @proto.id
)

top_petula.image_assignments.create(:image => create_image("top_petula"))
# top_petula.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 75)
top_petula.categorizations.create(:category => new_product_category)
top_petula.categorizations.create(:category => top_shape_category)
top_petula.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_bianca = @catalog.products.create(
  :title => "Top Bianca", 
  :price => 75,
  :prototype_id => @proto.id
)

top_bianca.image_assignments.create(:image => create_image("top_bianca"))
# top_bianca.print_assignments.create(:fabric => fabric_lucknow, :price => 185)
top_bianca.categorizations.create(:category => new_product_category)
top_bianca.categorizations.create(:category => top_shape_category)
top_bianca.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_alycia = @catalog.products.create(
  :title => "Dress Alycia", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_alycia.image_assignments.create(:image => create_image("dress_alycia"))
# dress_alycia.print_assignments.create(:fabric => fabric_satin_silk, :price => 135)
# dress_alycia.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 95)
# dress_alycia.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 115)
dress_alycia.categorizations.create(:category => new_product_category)
dress_alycia.categorizations.create(:category => dress_shape_category)
dress_alycia.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_noa = @catalog.products.create(
  :title => "Dress Noa",  
  :price => 75,
  :prototype_id => @proto.id
)

dress_noa.image_assignments.create(:image => create_image("dress_noa"))
# dress_noa.print_assignments.create(:fabric => fabric_satin_silk, :price => 155)
dress_noa.categorizations.create(:category => new_product_category)
dress_noa.categorizations.create(:category => dress_shape_category)
dress_noa.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_adriana = @catalog.products.create(
  :title => "Dress Adriana", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_adriana.image_assignments.create(:image => create_image("dress_adriana"))
# dress_adriana.print_assignments.create(:fabric => fabric_satin_silk, :price => 135)
# dress_adriana.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 85)
dress_adriana.categorizations.create(:category => new_product_category)
dress_adriana.categorizations.create(:category => dress_shape_category)
dress_adriana.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_mathilda = @catalog.products.create(
  :title => "Dress Mathilda", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_mathilda.image_assignments.create(:image => create_image("dress_mathilda"))
# dress_mathilda.print_assignments.create(:fabric => fabric_crepe_chiffon, :price => 125)
# dress_mathilda.print_assignments.create(:fabric => fabric_lucknow, :price => 215)
dress_mathilda.categorizations.create(:category => new_product_category)
dress_mathilda.categorizations.create(:category => dress_shape_category)
dress_mathilda.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_brenda = @catalog.products.create(
  :title => "Dress Brenda", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_brenda.image_assignments.create(:image => create_image("dress_brenda"))
# dress_brenda.print_assignments.create(:fabric => fabric_crepe_chiffon, :price => 150)
dress_brenda.categorizations.create(:category => new_product_category)
dress_brenda.categorizations.create(:category => dress_shape_category)
dress_brenda.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

cover_mia = @catalog.products.create(
  :title => "Cover Mia", 
  :price => 75,
  :prototype_id => @proto.id
)

cover_mia.image_assignments.create(:image => create_image("cover_mia"))
# cover_mia.print_assignments.create(:fabric => fabric_satin_silk, :price => 165)
cover_mia.categorizations.create(:category => new_product_category)
cover_mia.categorizations.create(:category => poncho_shape_category)
cover_mia.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
#-------

dress_sasha = @catalog.products.create(
  :title => "Dress Sasha", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_sasha.image_assignments.create(:image => create_image("dress_sasha"))
# dress_sasha.print_assignments.create(:fabric => fabric_mix_satin_silk_crepe, :price => 210)
dress_sasha.categorizations.create(:category => new_product_category)
dress_sasha.categorizations.create(:category => dress_shape_category)
dress_sasha.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_bruna = @catalog.products.create(
  :title => "Top Bruna", 
  :price => 75,
  :prototype_id => @proto.id
)

top_bruna.image_assignments.create(:image => create_image("top_bruna"))
# top_bruna.print_assignments.create(:fabric => fabric_satin_silk, :price => 150)
top_bruna.categorizations.create(:category => new_product_category)
top_bruna.categorizations.create(:category => top_shape_category)
top_bruna.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_amanda = @catalog.products.create(
  :title => "Top Amanda", 
  :price => 75,
  :prototype_id => @proto.id
)

top_amanda.image_assignments.create(:image => create_image("top_amanda"))
# top_amanda.print_assignments.create(:fabric => fabric_mix_satin_silk_crepe, :price => 150)
top_amanda.categorizations.create(:category => new_product_category)
top_amanda.categorizations.create(:category => top_shape_category)
top_amanda.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

top_rosita = @catalog.products.create(
  :title => "Top Rosita",  
  :price => 75,
  :prototype_id => @proto.id
)

top_rosita.image_assignments.create(:image => create_image("top_rosita"))
# top_rosita.print_assignments.create(:fabric => fabric_mix_satin_silk_crepe, :price => 115)
top_rosita.categorizations.create(:category => new_product_category)
top_rosita.categorizations.create(:category => combi_shape_category)
top_rosita.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
#-------

combi_luisa = @catalog.products.create(
  :title => "Combi Luisa", 
  :price => 75,
  :prototype_id => @proto.id
)

combi_luisa.image_assignments.create(:image => create_image("combi_luisa"))
# combi_luisa.print_assignments.create(:fabric => fabric_satin_silk, :price => 115)
# combi_luisa.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 75)
combi_luisa.categorizations.create(:category => best_product_category)
combi_luisa.categorizations.create(:category => pant_shape_category)
combi_luisa.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

skirt_deva = @catalog.products.create(
  :title => "Skirt Deva", 
  :price => 75,
  :prototype_id => @proto.id
)

skirt_deva.image_assignments.create(:image => create_image("skirt_deva"))
# skirt_deva.print_assignments.create(:fabric => fabric_satin_silk, :price => 115)
skirt_deva.categorizations.create(:category => new_product_category)
skirt_deva.categorizations.create(:category => skirt_shape_category)
skirt_deva.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

pant_churidar = @catalog.products.create(
  :title => "Pant Churidar", 
  :price => 75,
  :prototype_id => @proto.id
)

pant_churidar.image_assignments.create(:image => create_image("pant_churidar"))
# pant_churidar.print_assignments.create(:fabric => fabric_satin_silk, :price => 110)
# pant_churidar.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 95)
pant_churidar.categorizations.create(:category => new_product_category)
pant_churidar.categorizations.create(:category => pant_shape_category)
pant_churidar.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

kimono_fabiana = @catalog.products.create(
  :title => "Kimono Fabiana", 
  :price => 75,
  :prototype_id => @proto.id
)

kimono_fabiana.image_assignments.create(:image => create_image("kimono_fabiana"))
# kimono_fabiana.print_assignments.create(:fabric => fabric_satin_silk, :price => 165)
# kimono_fabiana.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 95)
# kimono_fabiana.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 135)
# kimono_fabiana.print_assignments.create(:fabric => fabric_crepe_chiffon, :price => 155)
# kimono_fabiana.print_assignments.create(:fabric => fabric_lace, :price => 270)
kimono_fabiana.categorizations.create(:category => best_product_category)
kimono_fabiana.categorizations.create(:category => kimono_shape_category)
kimono_fabiana.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
#-------

dress_camelia = @catalog.products.create(
  :title => "Dress Camelia", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_camelia.image_assignments.create(:image => create_image("dress_camelia"))
# dress_camelia.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 95)
# dress_camelia.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 130)
# dress_camelia.print_assignments.create(:fabric => fabric_hakoba_cotton, :price => 120)
dress_camelia.categorizations.create(:category => best_product_category)
dress_camelia.categorizations.create(:category => dress_shape_category)
dress_camelia.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
#-------

tunic_ciriana = @catalog.products.create(
  :title => "Tunic Ciriana", 
  :price => 75,
  :prototype_id => @proto.id
)

tunic_ciriana.image_assignments.create(:image => create_image("tunic_ciriana"))
# tunic_ciriana.print_assignments.create(:fabric => fabric_satin_silk, :price => 145)
# tunic_ciriana.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 90)
# tunic_ciriana.print_assignments.create(:fabric => fabric_hakoba_cotton, :price => 120)
# tunic_ciriana.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 140)
# tunic_ciriana.print_assignments.create(:fabric => fabric_lucknow, :price => 185)
tunic_ciriana.categorizations.create(:category => best_product_category)
tunic_ciriana.categorizations.create(:category => tunic_shape_category)
tunic_ciriana.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_manuela = @catalog.products.create(
  :title => "Dress Manuela",  
  :price => 75,
  :prototype_id => @proto.id
)

dress_manuela.image_assignments.create(:image => create_image("dress_manuela"))
# dress_manuela.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 135)
dress_manuela.categorizations.create(:category => best_product_category)
dress_manuela.categorizations.create(:category => dress_shape_category)
dress_manuela.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

tunic_julia = @catalog.products.create(
  :title => "Tunic Julia",  
  :price => 75,
  :prototype_id => @proto.id
)

tunic_julia.image_assignments.create(:image => create_image("tunic_julia"))
# tunic_julia.print_assignments.create(:fabric => fabric_satin_silk, :price => 165)
tunic_julia.categorizations.create(:category => best_product_category)
tunic_julia.categorizations.create(:category => tunic_shape_category)
tunic_julia.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 

#-------

poncho_doraline = @catalog.products.create(
  :title => "Poncho Doraline", 
  :price => 75,
  :prototype_id => @proto.id
)

poncho_doraline.image_assignments.create(:image => create_image("short_lana"))
# poncho_doraline.print_assignments.create(:fabric => fabric_satin_silk, :price => 155)
# poncho_doraline.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 85)
# poncho_doraline.print_assignments.create(:fabric => fabric_crochet, :price => 230)
poncho_doraline.categorizations.create(:category => best_product_category)
poncho_doraline.categorizations.create(:category => poncho_shape_category)
poncho_doraline.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
#-------

poncho_betina = @catalog.products.create(
  :title => "Poncho Betina", 
  :price => 75,
  :prototype_id => @proto.id
)

poncho_betina.image_assignments.create(:image => create_image("poncho_betina"))
# poncho_betina.print_assignments.create(:fabric => fabric_satin_silk, :price => 165)
poncho_betina.categorizations.create(:category => best_product_category)
poncho_betina.categorizations.create(:category => poncho_shape_category)
poncho_betina.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

dress_paloma = @catalog.products.create(
  :title => "Dress Paloma", 
  :price => 75,
  :prototype_id => @proto.id
)

dress_paloma.image_assignments.create(:image => create_image("dress_paloma"))
# dress_paloma.print_assignments.create(:fabric => fabric_satin_silk, :price => 145)
# dress_paloma.print_assignments.create(:fabric => fabric_eyelet_cotton, :price => 125)
# dress_paloma.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 85)
# dress_paloma.print_assignments.create(:fabric => fabric_lace, :price => 185)
dress_paloma.categorizations.create(:category => best_product_category)
dress_paloma.categorizations.create(:category => dress_shape_category)
dress_paloma.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

pant_marni = @catalog.products.create(
  :title => "Pant Marni",  
  :price => 75,
  :prototype_id => @proto.id
)

pant_marni.image_assignments.create(:image => create_image("pant_marni"))
# pant_marni.print_assignments.create(:fabric => fabric_lace, :price => 190)
pant_marni.categorizations.create(:category => best_product_category)
pant_marni.categorizations.create(:category => pant_shape_category)
pant_marni.product_properties.create(:property_id => @size_property.id, :value => "S,M,L") 
#-------

gilet_gypsy = @catalog.products.create(
  :title => "Gilet Gypsy", 
  :price => 75,
  :prototype_id => @proto.id
)

gilet_gypsy.image_assignments.create(:image => create_image("gilet_gypsy"))
# gilet_gypsy.print_assignments.create(:fabric => fabric_lace, :price => 105)
gilet_gypsy.categorizations.create(:category => best_product_category)
gilet_gypsy.categorizations.create(:category => top_shape_category)
gilet_gypsy.product_properties.create(:property_id => @size_property.id, :value => "S/M,L") 
#-------

sarouel = @catalog.products.create(
  :title => "Sarouel", 
  :price => 125,
  :prototype_id => @proto.id
)

sarouel.image_assignments.create(:image => create_image("sarouel"))
sarouel.categorizations.create(:category => best_product_category)
sarouel.categorizations.create(:category => pant_shape_category)       
sarouel.product_properties.create(:property_id => @size_property.id, :value => "One Size") 
# sarouel.print_assignments.create(:fabric => fabric_crepe_chiffon, :price => 125)
# sarouel.print_assignments.create(:fabric => fabric_cotton_lurex, :price => 85)




