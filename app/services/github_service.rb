class GithubService
  def initialize
  end

  def get_repositories(params)
    search_term = params[:search_term]

    if !search_term
      return []
    end

    sort_column = params[:sort_column] || 'stars'
    sort_direction = params[:sort_direction] || 'desc'
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    begin
      response = RestClient.get(
        "https://api.github.com/search/repositories?q=#{search_term}&sort=#{sort_column}&order=#{sort_direction}&page=#{page}&per_page=#{per_page}",
        { 'X-GitHub-Api-Version': "2022-11-28"}
      )

      repositories = JSON.parse(response)['items']
    rescue RestClient::ExceptionWithResponse => e
      puts "Response Code: #{e.response.code}"
      puts "Response Body: #{e.response.body}"
    end

    repositories
  end
end