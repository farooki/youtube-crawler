class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.boolean :is_done, default: false

      t.timestamps
    end
  end
end
