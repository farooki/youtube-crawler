class AddIsReadyToYouTubes < ActiveRecord::Migration[6.0]
  def change
    add_column :you_tubes, :test_1_pass, :boolean
    add_column :you_tubes, :test_2_pass, :boolean
    add_column :you_tubes, :test_3_pass, :boolean
    add_column :you_tubes, :test_4_pass, :boolean
  end
end
