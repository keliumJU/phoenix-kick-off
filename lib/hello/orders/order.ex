defmodule Hello.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :total_price, :decimal
    field :user_uuid, Ecto.UUID

    #let's wire up our oders and line items associations
    has_many :line_items, Hello.Orders.LineItem
    has_many :products, through: [:line_items, :product]

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_uuid, :total_price])
    |> validate_required([:user_uuid, :total_price])
  end
end
