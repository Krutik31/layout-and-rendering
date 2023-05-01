class CreateJoinTableEmployeeHobby < ActiveRecord::Migration[7.0]
  def change
    create_join_table :employees, :hobbies do |t|
      t.index %i[employee_id hobby_id]
      t.index %i[hobby_id employee_id]
    end
  end
end
