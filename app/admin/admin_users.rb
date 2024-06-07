ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :timezone

  index do
    selectable_column
    id_column
    column :email
    column :timezone
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :timezone

  form do |f|
    f.inputs do
      f.input :email
      f.input :timezone, as: :select, collection: ActiveSupport::TimeZone.all.map { |obj| obj.name }
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
