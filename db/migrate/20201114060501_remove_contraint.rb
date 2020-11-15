class RemoveContraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :listings, :user_id, true
  end
end
