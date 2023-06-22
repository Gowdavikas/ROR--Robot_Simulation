class RobotController < ApplicationController

  def create

    params[:commands].each do |command|
      case command
      when /^PLACE (\d+),(\d+),(NORTH|EAST|SOUTH|WEST)$/
        x = $1.to_i
        y = $2.to_i
        orientation = $3

        if x >= 0 && x < 5.to_i && y >= 0 && y < 5.to_i
          @location = [x, y, orientation]
        end
        
      when "MOVE"
        if @location
          x, y, orientation = @location

          case orientation
          when "NORTH"
            y += 1
          when "EAST"
            x += 1
          when "SOUTH"
            y -= 1
          when "WEST"
            x -= 1
          end

          if x >= 0 && x < 5.to_i && y >= 0 && y < 5.to_i
            @location = [x, y, orientation]
          end
        end

      when "RIGHT"
        if @location
          x, y, orientation = @location

          case orientation
          when "NORTH"
            orientation = "EAST"
          when "EAST"
            orientation = "SOUTH"
          when "SOUTH"
            orientation = "WEST"
          when "WEST"
            orientation = "NORTH"
          end

          @location = [x, y, orientation]
        end

      when "LEFT"
        if @location
          x, y, orientation = @location

          case orientation
          when "NORTH"
            orientation = "WEST"
          when "EAST"
            orientation = "NORTH"
          when "SOUTH"
            orientation = "EAST"
          when "WEST"
            orientation = "SOUTH"
          end

          @location = [x, y, orientation]
        end
      
      when "REPORT"
      else
        @error_message = "Invalid command: #{command}"
      end

      break if @error_message
    end

    if @error_message
      render json: 
      { message: "Given input is incorrect, Please enter the valid input !" 
    },
       status: 400
    else
      render json: 
      { message: "Robot is in this below location",
        location: @location
    }, status: 200
    end
    
  end
end