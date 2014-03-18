class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.date :join_date, null: false
      t.date :last_contacted

      t.timestamps
    end
  end
end
