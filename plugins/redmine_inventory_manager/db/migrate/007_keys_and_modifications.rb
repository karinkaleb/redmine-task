class KeysAndModifications < ActiveRecord::Migration[5.1]
  def up
    add_index :inventory_parts,
              :part_number,
              unique: true,
              name: 'uk_inventory_part_part_number'

    add_index :inventory_categories,
              :name,
              unique: true,
              name: 'uk_inventory_category_name'

    add_index :inventory_providors,
              :identification,
              unique: true,
              name: 'uk_inventory_providor_identification'

    add_column :inventory_movements, :user_from_id, :integer
    add_column :inventory_movements, :user_to_id, :integer
    add_column :inventory_movements, :warehouse_to_id, :integer
    add_column :inventory_movements, :warehouse_from_id, :integer
    add_column :inventory_movements, :serial_number, :string

    add_foreign_key :inventory_movements,
                    :inventory_warehouses,
                    column: :warehouse_to_id,
                    name: 'fk_inventory_movement_warehouse_to'

    add_foreign_key :inventory_movements,
                    :inventory_warehouses,
                    column: :warehouse_from_id,
                    name: 'fk_inventory_movement_warehouse_from'

    add_foreign_key :inventory_movements,
                    :users,
                    column: :user_id,
                    name: 'fk_inventory_movement_user'

    add_foreign_key :inventory_movements,
                    :users,
                    column: :user_from_id,
                    name: 'fk_inventory_movement_user_from'

    add_foreign_key :inventory_movements,
                    :users,
                    column: :user_to_id,
                    name: 'fk_inventory_movement_user_to'

    add_column :inventory_parts, :where, :string
  end

  def down
    remove_foreign_key :inventory_movements, name: 'fk_inventory_movement_user_to'
    remove_foreign_key :inventory_movements, name: 'fk_inventory_movement_user_from'
    remove_foreign_key :inventory_movements, name: 'fk_inventory_movement_user'
    remove_foreign_key :inventory_movements, name: 'fk_inventory_movement_warehouse_from'
    remove_foreign_key :inventory_movements, name: 'fk_inventory_movement_warehouse_to'

    remove_index :inventory_parts, name: 'uk_inventory_part_part_number'
    remove_index :inventory_categories, name: 'uk_inventory_category_name'
    remove_index :inventory_providors, name: 'uk_inventory_providor_identification'

    remove_column :inventory_movements, :user_from_id
    remove_column :inventory_movements, :user_to_id
    remove_column :inventory_movements, :warehouse_to_id
    remove_column :inventory_movements, :warehouse_from_id
    remove_column :inventory_movements, :serial_number
    remove_column :inventory_parts, :where
  end
end