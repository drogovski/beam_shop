defmodule BeamShopWeb.Router do
  use BeamShopWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/" do
  #   pipe_through :api

  #   forward "/api", GraphQl.Router
  # end

  # if Application.compile_env(:beam_shop, :dev_routes) do
  #   forward "/graphiql",
  #     to: Absinthe.Plug.GraphiQL,
  #     init_opts: [
  #       interface: :playground
  #     ]
  # end

  scope "/api", BeamShopWeb do
    pipe_through :api
  end



  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:beam_shop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BeamShopWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end