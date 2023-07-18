ActiveAdmin.register User do
  actions :index, :show, :new, :create
          index do
    selectable_column
    id_column
    column :name
    column :email
    column :type
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :type
  filter :created_at

  # form do |f|
  #   f.inputs do
  #     f.input :type
  #   end
  #   f.actions
  # end
end
