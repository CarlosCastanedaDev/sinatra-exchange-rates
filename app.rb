require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  response = HTTP.get('https://api.exchangerate.host/symbols')

  parsed_response = JSON.parse(response)

  @currencies = parsed_response.fetch('symbols')
  
  erb(:home)
end

get("/:currency") do
  @selected_currency = params.fetch("currency")

  response = HTTP.get('https://api.exchangerate.host/symbols')

  parsed_response = JSON.parse(response)

  @currencies = parsed_response.fetch('symbols')

  erb(:currency)
end

get("/:curr1/:curr2") do
  @currency1 = params.fetch("curr1")
  @currency2 = params.fetch("curr2")

  convert_response = HTTP.get("https://api.exchangerate.host/convert?from=#{@currency1}&to=#{@currency2}")

  parsed_convert_response = JSON.parse(convert_response)

   @rate = parsed_convert_response.fetch('result')

  erb(:convert)
end
