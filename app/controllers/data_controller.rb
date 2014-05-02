class DataController < ApplicationController
  # Plays per week day
  def plays_per_day
    map = %Q{ function () { emit(this.ti.getDay(), 1); } }
    reduce = %Q{ function(key, values) { return Array.sum(values); } }
    query = Play.where(user: params[:user]).map_reduce(map, reduce).out(inline: true)


    per_day = Hash.new
    per_day[:data] = Array.new
    max = 0

    query.each do |value|
      max = (value['value'].to_i > max) ? value['value'].to_i : max
      per_day[:data] << { :day => value['_id'].to_i, :count => value['value'].to_i }
    end

    per_day[:max] = max

    render json: per_day
  end

  def plays_per_month
    map = %Q{ function() { emit(new Date(Date.UTC(this.ti.getFullYear(), this.ti.getMonth(), 1)), 1) } }
    reduce = %Q{ function(key, values) { return Array.sum(values); } }

    query = Play.where(user: params[:user]).map_reduce(map, reduce).out(inline: true)

    per_month = Hash.new
    # Store some metadata
    per_month[:total] = query.count
    max = 0

    per_month[:data] = Array.new
    query.each do |value|
      max = (value['value'].to_i > max) ? value['value'].to_i : max
      per_month[:data] << { :month => value['_id'], :count => value['value'].to_i }
    end

    per_month[:max] = max

    render json: per_month
  end
end
