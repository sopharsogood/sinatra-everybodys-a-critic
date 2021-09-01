class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :content
      t.datetime :created_at
    end
  end
end
