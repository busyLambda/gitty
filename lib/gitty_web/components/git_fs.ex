defmodule GittyWeb.GitFs do
  use Phoenix.Component
  use Phoenix.HTML

  attr :tree_entries, :list
  attr :user, :string
  attr :repo, :string
  attr :branch, :string
  attr :path, :string

  def tree(assigns) do
    assigns =
      case Enum.find(assigns.tree_entries, fn e -> e["name"] == to_string("README.md") end) do
        nil ->
          Map.put(assigns, :readme, nil)

        readme ->
          path = readme["path"]

          url =
            "http://localhost:6789/#{assigns.user}/#{assigns.repo}/#{assigns.branch}/blob/#{path}"

          response = HTTPoison.get!(url)
          req = Poison.decode!(response.body)
          contents = Map.get(req, "contents")
          {:ok, readme_html, _} = Earmark.as_html(contents)
          Map.put(assigns, :readme, readme_html)
      end

    url = "http://localhost:6789/#{assigns.user}/#{assigns.repo}/master/latest_commit"
    response = HTTPoison.get!(url)

    latest_commit = Jason.decode!(response.body)

    lc_message = Map.get(latest_commit, "msg")
    lc_id = Map.get(latest_commit, "id")

    assigns = Map.put(assigns, :id, lc_id)
    assigns = Map.put(assigns, :msg, lc_message)

    ~H"""
    <div class="overflow-hidden rounded-lg border border-surface-400">
      <div class="p-4 text-white bg-surface-500">
        Latest commit:
        <a
          class="text-primary-500 hover:underline"
          href={"http://localhost:5000/#{@user}/#{@repo}/commits/#{@id}"}
        >
          <%= @msg %>
        </a>
      </div>
      <%= for entry <- @tree_entries do %>
        <div class="flex justify-between p-2 text-white border-t bg-surface-800 hover:bg-surface-500 border-t-surface-400">
          <a
            class="flex items-center hover:text-primary-500 hover:fill-primary-500 fill-surface-300"
            href={
        "http://localhost:5000/#{@user}/#{@repo}/#{@branch}/#{
            if Map.get(entry, "entry_type") == to_string("Blob") do
                "blob"
            else
                "tree"
            end
        }/#{@path}/#{Map.get(entry, "name")}"
    }
          >
            <div class="mr-2 w-4">
              <%= if Map.get(entry, "entry_type") == to_string("Blob") do %>
                <svg
                  class="mx-auto h-4 fill-inherit"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 384 512"
                >
                  <!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                  <path d="M0 64C0 28.7 28.7 0 64 0H224V128c0 17.7 14.3 32 32 32H384V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V64zm384 64H256V0L384 128z" />
                </svg>
              <% else %>
                <svg
                  class="mx-auto h-4 fill-inherit"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 512 512"
                >
                  <!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                  <path d="M64 480H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H288c-10.1 0-19.6-4.7-25.6-12.8L243.2 57.6C231.1 41.5 212.1 32 192 32H64C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64z" />
                </svg>
              <% end %>
            </div>
            <%= Map.get(entry, "name") %>
          </a>
          <a class="text-primary-500 hover:underline" href={"http://localhost:5000/#{@user}/#{@repo}/commits/#{Map.get(entry, "latest_commit_id")}"}>
            <%= "#{String.slice(Map.get(entry, "latest_commit_msg"), 0..20)}" %>
          </a>
          <div>
            <%= {_, datetime} = DateTime.from_unix(Map.get(entry, "latest_commit_time"))
            DateTime.to_date(datetime) %>
          </div>
        </div>
      <% end %>
    </div>

    <%= if @readme != nil do %>
      <div class="flex overflow-hidden flex-col mt-4 text-white rounded-xl border bg-surface-800 border-surface-400">
        <div id="header" class="p-4 font-bold text-white bg-surface-500">
          README.md
        </div>
        <div id="markdown" class="p-4 border-t border-surface-400">
          <%= raw(@readme) %>
        </div>
      </div>
    <% end %>
    """
  end
end
