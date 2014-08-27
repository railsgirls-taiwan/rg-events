class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :event, index: true, null: false
      t.string :name, null: false
      t.string :type, null: false, default: :text
      t.boolean :required, null: false, default: false
      t.boolean :multiple, null: false, default: false
      t.string :option_items, array: true

      t.timestamps
    end
  end
end
