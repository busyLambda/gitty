defmodule Gitty.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gitty.Profiles` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        company: "some company",
        location: "some location",
        name: "some name",
        twitter_username: "some twitter_username",
        website: "some website"
      })
      |> Gitty.Profiles.create_profile()

    profile
  end
end
