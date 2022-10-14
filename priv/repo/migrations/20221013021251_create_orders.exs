defmodule Hello.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_uuid, :uuid
      add :total_price, :decimal, precision: 15, scale: 6, null: false

      timestamps()
    end
  end
end
