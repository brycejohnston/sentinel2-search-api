class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :uuid, :path, :timestamp, :datatake_identifier, :scihub_ingestion, :s3_ingestion, :date
end
