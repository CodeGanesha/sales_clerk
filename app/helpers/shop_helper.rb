module ShopHelper
  def parents(group)
    parents = []
    group = group.category
    while group
      parents << group
      group = group.category
    end
    parents.reverse
  end
  def in_group( product , get = 4)
    group = product.category
    return [] unless group
    prods = group.shop_products.to_a
    prods.delete(product)
    prods.sample(get)
  end

  def shipping_methods
     methods = OfficeClerk::ShippingMethod.all.values.dup
     methods.delete_if{|m| m.type == :pickup }
     methods
  end
  def products_for(group)
    group.shop_products
  end

  def categories_for(group)
    group.categories.online
  end

end
