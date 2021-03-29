Amber::Server.configure do |app|
  pipeline :api do
    # plug PipeName.new
    plug Amber::Pipe::CORS.new
  end

  routes :api do
    get "/health", HealthController, :index

    resources "/characters", CharacterController, except: [:new, :edit]
  end
end
