defmodule GittyWeb.User.ProfileSettingsLive do
  use GittyWeb, :live_view
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  alias Gitty.Profiles

  import Ecto.Query

  def render(assigns) do
    ~H"""
    <h4 class="mb-8 font-bold">
      <%= @current_user.username %> - settings
    </h4>
    <div class="flex w-full font-medium text-white">
      <div class="mr-3 w-auto">
        <ul class="font-bold">
          <%= if @tab == "one" do %>
            <li class="p-2 px-4 mb-2 text-center rounded-lg bg-primary-500 text-surface-500">
              preferences
            </li>
          <% else %>
            <li class="mb-2 text-center rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#one") |> JS.push("switch_tab", value: %{tab: "one"})}
              >
                preferences
              </button>
            </li>
          <% end %>
          <%= if @tab == "two" do %>
            <li class="p-2 px-4 mb-2 text-center rounded-lg bg-primary-500 text-surface-500">
              profile
            </li>
          <% else %>
            <li class="mb-2 text-center rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#two") |> JS.push("switch_tab", value: %{tab: "two"})}
              >
                profile
              </button>
            </li>
          <% end %>
          <%= if @tab == "three" do %>
            <li class="p-2 px-4 text-center rounded-lg bg-primary-500 text-surface-500">
              account
            </li>
          <% else %>
            <li class="text-center rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#three") |> JS.push("switch_tab", value: %{tab: "three"})}
              >
                account
              </button>
            </li>
          <% end %>
        </ul>
      </div>
      <div>
        <%= if @tab == "one" do %>
          <.tab_one />
        <% end %>
        <%= if @tab == "two" do %>
          <.tab_two pfp={@profile.pfp} email={@email}/>
        <% end %>
        <%= if @tab == "three" do %>
          <.tab_three />
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect(socket)

    account = socket.assigns.current_user

    profile =
      Repo.one!(
        from(p in Profile,
          join: a in Accounts.User,
          where: p.user_id == a.id and a.id == ^account.id,
          select: p
        )
      )

    socket = assign(socket, tab: "one")
    socket = assign(socket, profile: profile)
    socket = assign(socket, email: account.email)
    {:ok, socket}
  end

  def handle_event("switch_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, tab: tab)}
  end

  def tab_one(assigns) do
    ~H"""
    <p id="one">tab one displayed</p>
    """
  end

  attr :pfp, :string
  attr :email, :string
  def tab_two(assigns) do
    ~H"""
    <%= if @pfp do %>
      <h1>van</h1>
    <% else %>
      <%= raw(Profiles.gravatar(@email, 200, "w-48 rounded-lg mr-4 mb-2")) %>
    <% end %>
    """
  end

  def tab_three(assigns) do
    ~H"""
    <p id="three">tab three displayed</p>
    """
  end
end
