defmodule RepetoWeb.Router do
  use RepetoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RepetoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :app do
    scope "/", RepetoWeb do
      pipe_through :browser
      live "/", RegisterLive
      live "/repetiteurs", TutorLive
      live "/accueil", HomeLive
      live "/home", HomeLive123
      live "/explorer", ExplorerLive
      live "communautes", CommunityLive
      live "/communaute", CommunauteLive
      live "/messages", MessageLive
      live "/notifications", NotificationLive
      live "cours", MesCoursLive
      live "/progression", ProgressionLive
      live "/ressources", RessourcesLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RepetoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:repeto, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RepetoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
