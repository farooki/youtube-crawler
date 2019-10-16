class ChangePhoneToBeStringInCustomers < ActiveRecord::Migration[6.0]
  def change
    change_column :you_tubes, :description, :text
    change_column :you_tubes, :joined_at, :text

  end
end
