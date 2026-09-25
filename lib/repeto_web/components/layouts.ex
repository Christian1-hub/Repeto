defmodule RepetoWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use RepetoWeb, :html

  @doc """
  Renders your app layout.
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :current_scope, :map, default: nil, doc: "the current scope"
  attr :active_nav, :atom, default: nil, doc: "the currently active sidebar item"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen bg-slate-50 dark:bg-slate-950 flex flex-col font-sans text-slate-900 dark:text-slate-100 pb-20 lg:pb-0 transition-colors" x-data="{ sidebarOpen: $persist(true) }">
      <!-- HEADER -->
      <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 px-4 sm:px-6 flex items-center justify-between sticky top-0 z-30 transition-colors">
        <div class="flex items-center gap-3 lg:gap-8">
          <!-- Bouton toggle sidebar (Desktop/Tablette) -->
          <button @click="sidebarOpen = !sidebarOpen" class="hidden lg:flex p-2 text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors cursor-pointer">
            <.icon name="hero-bars-3" class="w-5 h-5" />
          </button>

          <div class="flex items-center gap-2">
            <div class="w-9 h-9 bg-indigo-600 rounded-xl flex items-center justify-center text-white font-bold text-lg shadow-sm shadow-indigo-200 dark:shadow-none">
              R
            </div>
            <div>
              <h1 class="font-extrabold text-slate-900 dark:text-white leading-none">Repeto</h1>
              <p class="text-[10px] text-slate-400 dark:text-slate-500">Learn together. Grow further.</p>
            </div>
          </div>

          <div class="relative w-96 hidden md:block">
            <.icon name="hero-magnifying-glass" class="w-4 h-4 text-slate-400 dark:text-slate-500 absolute left-3 top-1/2 -translate-y-1/2" />
            <input
              type="text"
              placeholder="Rechercher un sujet, une matière, un répétiteur..."
              class="w-full pl-9 pr-4 py-2 bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl text-xs text-slate-900 dark:text-slate-100 placeholder-slate-400 dark:placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 transition-all"
            />
          </div>
        </div>

        <div class="flex items-center gap-3">
          <!-- Widget de sélection du thème (Dark/Light/System) -->
          <div class="hidden sm:block">
            <.theme_toggle />
          </div>

          <div class="hidden sm:flex items-center gap-2 text-slate-600 dark:text-slate-300">
            <.link navigate={~p"/accueil"} class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors"><.icon name="hero-home" class="w-5 h-5" /></.link>
            <.link navigate={~p"/communautes"} class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors"><.icon name="hero-users" class="w-5 h-5" /></.link>
            <.link navigate={~p"/notifications"} class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl relative transition-colors">
              <.icon name="hero-bell" class="w-5 h-5" />
              <span class="absolute top-1.5 right-1.5 w-4 h-4 bg-rose-500 text-white text-[9px] font-bold rounded-full flex items-center justify-center">3</span>
            </.link>
            <.link navigate={~p"/messages"} class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl relative transition-colors">
              <.icon name="hero-chat-bubble-left-right" class="w-5 h-5" />
              <span class="absolute top-1.5 right-1.5 w-4 h-4 bg-rose-500 text-white text-[9px] font-bold rounded-full flex items-center justify-center">5</span>
            </.link>
          </div>

          <.link navigate={~p"/creer"} class="hidden sm:flex bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-xl text-xs font-semibold items-center gap-2 transition-colors shadow-sm shadow-indigo-200 dark:shadow-none">
            <.icon name="hero-plus" class="w-4 h-4" />
            <span>Créer</span>
          </.link>

          <div class="flex items-center gap-3 pl-2 sm:pl-4 sm:border-l sm:border-slate-200 dark:sm:border-slate-800">
            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100" class="w-9 h-9 rounded-full object-cover ring-2 ring-slate-200 dark:ring-slate-800" />
            <div class="hidden sm:block text-left">
              <h4 class="text-xs font-bold text-slate-900 dark:text-white">Christian</h4>
              <p class="text-[10px] text-slate-400 dark:text-slate-500">Élève</p>
            </div>
            <.icon name="hero-chevron-down" class="hidden sm:block w-3.5 h-3.5 text-slate-400 dark:text-slate-500" />
          </div>
        </div>
      </header>

      <div class="flex flex-1">
        <!-- SIDEBAR -->
        <aside
          x-show="sidebarOpen"
          x-transition:enter="transition duration-200 ease-out"
          x-transition:enter-start="-translate-x-full opacity-0"
          x-transition:enter-end="translate-x-0 opacity-100"
          x-transition:leave="transition duration-150 ease-in"
          x-transition:leave-start="translate-x-0 opacity-100"
          x-transition:leave-end="-translate-x-full opacity-0"
          class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 p-4 hidden lg:flex flex-col justify-between sticky top-16 h-[calc(100vh-4rem)] overflow-y-auto z-20 shrink-0 transition-colors"
        >
          <nav class="space-y-1">
            <.nav_item navigate={~p"/accueil"} icon="hero-home" label="Accueil" active={assigns[:active_nav] == :accueil} />
            <.nav_item navigate={~p"/explorer"} icon="hero-magnifying-glass" label="Explorer" active={assigns[:active_nav] == :explorer} />
            <.nav_item navigate={~p"/communautes"} icon="hero-user-group" label="Communautés" active={assigns[:active_nav] == :communautes} />
            <.nav_item navigate={~p"/messages"} icon="hero-chat-bubble-left" label="Messages" badge="5" active={assigns[:active_nav] == :messages} />
            <.nav_item navigate={~p"/notifications"} icon="hero-bell" label="Notifications" badge="3" active={assigns[:active_nav] == :notifications} />
            <.nav_item navigate={~p"/repetiteurs"} icon="hero-user" label="Trouver un répétiteur" active={assigns[:active_nav] == :repetitor} />
            <.nav_item navigate={~p"/cours"} icon="hero-book-open" label="Mes cours" active={assigns[:active_nav] == :cours} />
            <.nav_item navigate={~p"/progression"} icon="hero-chart-bar" label="Progression" active={assigns[:active_nav] == :progression} />
            <.nav_item navigate={~p"/ressources"} icon="hero-folder" label="Ressources" active={assigns[:active_nav] == :ressources} />
            <.nav_item navigate={~p"/quiz"} icon="hero-academic-cap" label="Quiz" active={assigns[:active_nav] == :quiz} />
            <.nav_item navigate={~p"/evenements"} icon="hero-calendar" label="Événements" active={assigns[:active_nav] == :evenements} />
            <.nav_item navigate={~p"/favoris"} icon="hero-heart" label="Favoris" active={assigns[:active_nav] == :favoris} />
          </nav>

          <!-- Bloc Promo Premium -->
          <div class="bg-gradient-to-br from-indigo-600 to-indigo-800 dark:from-indigo-900 dark:to-indigo-950 rounded-2xl p-3 text-white relative overflow-hidden shadow-lg shadow-indigo-100 dark:shadow-none mt-4">
            <div class="relative z-10 space-y-3">
              <div class="flex items-center gap-2">
                <.icon name="hero-shield-check" class="w-5 h-5 text-amber-300" />
                <span class="font-bold text-xs tracking-wide">Repeto Premium</span>
              </div>
              <p class="text-[11px] text-indigo-100 leading-relaxed">
                Plus d'outils, plus de contenus exclusifs et un suivi avancé.
              </p>
              <.link navigate={~p"/premium"} class="block text-center w-full bg-white text-indigo-900 font-bold py-2 rounded-xl text-xs hover:bg-indigo-50 transition-colors shadow-sm">
                Découvrir Premium
              </.link>
            </div>
          </div>
        </aside>

        <!-- CONTENU PRINCIPAL -->
        <main class="flex-1 p-4 sm:p-6 lg:p-8 space-y-6 max-w-7xl mx-auto">
          {render_slot(@inner_block)}
        </main>
      </div>

      <!-- Navigation mobile (Bottom Bar) -->
      <nav class="lg:hidden fixed bottom-0 left-0 right-0 bg-white/95 dark:bg-slate-900/95 backdrop-blur-md border-t border-slate-200 dark:border-slate-800 px-4 py-2.5 flex items-center justify-around z-40 shadow-lg transition-colors">
        <.link navigate={~p"/accueil"} class={if assigns[:active_nav] == :accueil, do: "p-2 rounded-xl transition-colors text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/50", else: "p-2 rounded-xl transition-colors text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white"}>
          <.icon name="hero-home" class="w-6 h-6" />
        </.link>

        <.link navigate={~p"/explorer"} class={if assigns[:active_nav] == :explorer, do: "p-2 rounded-xl transition-colors text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/50", else: "p-2 rounded-xl transition-colors text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white"}>
          <.icon name="hero-magnifying-glass" class="w-6 h-6" />
        </.link>

        <!-- Bouton central "Créer" mis en valeur -->
        <.link navigate={~p"/creer"} class="p-2.5 bg-indigo-600 text-white rounded-2xl shadow-md shadow-indigo-200 dark:shadow-none hover:bg-indigo-700 transition-colors">
          <.icon name="hero-plus" class="w-6 h-6" />
        </.link>

        <.link navigate={~p"/messages"} class={"p-2 rounded-xl transition-colors relative " <> if(assigns[:active_nav] == :messages, do: "text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/50", else: "text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white")}>
          <.icon name="hero-chat-bubble-left-right" class="w-6 h-6" />
          <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-rose-500 rounded-full"></span>
        </.link>

        <.link navigate={~p"/notifications"} class={"p-2 rounded-xl transition-colors relative " <> if(assigns[:active_nav] == :notifications, do: "text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/50", else: "text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white")}>
          <.icon name="hero-bell" class="w-6 h-6" />
          <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-rose-500 rounded-full"></span>
        </.link>
      </nav>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={
          show(".phx-client-error #client-error")
          |> JS.remove_attribute("hidden", to: ".phx-client-error #client-error")
        }
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={
          show(".phx-server-error #server-error")
          |> JS.remove_attribute("hidden", to: ".phx-server-error #server-error")
        }
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 rounded-full p-0.5">
      <button
        class="flex p-2 cursor-pointer rounded-full hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors text-slate-500 dark:text-slate-400"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        title="Système"
      >
        <.icon name="hero-computer-desktop" class="w-4 h-4" />
      </button>

      <button
        class="flex p-2 cursor-pointer rounded-full hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors text-slate-500 dark:text-slate-400"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
        title="Mode clair"
      >
        <.icon name="hero-sun" class="w-4 h-4" />
      </button>

      <button
        class="flex p-2 cursor-pointer rounded-full hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors text-slate-500 dark:text-slate-400"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
        title="Mode sombre"
      >
        <.icon name="hero-moon" class="w-4 h-4" />
      </button>
    </div>
    """
  end

  attr :navigate, :string, required: true
  attr :icon, :string, required: true
  attr :label, :string, required: true
  attr :badge, :string, default: nil
  attr :active, :boolean, default: false

  def nav_item(assigns) do
    ~H"""
    <.link navigate={@navigate} class={"flex items-center justify-between px-3.5 py-2.5 rounded-xl text-xs font-semibold transition-colors " <> if(@active, do: "bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 font-bold", else: "text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 hover:text-slate-900 dark:hover:text-slate-200")}>
      <div class="flex items-center gap-3">
        <.icon name={@icon} class={"w-4 h-4 " <> if(@active, do: "text-indigo-600 dark:text-indigo-400", else: "text-slate-400 dark:text-slate-500")} />
        <span>{@label}</span>
      </div>
      <%= if @badge do %>
        <span class="w-5 h-5 bg-rose-500 text-white text-[10px] font-bold rounded-full flex items-center justify-center">{@badge}</span>
      <% end %>
    </.link>
    """
  end

  embed_templates "layouts/*"
end
