class AddRoleColumnToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      t.string :role
    end
  end
end
