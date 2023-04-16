defmodule GittyWeb.Layouts do
  use GittyWeb, :html
  import Gitty.Profiles

  embed_templates "layouts/*"
end
