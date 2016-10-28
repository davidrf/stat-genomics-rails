class CreateFileSystemEntryHierarchies < ActiveRecord::Migration
  def change
    create_table :file_system_entry_hierarchies, id: false do |t|
      t.uuid :ancestor_id, null: false
      t.uuid :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :file_system_entry_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "file_system_entry_anc_desc_idx"

    add_index :file_system_entry_hierarchies, [:descendant_id],
      name: "file_system_entry_desc_idx"
  end
end
