defmodule GittyWeb.FrontendController do
  use GittyWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
