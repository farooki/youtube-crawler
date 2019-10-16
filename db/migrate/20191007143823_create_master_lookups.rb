class CreateMasterLookups < ActiveRecord::Migration[6.0]
  def change
    create_table :master_lookups do |t|
      t.string :key
      t.jsonb :value, default: []
      t.string :category

      t.timestamps
    end
  end
end
