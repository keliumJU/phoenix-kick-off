defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    #overridings rendering format
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HelloWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #scope routes-> group of routes under a common path prefix
  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    #page for redirect
    get "/redirect_test", PageController, :redirect_test

    #crud complete of users
    resources "/users", UserController
    #read-only post resource
    resources "/posts", PostController, only: [:index, :show]
    #comments resource, we don't want to provide a reoute to delete
    resources "/comments", CommentController, except: [:delete]
    #reviews for users without admin prefix
    resources "/reviews", ReviewController

    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
  end

  # Other scopes may use custom stacks.
   scope "/api", HelloWeb do
     pipe_through :api

     resources "/reviews", ReviewController
   end
  #creating new pipelines with pipeline/2 macro 2 arguments: an atom name of pipeline and block with all the plugs we want in it.
  #pipeline :review_checks do
  #  plug :browser
  #  plug :ensure_authenticated_user
  #  plug :ensure_user_owns_review
  #end


  #exapmle with list of pipelines if we need to pipe request throuhg both :browser and one or more custom pipelines...
  #only the reviews resources will pipe through the :review_checks pipeline
   scope "/reviews", HelloWeb do
    pipe_through [:browser, :api, ] #...:review_checks if exists
    resources "/", ReviewController
   end

  #forward -> Phoenix.Router.forward/4 macro can be used to send all request that start with a particular path to
  #a particular plug.
  #running jobs in background but it could have its own web interface we can forward to this admin interface
  #this means that all routes starting with /jobs will be sent to the HelloWeb.BackgroundJob.Plug module
  forward "/jobs", BackgroundJob.Plug

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
