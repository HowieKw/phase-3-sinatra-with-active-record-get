class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
    # look up the game in the database using its ID
    # send a JSON-formatted response of the game data
    game = Game.find(params[:id])
    game.to_json(include: { reviews: { include: :user } })
  end

end
