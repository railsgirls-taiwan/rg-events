class AddColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :enddate, :datetime
    add_column :events, :address, :string
  end
end
