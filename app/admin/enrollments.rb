ActiveAdmin.register Enrollment do
  permit_params :cou_status
  actions :index, :show, :new, :create, :update, :edit
  index do
    selectable_column
    id_column
    column :course
    column :student
    column :cou_status
    column :created_at
    actions
  end

  filter :email
  filter :title
  filter :category
  filter :created_at

  form do |f|
    f.inputs do
      f.input :cou_status
    end
    f.actions
  end
end
