class CreateFieldValues < ActiveRecord::Migration
  def change
    create_table :field_values do |t|
      t.references :field, index: true, null: false
      t.references :attendee, index: true, null: false
      t.text :value

      t.timestamps
    end
  end
end
