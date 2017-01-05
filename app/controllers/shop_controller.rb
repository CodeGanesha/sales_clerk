class ShopController < ApplicationController
  layout "sales_clerk"
  include OfficeHelper
  include ChargesHelper
  helper ChargesHelper

  force_ssl :if => :has_ssl? , :only => :sign_out

  def welcome
    @groups = Category.online.where( :category_id => nil )
    render :layout => false
  end

  def product
    @product = Product.shop_products.where(:link => params[:link]).first
    unless @product
      redirect_to :action => :group
      return
    end
  end

  # the checkout page creates an order upon completion. So before a checkout the basket is attached to the session
  # and by filling out all data an order is created with the basket and the session zeroed
  def checkout
    basket = current_basket
    if(basket.kori )
      @order = basket.kori
    else
      @order = Order.new :ordered_on => Date.today
      @order.basket = basket
    end
    if(request.get?)
      @order.email = current_clerk.email if current_clerk
      @order.shipment_type = "post" # price is 0 automatically
    else
      order_ps = params.require(:order).permit( :email,:name , :street , :city , :phone , :shipment_type )
      @order.assign_attributes(order_ps)
      if (!params[:validation].blank?) and @order.save
        return process_order #always redirects
      else
        flash.now.notice = I18n.t(:must_accept) if params[:validation].blank?
      end
    end
  end

  # called when address is ok and order already saved
  # includes possible charge with previous credit card if the checkbox was clicked
  def process_order
    new_basket
    OrderMailer.confirm(@order).deliver_now
    session[:order] = @order.id
    notice = t(:thanks)
    unless(params[:use_card].blank?)
      charge = has_charge(current_clerk)
      begin
        charge_customer charge.customer , @order
        notice += "<br/>" + t(:paid)
      rescue Stripe::StripeError => e # nothing must escape, CardError is just a subset
        notice += "<br/>" + e.message
      end
    end
    redirect_to shop_order_path, :notice => notice
  end

  def order
    notice = I18n.t(:no_order_found)
    if( session[:order])
      @order = Order.find( session[:order] )
      notice += I18n.t(:log_in_see_history)
      @clerk = Clerk.new :email => @order.email
    elsif clerk = current_clerk
      @order = Order.where(:email => clerk.email).first
    end
    return redirect_to(office.sign_in_path , :notice => notice) if @order.blank?
  end

  def history
    clerk = current_clerk
    return redirect_to office.sign_in_path unless clerk
    @orders = current_clerk.orders.limit(10).to_a.compact
    @last = @orders.shift
    return redirect_to(root_path , :notice => I18n.t(:no_orders_yet)) if @last.blank?
  end

  def add
    prod = Product.find( params[:id]) # no id will raise which in turn will show home page
    current_basket.add_product(prod)
    if request.get?
      redirect_to shop_checkout_path
    else
      flash.notice = "#{t(:product_added)}: #{prod.name}. #{view_context.link_to(t(:checkout) , shop_checkout_path)}"
      redirect_to shop_group_path(:link => prod.category.link)
    end
  end
  def remove
    prod = Product.find( params[:id]) # no id will raise which in turn will show home page
    current_basket.add_product(prod , -1)
    redirect_to shop_checkout_path
  end

  def main
    @groups = Category.online.where( :category_id => nil )
  end

  def group
    @group = Category.online.where(:link => params[:link]).first
    return redirect_to(shop_main_path) unless @group
  end

  def page
    @products = Product.shop_products.limit(50)
    template = params[:id]
    if template.blank?
      redirect_to root_path
    else
      render "page/#{template}"
    end
  end

end
