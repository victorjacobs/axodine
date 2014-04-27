class DataController < ApplicationController
  def initialize
    #@current_user = params[:user]
  end

  def view
    render :layout => 'application' # No idea why this is needed
  end

  # Plays per week day
  def plays_per_day
    @current_user = params[:user]
    map = %Q{
      function () {
        emit(this.ti.getDay(), 1);
      }
    }
    reduce = %Q{
      function(key, values) {
        return Array.sum(values);
      }
    }

    per_day = Hash.new
    Play.where(user: params[:user]).map_reduce(map, reduce).out(inline: true).each do |value|
      per_day[value['_id'].to_i] = value['value'].to_i
    end

    render json: per_day
  end
end
