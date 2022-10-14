defmodule Hello.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_line_items" do
    field :price, :decimal
    field :quantity, :integer
    #field :order_id, :id
    #field :product_id, :id
    #Let's wire up the association(orders, products) in the other direction
    belongs_to :order, Hello.Orders.Order
    belongs_to :product, Hello.Catalog.Product

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:price, :quantity])
    |> validate_required([:price, :quantity])
  end
end
