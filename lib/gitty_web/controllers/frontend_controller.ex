defmodule GittyWeb.FrontendController do
  use GittyWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def repository(conn, %{"user" => user, "repo" => repo}) do
    render(conn, :repo, user: user, repo: repo)
  end

  def blob(conn, %{"user" => user, "repo" => repo, "branch" => branch, "path" => path}) do
    path = Enum.join(path, "/")
    url = "http://localhost:6789/#{user}/#{repo}/#{branch}/blob/#{path}"
    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)

    contents = Map.get(req, "contents")
    latest_commit = Map.get(req, "latest_commit")
    path = Map.get(req, "path")

    render(conn, :blob, contents: contents, latest_commit: latest_commit, path: path)
  end

  def tree(conn, %{"user" => user, "repo" => repo, "branch" => branch, "path" => path}) do
    path = Enum.join(path, "/")
    url = "http://localhost:6789/#{user}/#{repo}/#{branch}/tree/#{path}"
    response = HTTPoison.get!(url)

    #req = Poison.decode!("{\"name\": \"John\", \"age\": 30}")
    req = Jason.decode!(response.body)

    render(conn, :tree, tree_entries: req, path: path, user: user, repo: repo, branch: branch)
  end
end
