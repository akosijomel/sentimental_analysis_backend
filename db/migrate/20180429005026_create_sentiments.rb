class CreateSentiments < ActiveRecord::Migration[5.2]
  def change
    create_table :sentiments do |t|
      t.decimal :anger, :precision => 4, :scale => 3
      t.decimal :joy, :precision => 4, :scale => 3
      t.decimal :fear, :precision => 4, :scale => 3
      t.decimal :sadness, :precision => 4, :scale => 3
      t.decimal :surprise, :precision => 4, :scale => 3
      
      t.timestamps
    end
  end
end
