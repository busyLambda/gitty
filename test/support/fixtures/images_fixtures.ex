defmodule Gitty.ImagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gitty.Images` context.
  """

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        path: "some path"
      })
      |> Gitty.Images.create_image()

    image
  end
end
