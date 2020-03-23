class AddDefaultToCompletedInTodos < ActiveRecord::Migration[6.0]
  def change
    change_column_default(
      :todos,
      :completed,
      from: nil,
      to: false
    )
  end
end
