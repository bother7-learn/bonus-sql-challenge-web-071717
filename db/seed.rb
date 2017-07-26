# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require "sqlite3"
require 'csv'
require 'pry'

db = SQLite3::Database.new('./db/daily.db')
db.execute("DROP TABLE IF EXISTS shows")
x = <<-SQL
CREATE TABLE shows (
  id INTEGER PRIMARY KEY,
  show TEXT,
  genre TEXT,
  guest TEXT,
  year TEXT,
  profession TEXT);
SQL
db.execute(x)

csv = File.read("./daily_show_guests.csv")

CSV.parse(csv, headers: true) do |row|
  # binding.pry
  db.execute("INSERT INTO shows (year, profession, show, genre, guest) values (?, ?, ?, ?, ?)", row.fields)
end
  # binding.pry
