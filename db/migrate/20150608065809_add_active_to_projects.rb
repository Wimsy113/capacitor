class AddActiveToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :active, :boolean, default: true, null: false
  end
end
