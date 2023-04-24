defmodule GittyWeb.FrontendController do
  use GittyWeb, :controller
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  import Ecto.Query

  def index(conn, _params) do
    render(conn, :index)
  end

  def repository(conn, %{"user" => user, "repo" => repo}) do
    url = "http://localhost:6789/#{user}/#{repo}/master/tree/"
    response = HTTPoison.get!(url)

    req = Jason.decode!(response.body)

    render(conn, :repo, user: user, repo: repo, tree_entries: req)
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

    req = Jason.decode!(response.body)

    render(conn, :tree, tree_entries: req, path: path, user: user, repo: repo, branch: branch)
  end

  def commit(conn, %{"user" => user, "repo" => repo, "commit" => commit}) do
    url = "http://localhost:6789/#{user}/#{repo}/commits/#{commit}"
    response = HTTPoison.get!(url)

    commit = Jason.decode!(response.body)

    email = commit["email"]

    account = Repo.one(from(a in Accounts.User, where: a.email == ^email))

    profile =
      Repo.one!(
        from(p in Profile,
          join: a in Accounts.User,
          where: p.user_id == a.id and a.id == ^account.id,
          select: p
        )
      )

    render(conn, :commits, commit: commit, user: user, repo: repo, email: account.email, profile: profile, username: account.username)
  end
end
