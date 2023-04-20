defmodule GittyWeb.User.ProfileSettingsLive do
  use GittyWeb, :live_view
  alias Gitty.Accounts
  alias Gitty.Repo
  alias Gitty.Profiles.Profile

  alias Gitty.Profiles

  import Ecto.Query

  def render(assigns) do
    ~H"""
    <div class="flex items-center">
      <%= if @profile.pfp do %>
        <h1>van</h1>
      <% else %>
        <%= raw(Profiles.gravatar(@email, 200, "w-48 rounded-lg mr-4 mb-2")) %>
      <% end %>
      <h4 class="mb-8 font-bold">
        <%= @current_user.username %> - settings
      </h4>
    </div>
    <div class="flex w-full font-medium text-white">
      <div class="mr-3 w-auto">
        <ul class="font-bold">
          <%= if @tab == "one" do %>
            <li class="p-2 px-4 mb-2 rounded-lg bg-primary-500 text-surface-500">
              show one
            </li>
          <% else %>
            <li class="mb-2 rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#one") |> JS.push("switch_tab", value: %{tab: "one"})}
              >
                show one
              </button>
            </li>
          <% end %>
          <%= if @tab == "two" do %>
            <li class="p-2 px-4 mb-2 rounded-lg bg-primary-500 text-surface-500">
              show two
            </li>
          <% else %>
            <li class="mb-2 rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#two") |> JS.push("switch_tab", value: %{tab: "two"})}
              >
                show two
              </button>
            </li>
          <% end %>
          <%= if @tab == "three" do %>
            <li class="p-2 px-4 rounded-lg bg-primary-500 text-surface-500">
              show three
            </li>
          <% else %>
            <li class="rounded-lg bg-surface-600 hover:text-primary-500">
              <button
                class="p-2 px-4"
                phx-click={JS.show(to: "#three") |> JS.push("switch_tab", value: %{tab: "three"})}
              >
                show three
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
          <.tab_two />
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
        from p in Profile,
          join: a in Accounts.User,
          where: p.user_id == a.id and a.id == ^account.id,
          select: p
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

  def tab_two(assigns) do
    ~H"""
    <p id="two">tab two displayed</p>
    """
  end

  def tab_three(assigns) do
    ~H"""
    <p id="three">tab three displayed</p>
    """
  end
end
