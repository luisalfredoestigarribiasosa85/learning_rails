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
  ["Laptop", "Mouse", "Keyboard", "Monitor", "Headphones"].each do |name|
    Product.find_or_create_by!(name: name)
  end
  puts "Sample products created"
end
