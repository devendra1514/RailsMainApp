AdminUser.find_or_initialize_by(email: 'admin@example.com') do |admin_user|
  admin_user.timezone = 'Asia/Kolkata'
  admin_user.password = 'password'
  admin_user.password_confirmation = 'password'
  admin_user.save!
end
