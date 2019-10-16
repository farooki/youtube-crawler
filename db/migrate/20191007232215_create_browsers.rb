class CreateBrowsers < ActiveRecord::Migration[6.0]
  def change
    create_table :browsers do |t|

      t.timestamps
    end
  end
end
