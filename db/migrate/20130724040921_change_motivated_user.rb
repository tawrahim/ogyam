class ChangeMotivatedUser < ActiveRecord::Migration
  def up
    change_column :motivations, :motivated_user, :integer
  end

  def down
    change_column :motivations, :motivated_user, :string
  end
end
