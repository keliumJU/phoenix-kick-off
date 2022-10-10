defmodule Hello.Blog.PostTest do
  use Hello.DataCase, async: true
  alias Hello.Blog.Post

  #test of the schema
  test "title must be at least two characters long" do
    changeset = Post.changeset(%Post{}, %{title: "I"})
    assert %{title: ["should be at least 2 character(s)"]} = errors_on(changeset)
  end
end
