defmodule Hello.Repo do
  use Ecto.Repo,
    otp_app: :hello,
    adapter: Ecto.Adapters.Postgres
  #is the foundation we need to work with databases in a Phoenix applicatoin.

  #in iex -S mix
  #alias Hello.{Repo, User}
  #Repo.insert(%User{email: "user@example.com"})
  #Repo.insert(%User{email: "user2@example.com"})
  #Repo.all(User)

  #Ecto includes a full-fledged query DSL for advanced SQL generation
  #In addition to a natural Elixir DSL, Ecto's quiery engine gives us multiple great features, such as SQL injection protection.
  #In iex -S mix
  #import Ecto.Query
  #Repo.all(from u in User, select: u.email)
  #Note when imported Ecto.Query, imports the from/2 macro of Ecto's Query DSL.
  #Repo.one(from u in User, where: ilike(u.email, "%1%"),
  #                         select: count(u.id))
  #Repo.all(from u in User, select: %{u.id => u.email})
end
