defmodule GittyWeb.User.UserLive do
  use GittyWeb, :live_view
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  import Ecto.Query

  def render(assigns) do
    ~H"""
    <h2><%= @user %></h2>
    <h4><%= @profile.bio %></h4>
    <%= if @profile.pfp do %>
      <!-- pfp isn't nil -->
      <h5>We got a profile pic!</h5>
    <% else %>
      <!-- pfp is nil -->
      <%= raw(Gitty.Profiles.gravatar(@email, 100, "w-48 rounded-2xl")) %>
    <% end %>
    """
  end

  def mount(%{"user" => user}, _session, socket) do
    account = Repo.one!(from a in Accounts.User, where: a.username == ^user)

    profile =
      Repo.one!(
        from p in Profile,
          join: a in Accounts.User,
          where: p.user_id == a.id and a.id == ^account.id,
          select: p
      )

    email = account.email

    socket = assign(socket, user: user)
    socket = assign(socket, email: email)
    socket = assign(socket, profile: profile)

    {:ok, socket}
  end
end
