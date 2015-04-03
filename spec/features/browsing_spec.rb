require 'spec_helper'

describe ShopController  do
  it "lists shows root" do
    prod = create :shop_product
    visit_path root_path
  end
  it "shows a product" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
  end
  it "shows a product that has no inventory" do
    prod = create :shop_product_without_inventory
    visit_path shop_product_path(prod.link)
  end
  it "disables button for product that has no inventory" do
    prod = create :shop_product_without_inventory
    visit_path shop_product_path(prod.link)
    button = find_button "add-to-cart-button" 
    expect(button[:class]).to include "disabled"
  end
  it "doesnt add product that has no inventory" do
    prod = create :shop_product_without_inventory
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    ensure_path shop_group_path(prod.category.link)
  end
  it "redirects for non product" do
    prod = create :shop_product
    visit shop_product_path("no_such_thing")
    ensure_path shop_main_path
  end
  it "shows a group" do
    prod = create :shop_product
    visit_path shop_group_path(prod.category.link)
  end
  it "adds a product" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    ensure_path shop_group_path(prod.category.link)
  end
  it "adds a product to checkout" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    visit_path shop_checkout_path
  end
  it "shows a static page" do
    visit_path shop_page_path :tuotteista
  end
  it "renders welcome page" do
    visit_path shop_welcome_path
  end
end
