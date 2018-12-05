#!/usr/bin/env ruby
require 'httparty'
require 'json'

class Parser

  attr_accessor :search
  attr_accessor :url

  @@url = "https://datatrackcenter.herokuapp.com"

  def initialize(search=nil, method='rest')
    @search = search if not search.nil? 
    @method = method
  end

  def list_tracks
    path = "#{@@url}/#{@method}/tracks/"
    path = "#{path}?name_filter=#{@search}" if not @search.nil?
    p "Request to: #{path}"
    response = HTTParty.get(path)
    representation JSON.parse(response.body)
  end

  def representation(data)
    repr_items = []
    if @method == "json"
      json(data, repr_items)
    end
    if @method == "rest" 
      rest(data, repr_items)
    end
    repr_items
  end

  def rest(data, repr_items)
    data.each do |item|
      repr_items.append("Track: #{item["name"]}, Artist: #{item["artist"]}")
    end
    repr_items
  end

  def json(data, repr_items)
    data = data["data"] if @method == "json"
    data.each do |item|
      repr_items.append("Track: #{item["attributes"]["name"]}, Artist: #{item["attributes"]["artist"]}")
    end
    repr_items
  end
end
