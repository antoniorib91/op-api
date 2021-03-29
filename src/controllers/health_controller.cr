class HealthController < ApplicationController

  def index
    results = {online: true}
    respond_with 200 do
      json results.to_json
    end
  end
end
