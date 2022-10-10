defmodule HelloWeb.ErrorViewTest do
  #async: true -> means that this test case will be run in parallel with other test cases
  use HelloWeb.ConnCase, async: true

  #@moduletag error_view_case: "some_interesting_value"
  @moduletag :error_view_case

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  #for individual test case with tag
  @tag individual_test: "yup"
  test "renders 404.html" do
    assert render_to_string(HelloWeb.ErrorView, "404.html", []) == "Not Found"
  end

  @tag individual_test: "nope"
  test "renders 500.html" do
    assert render_to_string(HelloWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
