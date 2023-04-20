defmodule GittyWeb.User.UserLive do
  use GittyWeb, :live_view
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  import Ecto.Query

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="flex flex-col mr-4 w-64">
        <div class="flex flex-col">
          <div class="flex items-center">
            <%= if @profile.pfp do %>
              <!-- pfp isn't nil -->
              <h5>We got a profile pic!</h5>
            <% else %>
              <!-- pfp is nil -->
              <%= raw(Gitty.Profiles.gravatar(@email, 100, "w-full mb-4 rounded-2xl")) %>
            <% end %>
          </div>
          <h4><%= @user %></h4>
          <h5 class="font-thin"><%= @profile.name %></h5>
          <p class="font-medium text-white"><%= @profile.bio %> Lorem and such</p>
        </div>
      </div>
      <div class="flex flex-col w-[800px]">
        <div class="grid grid-cols-2 gap-2">
          <div class="flex flex-col p-2 px-3 w-full rounded-lg border bg-surface-600 border-surface-400">
            <a class="text-lg font-semibold hover:underline text-primary-500">linux</a>
            <div class="flex items-center">
              <div class="mr-1 w-4 h-4 bg-blue-600 rounded-full"></div>
              <span class="text-center text-white">clang</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"user" => user}, _session, socket) do
    account = Repo.one!(from(a in Accounts.User, where: a.username == ^user))

    profile =
      Repo.one!(
        from(p in Profile,
          join: a in Accounts.User,
          where: p.user_id == a.id and a.id == ^account.id,
          select: p
        )
      )

    email = account.email

    socket = assign(socket, user: user)
    socket = assign(socket, email: email)
    socket = assign(socket, profile: profile)

    {:ok, socket}
  end
end
