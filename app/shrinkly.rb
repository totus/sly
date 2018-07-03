#encoding: utf-8
require 'sinatra'
require_relative '../src/lib/model/shrink.rb'

post /\/do/ do
  status 201
  url = params['url']
  body "Request to DO something with parameters [#{params}]\n"
  Shrink.save(url, Shrink.generate_for_url(url))
end

get /.*/ do
  url = request.path_info[1..-1]
  puts request
  status 200
  body Shrink.resolve(url)
end