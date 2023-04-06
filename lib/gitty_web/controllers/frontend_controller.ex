defmodule GittyWeb.FrontendController do
  use GittyWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def repository(conn, %{"user" => user, "repo" => repo}) do
    render(conn, :repo, user: user, repo: repo)
  end

  def tree(conn, %{"user" => user, "repo" => repo, "branch" => branch, "path" => path}) do
    url = "http://localhost:6789/#{user}/#{repo}/#{branch}/blob/#{path}"
    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)

    contents = Map.get(req, "contents")

    render(conn, :blob, contents: contents)
  end
end
