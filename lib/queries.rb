# Write methods that return SQL queries for each part of the challeng here


def guest_with_most_appearances
  DB[:conn].execute("SELECT guest FROM shows GROUP BY guest ORDER BY COUNT(guest) DESC LIMIT 1")
end

def most_profession_by_year

  x = <<-SQL
  SELECT DISTINCT a.year, b.profession, max(b.total)
  FROM shows as 'a'
  LEFT JOIN (SELECT profession, year, COUNT(profession) as total FROM shows GROUP BY profession, year ORDER BY COUNT(profession) DESC, year ASC) as 'b'
  ON a.year = b.year
  GROUP BY a.year
  ORDER BY a.year ASC, b.total DESC
  SQL
  DB[:conn].execute(x)

end

def most_profession
  x = <<-SQL
  SELECT profession, COUNT(profession)
  FROM shows
  GROUP BY profession
  ORDER BY COUNT(profession) DESC LIMIT 1
  SQL
  DB[:conn].execute(x)
end

def bill_any
  x = <<-SQL
  SELECT guest
  FROM shows
  WHERE guest LIKE "bill%"
  SQL
  DB[:conn].execute(x)

end

def patrick_stewart_dates
  x = <<-SQL
  SELECT show
  FROM shows
  WHERE guest = "Patrick Stewart"
  SQL
  DB[:conn].execute(x)
end

def most_guests_in_year
    x = <<-SQL
    SELECT year, max(total)
    FROM (SELECT year, sum(appearances) as total
    FROM (SELECT year, count(guest) as appearances FROM shows GROUP BY guest, year ORDER BY appearances DESC, year ASC)
    GROUP BY year)
    GROUP BY total, year
    ORDER BY max(total) DESC LIMIT 1
    SQL
    DB[:conn].execute(x)
end

def most_popular_group_by_year
  x = <<-SQL
  SELECT DISTINCT year, genre, max(a) as b
  FROM (SELECT year, genre, count(genre) as a
  FROM shows
  GROUP BY year, genre
  ORDER BY year ASC, a DESC)
  GROUP BY year
  ORDER BY year ASC, max(a) DESC
  SQL
  DB[:conn].execute(x)
end
