class CharacterController < ApplicationController
  def index
    characters = Character.all
    respond_with 200 do
      json characters.to_json
    end
  end

  def show
    if character = Character.find params["id"]
      respond_with 200 do
        json character.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    character = Character.new(character_params.validate!)

    if character.valid? && character.save
      respond_with 201 do
        json character.to_json
      end
    else
      results = {status: "invalid"}
      respond_with 422 do
        json results.to_json
      end
    end
  end

  def update
    if character = Character.find(params["id"])
      character.set_attributes(character_params.validate!)
      if character.valid? && character.save
        respond_with 200 do
          json character.to_json
        end
      else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def destroy
    if character = Character.find params["id"]
      character.destroy
      respond_with 204 do
        json ""
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def character_params
    params.validation do
      required(:name, msg: nil, allow_blank: true)
      required(:name_japanese, msg: nil, allow_blank: true)
      required(:birthday, msg: nil, allow_blank: true)
      required(:bounty, msg: nil, allow_blank: true)
      required(:nickname, msg: nil, allow_blank: true)
      required(:description, msg: nil, allow_blank: true)
    end
  end
end
