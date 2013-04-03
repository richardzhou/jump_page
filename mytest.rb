require "mysql"
dbc=Mysql.real_connect('localhost','aidb','Meetaic2012','dashboard')
res=dbc.query('select * from doctor')
while row=res.fetch_row do
puts "#{row[0]}"
end