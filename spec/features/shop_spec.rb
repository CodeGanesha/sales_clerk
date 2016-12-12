require 'spec_helper'

describe "shop checkout"  do
  def prepare_check
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    visit_path shop_checkout_path
  end
  it "fails checkout without email" do
    prepare_check
    choose(:validation)
    click_button "make_order"
    expect(page).to have_content( I18n.t(:fix_errors))
    ensure_path shop_checkout_path
  end
  it "doesnt checkout without accepting" do
    prepare_check
    click_button "make_order"
    expect(page).to have_content( I18n.t(:must_accept))
    ensure_path shop_checkout_path
  end
  def prepare_check_and_order email = "info@auringostaitaan.fi"
    prepare_check
    choose(:validation)
    fill_in( :order_email , with: email) if email
    fill_in :order_name ,  with: "Other Guy"
    fill_in :order_street ,  with: "Lives here"
    fill_in :order_city ,  with: "GuyTown"
    fill_in :order_phone ,  with: "040404040"
    click_button "make_order"
    ensure_path shop_order_path
  end
  it "checks out with email" do
    prepare_check_and_order
  end
  it "checks out when signed in" do
    sign_in
    prepare_check_and_order(nil)
  end
  it "allows registration after order" do
    prepare_check_and_order
    fill_in(:clerk_password , :with => "password")
    fill_in(:clerk_password_confirmation , :with => "password")
    find("#submit").click
    ensure_path root_path
    expect(Clerk.find_by_email("info@auringostaitaan.fi")).not_to be nil
  end
  it "checks password for registration" do
    prepare_check_and_order
    fill_in(:clerk_password , :with => "password")
    fill_in(:clerk_password_confirmation , :with => "pass_word")
    find("#submit").click
    ensure_path office.sign_up_path
    expect(Clerk.find_by_email("info@auringostaitaan.fi")).to be nil
  end
  it "doesnt allow registration if logged in" do
    clerk = sign_in
    prepare_check_and_order clerk.email
    expect {find("#submit")}.to raise_error Capybara::ElementNotFound
  end
end
