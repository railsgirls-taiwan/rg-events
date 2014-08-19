class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :event, null: false
      t.references :user, null: false
      t.index(%i[user_id event_id], unique: true)
      t.index(%i[event_id user_id], unique: true)

      t.timestamps
    end
  end
end
