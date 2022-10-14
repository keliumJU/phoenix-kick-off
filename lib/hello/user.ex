defmodule Hello.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string
    field :email, :string
    field :name, :string
    field :number_of_pets, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    #in iex -S mix -> alias Hello.User
    #changeset = User.changeset(%User{}, %{})
    #changeset.valid? -> false
    #changeset.errors

    #create a param in iex
    #params = %{name: "Joe Example", email: "joe@example.com", bio: "An example to all", number_of_pets: 5, random_key: "random value"}
    #now create another changeset
    #changeset = User.changeset(%User{}, params)
    #changeset.changes
    user
    |> cast(attrs, [:name, :email, :bio, :number_of_pets])
    |> validate_required([:name, :email, :bio])
    |> validate_length(:bio, min: 2) # requirement that all biographies in our system must be at least two characters long
    |> validate_length(:bio, max: 140) #maximum length that a bio can have
    |> validate_format(:email, ~r/@/) #check for is the presence of the @

  end
end
