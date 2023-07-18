ActiveAdmin.register Instructor do
  actions :index, :show, :new, :create
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :type
  filter :created_at

end
