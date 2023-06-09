defmodule Gitty.ProfilesTest do
  use Gitty.DataCase

  alias Gitty.Profiles

  describe "profiles" do
    alias Gitty.Profiles.Profile

    import Gitty.ProfilesFixtures

    @invalid_attrs %{bio: nil, company: nil, location: nil, name: nil, twitter_username: nil, website: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Profiles.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Profiles.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{bio: "some bio", company: "some company", location: "some location", name: "some name", twitter_username: "some twitter_username", website: "some website"}

      assert {:ok, %Profile{} = profile} = Profiles.create_profile(valid_attrs)
      assert profile.bio == "some bio"
      assert profile.company == "some company"
      assert profile.location == "some location"
      assert profile.name == "some name"
      assert profile.twitter_username == "some twitter_username"
      assert profile.website == "some website"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      update_attrs = %{bio: "some updated bio", company: "some updated company", location: "some updated location", name: "some updated name", twitter_username: "some updated twitter_username", website: "some updated website"}

      assert {:ok, %Profile{} = profile} = Profiles.update_profile(profile, update_attrs)
      assert profile.bio == "some updated bio"
      assert profile.company == "some updated company"
      assert profile.location == "some updated location"
      assert profile.name == "some updated name"
      assert profile.twitter_username == "some updated twitter_username"
      assert profile.website == "some updated website"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_profile(profile, @invalid_attrs)
      assert profile == Profiles.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Profiles.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Profiles.change_profile(profile)
    end
  end
end
