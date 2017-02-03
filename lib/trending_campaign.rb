module TrendingCampaign
  extend self

  def all
    parsed_data
  end

  def search(param)
    param.downcase!
    TrendingCampaign.all.select do |campaign|
      campaign['title'].downcase.include?(param) || campaign['tagline'].downcase.include?(param)
    end
  end


  def raw_data
    uri = URI.parse("https://api.indiegogo.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new("/1/search/campaigns.json?per_page=100&api_token=e377270bf1e9121da34cb6dff0e8af52a03296766a8e955c19f62f593651b346")
    response = http.request(request)
    JSON.parse(response.body)
  end

  def parsed_data
    raw_data.extract!("response")["response"]
      .map! { |m| m.extract!("title", "baseball_card_image_url", "tagline")}
  end

  private_class_method :raw_data
  private_class_method :parsed_data
end
