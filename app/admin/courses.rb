ActiveAdmin.register Course do
  permit_params :status
  actions :index, :show, :new, :create, :update, :edit
  index do
    selectable_column
    id_column
    column :title
    column :about
    column :status
    column :instructor
    column :category
    column :created_at
    actions
  end

  filter :email
  filter :title
  filter :category
  filter :created_at

  form do |f|
    f.inputs do
      f.input :status
    end
    f.actions
  end
end
