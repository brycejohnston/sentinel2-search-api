class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :uuid
      t.string :path
      t.datetime :timestamp
      t.string :datatake_identifier
      t.datetime :scihub_ingestion
      t.datetime :s3_ingestion
      t.date :date

      t.timestamps
    end
  end
end
