class RepositoriesController < ApplicationController
  def index
    githubService = GithubService.new

    @repositories = githubService.get_repositories(params)
  end
end
