require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry-byebug'

get '/' do
  redirect to ('/videos')
end

get '/videos' do
  sql= 'select * from videos'
  @videos = run_sql(sql)
  erb :index
end

get '/videos/upload' do  
erb :upload
end

post '/videos' do
  sql = "insert into videos (video) values ('#{params[:video]}')"
  run_sql(sql)
  redirect to ('/videos')
end

get '/videos/:id' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = run_sql(sql).first

  sql2= "select * from comments"
  @comments = run_sql(sql2)
  erb :single_view



end

get '/comments' do
  sql= 'select * from comments'
  @comments = run_sql(sql).first
  erb :single_view
end




private

def run_sql(sql)
  conn = PG.connect(dbname: 'video_library', host: 'localhost')
  begin 
    conn.exec(sql)
  ensure
    conn.close
  end
end