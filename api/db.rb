require 'sqlite3'

DB = Sequel.sqlite

DB.create_table :images do
  primary_key :id
  String   :name
  String   :url
  DateTime :uploaded_at
  Integer  :width
  Integer  :height
end
