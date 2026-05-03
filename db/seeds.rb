# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create admin user
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.password = "password123"
admin.password_confirmation = "password123"
admin.role = "admin"
admin.save!
puts "Admin user created: admin@example.com / password123"

# Create regular user
user = User.find_or_initialize_by(email: "user@example.com")
user.password = "password123"
user.password_confirmation = "password123"
user.role = "user"
user.save!
puts "Regular user created: user@example.com / password123"

# Create sample products if none exist
if Product.count == 0
  products = [
    {
      name: "Laptop Pro X1",
      description: "High-performance laptop with Intel Core i7, 16GB RAM, 512GB SSD. Perfect for professionals and developers.",
      price: 999.99,
      stock: 15,
      active: true
    },
    {
      name: "Wireless Mouse",
      description: "Ergonomic wireless mouse with precision tracking and long battery life.",
      price: 29.99,
      stock: 50,
      active: true
    },
    {
      name: "Mechanical Keyboard",
      description: "RGB mechanical keyboard with Cherry MX switches and customizable backlight.",
      price: 79.99,
      stock: 30,
      active: true
    },
    {
      name: "4K Monitor 27\"",
      description: "Ultra-sharp 4K display with HDR support. Ideal for designers and video editors.",
      price: 299.99,
      stock: 4,
      active: true
    },
    {
      name: "Noise Cancelling Headphones",
      description: "Premium over-ear headphones with active noise cancellation and 30-hour battery.",
      price: 149.99,
      stock: 0,
      active: false
    },
    {
      name: "USB-C Hub",
      description: "Multi-port USB-C hub with HDMI, USB 3.0, and SD card reader.",
      price: 45.99,
      stock: 25,
      active: true
    }
  ]

  products.each do |product_data|
    Product.find_or_create_by!(name: product_data[:name]) do |p|
      p.description = product_data[:description]
      p.price = product_data[:price]
      p.stock = product_data[:stock]
      p.active = product_data[:active]
    end
  end
  puts "#{products.count} sample products created with full details"
end
