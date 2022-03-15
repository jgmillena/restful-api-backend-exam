class CreateContexts < ActiveRecord::Migration[7.0]
  def change
    create_table :contexts do |t|
      t.string :context
      t.string :message
      t.timestamps
    end
  end
end
