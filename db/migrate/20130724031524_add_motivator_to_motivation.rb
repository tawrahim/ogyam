class AddMotivatorToMotivation < ActiveRecord::Migration
  def change
    add_column :motivations, :motivated_user, :string
  end
end
