require 'open-uri'
require "nokogiri"


def safety(trip)

  @task = Task.new(tip: nil, name: "Stay safe", description: "Make sure to check the level of safety of your destination", category: 'safety')
  @task.trip = trip
  @task.save

  @arrival_country = @trip.location.split(', ')[-1].downcase

  @departure_country = @trip.origin.split(', ')[-1].downcase



  def safety_test(country)
    url_main_page = "https://ulsafetyindex.org/country/#{country}"
    unparsed_page = open(url_main_page).read
    parsed_page = Nokogiri::HTML(unparsed_page)
    score = parsed_page.css("h2")[1].text
    if score.nil?
      return false
    else
      score
    end
  end

  @safety_arrival = safety_test(@arrival_country).to_i
  @safety_departure = safety_test(@departure_country).to_i

  if @safety_arrival == false || @safety_departure == false
    @name = "No information about your country!"
    @description = "We couldn't find information about this country, make sure to make you rescherch"
    save_subtask
  end

  if @safety_arrival < @safety_departure
    @country_comparison = "#{@arrival_country.capitalize} is less safe than #{@departure_country.capitalize}"
  else
    @country_comparison = "#{@arrival_country.capitalize} is more safe than #{@departure_country.capitalize}"
  end

  case @safety_arrival
  when 0..40
    @name = "Be careful!"
    @description = "#{@country_comparison}. #{@arrival_country.capitalize} is considered unsafe, it's score is #{@safety_arrival}/100. So you should think twice and try not to travel alone"
    save_subtask
  when 41..60
    @name = "Be careful!"
    @description = "#{@country_comparison}. #{@arrival_country.capitalize} is relatively unsafe, it's score is #{@safety_arrival}/100. Travelling alone might not be a good idea"
    save_subtask
  when 61..80 then
    @name = "You should be ok!"
    @description = "#{@country_comparison}. #{@arrival_country.capitalize} is pretty safe place, it's score is #{@safety_arrival}/100. You can definitly travel by yourself"
    save_subtask
  when 80..100
    @name = "Safety won't be an issue!"
    @description = "#{@country_comparison}. #{@arrival_country.capitalize} is a super safe place, it's score is #{@safety_arrival}/100. You can definitly travel by yourself"
    save_subtask
  end


end

# @name = "Make sure to change some money"
# @description = "In #{@arrival_country}, they use the #{@cureny_name_description_arrival} (#{@cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
# Today for for 10 #{@cureny_code_description_departure} you will have #{(@rate * 10).round(2)} #{@cureny_code_description_arrival}."
# save_subtask



