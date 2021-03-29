require "./spec_helper"

def character_hash
  {"name" => "Fake", "name_japanese" => "Fake", "birthday" => "Fake", "bounty" => "1", "nickname" => "Fake", "description" => "Fake"}
end

def character_params
  params = [] of String
  params << "name=#{character_hash["name"]}"
  params << "name_japanese=#{character_hash["name_japanese"]}"
  params << "birthday=#{character_hash["birthday"]}"
  params << "bounty=#{character_hash["bounty"]}"
  params << "nickname=#{character_hash["nickname"]}"
  params << "description=#{character_hash["description"]}"
  params.join("&")
end

def create_character
  model = Character.new(character_hash)
  model.save
  model
end

class CharacterControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :api do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
    end
    @handler.prepare_pipelines
  end
end

describe CharacterControllerTest do
  subject = CharacterControllerTest.new

  it "renders character index json" do
    Character.clear
    model = create_character
    response = subject.get "/characters"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders character show json" do
    Character.clear
    model = create_character
    location = "/characters/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a character" do
    Character.clear
    response = subject.post "/characters", body: character_params

    response.status_code.should eq(201)
    response.body.should contain "Fake"
  end

  it "updates a character" do
    Character.clear
    model = create_character
    response = subject.patch "/characters/#{model.id}", body: character_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a character" do
    Character.clear
    model = create_character
    response = subject.delete "/characters/#{model.id}"

    response.status_code.should eq(204)
  end
end
