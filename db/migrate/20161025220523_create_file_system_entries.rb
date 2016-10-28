class CreateFileSystemEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :file_system_entries, id: :uuid do |t|
      t.string :name, null: false, unique: true
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.uuid :parent_id
      t.string :type, null: false
      t.timestamps
    end
  end
end
