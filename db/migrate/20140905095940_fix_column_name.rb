class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :date, :start_date
    rename_column :events, :enddate, :end_date
  end
end
