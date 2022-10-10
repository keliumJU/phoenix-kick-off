defmodule Hello.ShoppingCart.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :user_uuid, Ecto.UUID
    #cart is associated to the items we place in it
    has_many :items, Hello.ShoppingCart.CartItem
    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:user_uuid])
    |> validate_required([:user_uuid])
    |> unique_constraint(:user_uuid)
  end
end
