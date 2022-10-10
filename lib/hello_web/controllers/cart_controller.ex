defmodule HelloWeb.CartController do
  use HelloWeb, :controller

  alias Hello.ShoppingCart

#Fortunately, the context generator included a ShoppingChart.change_cart/1 function,
#which we'll use. We pass it our cart struct which is already in the connection assigns
#thanks to the fetch_current_cart plug we defined in the router.
  def show(conn, _params) do
    render(conn, "show.html", changeset: ShoppingCart.change_cart(conn.assigns.cart))
  end
  def update(conn, %{"cart" => cart_params}) do
    case ShoppingCart.update_cart(conn.assigns.cart, cart_params) do
      {:ok, cart} ->
        redirect(conn, to: Routes.cart_path(conn, :show))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error updating your cart")
        |> redirect(to: Routes.cart_path(conn, :show))
    end
  end
end
