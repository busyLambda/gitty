defmodule GittyWeb.User.UserLive do
  use GittyWeb, :live_view
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  import Ecto.Query

  def render(assigns) do
    ~H"""
    <h1>user: <%= @user %></h1>
    <h4><%=  %></h4>
    """
  end

  def mount(%{"user" => user}, _session, socket) do
    account = Repo.one!(from a in Accounts.User, where: a.username == ^user)

    # profile = Repo.get(Profile, account)

    # profile =
    #  Repo.one!(
    #    from p in Profile,
    #      join: a in Accounts.User,
    #      where: p.user_id == a.id and a.id == ^account,
    #      select: p
    #  )

    # IO.inspect(profile)

    socket = assign(socket, user: user)
    # socket = assign(socket, profile: profile)

    {:ok, socket}
  end
end
