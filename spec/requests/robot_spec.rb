require 'rails_helper'

RSpec.describe RobotController, type: :request do
  describe "POST /robot" do
    context "with valid commands" do
      it "places the robot at the specified location" do
        post "/robot", params: { commands: ["PLACE 2,3,NORTH", "REPORT"] }
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response["location"]).to eq([2, 3, "NORTH"])
      end

      it "places the robot at the specified location" do
        post "/robot", params: { commands: ["PLACE 2,3,EAST", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "places the robot at the specified location" do
        post "/robot", params: { commands: ["PLACE 4,1,NORTH", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "moves the robot one step forward when command is 'MOVE'" do
        post "/robot", params: { commands: ["PLACE 1,1,NORTH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response["location"]).to eq([1, 2, "NORTH"])
      end

      it "rotates the robot to the left when command is 'LEFT'" do
        post "/robot", params: { commands: ["PLACE 1,1,EAST", "LEFT", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "rotates the robot to the left when command is 'LEFT'" do
        post "/robot", params: { commands: ["PLACE 1,1,SOUTH", "LEFT", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "rotates the robot to the left when command is 'LEFT'" do
        post "/robot", params: { commands: ["PLACE 1,1,WEST", "LEFT", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "rotates the robot to the left when command is 'LEFT'" do
        post "/robot", params: { commands: ["PLACE 1,1,NORTH", "LEFT", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "places the robot at the specified location" do
        post "/robot", params: { commands: ["PLACE 2,3,EAST", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "places the robot at the specified location" do
        post "/robot", params: { commands: ["PLACE 4,1,WEST", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "moves the robot one step forward when facing 'EAST'" do
        post "/robot", params: { commands: ["PLACE 1,1,EAST", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "moves the robot multiple steps forward when multiple 'MOVE' commands are provided" do
        post "/robot", params: { commands: ["PLACE 1,1,NORTH", "MOVE", "MOVE", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response["location"]).to eq([1, 4, "NORTH"])
      end

      it "moves the robot one step forward when facing 'WEST'" do
        post "/robot", params: { commands: ["PLACE 1,1,WEST", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "moves the robot multiple steps forward when multiple 'MOVE' commands are provided" do
        post "/robot", params: { commands: ["PLACE 1,1,SOUTH", "MOVE", "MOVE", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "rotates the robot to the right when command is 'RIGHT'" do
        post "/robot", params: { commands: ["PLACE 1,1,NORTH", "RIGHT", "REPORT"] }
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response["location"]).to eq([1, 1, "EAST"])
      end

      it "rotates the robot to the left when command is 'LEFT'" do
        post "/robot", params: { commands: ["PLACE 1,1,WEST", "LEFT", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it "ignores invalid commands and returns an error message" do
        post "/robot", params: { commands: ["PLACE 1,1,NORTH", "INVALID", "REPORT"] }
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Given input is incorrect, Please enter the valid input !")
      end
    end

    context "with invalid commands" do
      it "returns an error message when 'PLACE' command is missing or invalid" do
        post "/robot", params: { commands: ["PLACE ,6,NORTH", "REPORT"] }
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Given input is incorrect, Please enter the valid input !")
      end

      it "returns an error message when 'PLACE' command has an invalid direction" do
        post "/robot", params: { commands: ["PLACE 2,2,INVALID_DIRECTION", "REPORT"] }
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Given input is incorrect, Please enter the valid input !")
      end

      it "returns an error message when 'PLACE' command has invalid coordinates" do
        post "/robot", params: { commands: ["PLACE A,1,NORTH", "REPORT"] }
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Given input is incorrect, Please enter the valid input !")
      end
      it "returns an error message when 'PLACE' command is missing or invalid" do
        post "/robot", params: { commands: ["PLACE ,6,WEST", "REPORT"] }
        expect(response).to have_http_status(400)
      end
    end
  end
end
