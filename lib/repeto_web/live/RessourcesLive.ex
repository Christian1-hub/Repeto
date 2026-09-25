defmodule RepetoWeb.RessourcesLive do
  use RepetoWeb, :live_view

  # ==========================================
  # COMPOSANTS FONCTIONNELS (DÉFINIS EN PREMIER)
  # ==========================================

  def tab_button(assigns) do
    ~H"""
    <button
      phx-click="change_tab"
      phx-value-tab={@tab}
      class={[
        "flex items-center gap-2 px-4 py-2.5 rounded-2xl text-xs font-bold shrink-0 transition-all cursor-pointer border",
        @active && "bg-indigo-600 text-white border-indigo-600 shadow-sm" || "bg-white dark:bg-slate-900 text-slate-600 dark:text-slate-300 border-slate-200/80 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/80"
      ]}
    >
      <.icon name={@icon} class="w-4 h-4" />
      <span>{@label}</span>
    </button>
    """
  end

  def resource_card(assigns) do
    ~H"""
    <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200/80 dark:border-slate-800 shadow-2xs overflow-hidden flex flex-col justify-between hover:shadow-md dark:hover:border-slate-700 transition-all group">
      <div>
        <div class="relative h-40 bg-slate-100 dark:bg-slate-800 overflow-hidden">
          <img src={@preview_image} alt={@title} class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />

          <div class="absolute inset-0 bg-gradient-to-t from-slate-950/60 via-transparent to-transparent"></div>

          <div class="absolute top-3 left-3 right-3 flex items-center justify-between">
            <span class={"text-[10px] font-extrabold px-2.5 py-1 rounded-xl #{@type_badge_bg} shadow-sm"}>
              {@type}
            </span>
            <span class="text-[10px] font-bold text-white bg-slate-950/70 backdrop-blur-md px-2 py-0.5 rounded-lg">
              {@format_badge}
            </span>
          </div>

          <%= if @is_video do %>
            <div class="absolute inset-0 flex items-center justify-center">
              <div class="w-10 h-10 rounded-full bg-indigo-600 text-white flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                <.icon name="hero-play" class="w-5 h-5 ml-0.5" />
              </div>
            </div>
          <% end %>

          <div class="absolute bottom-3 left-3 flex items-center gap-2">
            <img src={@author_avatar} alt={@author} class="w-6 h-6 rounded-full border border-white/80 dark:border-slate-800 object-cover" />
            <span class="text-[11px] font-bold text-white drop-shadow-sm">{@author}</span>
          </div>
        </div>

        <div class="p-4 space-y-3">
          <h3 class="text-xs font-black text-slate-900 dark:text-white group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors line-clamp-1">
            {@title}
          </h3>

          <%= if assigns[:description] do %>
            <p class="text-[11px] text-slate-500 dark:text-slate-400 line-clamp-2 leading-relaxed">{@description}</p>
          <% end %>

          <div class="flex flex-wrap gap-1.5 pt-0.5">
            <%= for t <- @tags do %>
              <span class="text-[10px] font-medium text-slate-600 dark:text-slate-300 bg-slate-100 dark:bg-slate-800 px-2 py-0.5 rounded-md">
                <%= t %>
              </span>
            <% end %>
          </div>
        </div>
      </div>

      <div class="px-4 py-3 bg-slate-50/70 dark:bg-slate-900/50 border-t border-slate-100 dark:border-slate-800 flex items-center justify-between text-[11px] text-slate-500 dark:text-slate-400 font-medium">
        <div class="flex items-center gap-3">
          <span class="flex items-center gap-1">
            <.icon name="hero-arrow-down-tray" class="w-3.5 h-3.5 text-slate-400 dark:text-slate-500" />
            {@downloads}
          </span>
          <span class="flex items-center gap-1">
            <.icon name="hero-eye" class="w-3.5 h-3.5 text-slate-400 dark:text-slate-500" />
            {@views}
          </span>
        </div>
        <button class="w-7 h-7 rounded-lg hover:bg-slate-200/60 dark:hover:bg-slate-800 flex items-center justify-center text-slate-400 dark:text-slate-500 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors cursor-pointer">
          <.icon name="hero-bookmark" class="w-4 h-4" />
        </button>
      </div>
    </div>
    """
  end

  def favorite_item(assigns) do
    ~H"""
    <div class="flex items-center justify-between p-2 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/60 transition-colors group cursor-pointer">
      <div class="flex items-center gap-2.5">
        <div class={"w-8 h-8 #{@icon_bg} rounded-xl flex items-center justify-center shrink-0"}>
          <.icon name={@icon} class="w-4 h-4" />
        </div>
        <div>
          <h4 class="text-xs font-bold text-slate-900 dark:text-white group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors line-clamp-1">
            {@title}
          </h4>
          <p class="text-[10px] text-slate-400 dark:text-slate-500">{@subtitle}</p>
        </div>
      </div>
      <button class="text-slate-300 dark:text-slate-600 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">
        <.icon name="hero-bookmark-solid" class="w-4 h-4" />
      </button>
    </div>
    """
  end

  def popular_item(assigns) do
    ~H"""
    <div class="flex items-center justify-between gap-3 p-2 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/60 transition-colors group cursor-pointer">
      <div class="flex items-center gap-3">
        <span class="text-xs font-black text-slate-400 dark:text-slate-500 w-3 text-center">{@rank}</span>
        <img src={@img} alt="" class="w-9 h-9 rounded-xl object-cover shrink-0 border border-slate-200 dark:border-slate-800" />
        <div class="space-y-0.5">
          <h4 class="text-xs font-bold text-slate-900 dark:text-white group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors line-clamp-1">
            {@title}
          </h4>
          <p class="text-[10px] text-slate-400 dark:text-slate-500">{@category}</p>
        </div>
      </div>
      <div class="text-right shrink-0">
        <span class="text-[10px] font-bold text-slate-700 dark:text-slate-300 flex items-center gap-1 justify-end">
          <.icon name="hero-arrow-down-tray" class="w-3 h-3 text-slate-400 dark:text-slate-500" /> {@downloads}
        </span>
      </div>
    </div>
    """
  end

  # ==========================================
  # LOGIQUE LIVEVIEW & RENDU PRINCIPAL
  # ==========================================

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, "ressources")
      |> assign(:active_tab, "tous")
      |> assign(:selected_subject, "Toutes les matières")
      |> assign(:selected_level, "Tous les niveaux")
      |> assign(:selected_sort, "Plus récent")
      |> assign(:search_query, "")
      |> assign(:current_scope, nil)
      |> assign(:user, %{
        name: "Christian B.",
        role: "Élève • Terminale C",
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=faces"
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("change_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, :active_tab, tab)}
  end

  @impl true
  def handle_event("search", %{"value" => query}, socket) do
    {:noreply, assign(socket, :search_query, query)}
  end

  @impl true
  def handle_event("filter_changed", params, socket) do
    socket =
      socket
      |> assign(:selected_subject, params["subject"] || socket.assigns.selected_subject)
      |> assign(:selected_level, params["level"] || socket.assigns.selected_level)
      |> assign(:selected_sort, params["sort"] || socket.assigns.selected_sort)

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="flex-1 flex overflow-hidden h-[calc(100vh-4rem)] bg-slate-50/50 dark:bg-slate-950">

        <!-- Contenu Central -->
        <main class="flex-1 p-4 sm:p-6 overflow-y-auto space-y-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- Bannière supérieure Ressources -->
          <div class="relative overflow-hidden bg-gradient-to-r from-indigo-900 via-indigo-800 to-indigo-950 p-6 sm:p-8 rounded-3xl text-white shadow-lg flex flex-col justify-between space-y-6">
            <div class="absolute -right-10 -bottom-10 opacity-10 pointer-events-none">
              <.icon name="hero-folder" class="w-72 h-72" />
            </div>

            <div class="max-w-xl space-y-2 relative z-10">
              <h1 class="text-xl sm:text-2xl font-black tracking-tight">Ressources</h1>
              <p class="text-xs text-indigo-200 leading-relaxed">
                Des milliers de documents, fiches, annales et supports pour t'aider à réussir.
              </p>
            </div>

            <div class="relative max-w-xl z-10">
              <span class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-slate-400">
                <.icon name="hero-magnifying-glass" class="w-4 h-4" />
              </span>
              <input
                type="text"
                name="search"
                value={@search_query}
                phx-keyup="search"
                phx-debounce="300"
                placeholder="Rechercher une ressource..."
                class="w-full bg-white dark:bg-slate-900 text-slate-900 dark:text-white placeholder-slate-400 text-xs rounded-2xl pl-11 pr-4 py-3.5 shadow-md focus:outline-none focus:ring-2 focus:ring-indigo-500 font-medium border border-transparent dark:border-slate-800"
              />
            </div>
          </div>

          <!-- Filtres par type d'onglet -->
          <div class="flex items-center gap-2 overflow-x-auto pb-1 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
            <.tab_button label="Tous" icon="hero-squares-2x2" tab="tous" active={@active_tab == "tous"} />
            <.tab_button label="Fiches de révision" icon="hero-document-text" tab="fiches" active={@active_tab == "fiches"} />
            <.tab_button label="Annales" icon="hero-book-open" tab="annales" active={@active_tab == "annales"} />
            <.tab_button label="Exercices corrigés" icon="hero-academic-cap" tab="exercices" active={@active_tab == "exercices"} />
            <.tab_button label="PDF" icon="hero-document" tab="pdf" active={@active_tab == "pdf"} />
            <.tab_button label="Vidéos" icon="hero-video-camera" tab="videos" active={@active_tab == "videos"} />
            <.tab_button label="Liens utiles" icon="hero-link" tab="liens" active={@active_tab == "liens"} />
          </div>

          <!-- Filtres déroulants dynamiques -->
          <form phx-change="filter_changed" class="flex flex-col lg:flex-row lg:items-center justify-between gap-3 bg-white dark:bg-slate-900 p-4 rounded-2xl border border-slate-200/85 dark:border-slate-800 shadow-2xs">
            <div class="flex flex-wrap items-center gap-3">
              <div class="relative w-full sm:w-auto">
                <select name="subject" class="w-full sm:w-auto bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 text-xs rounded-xl px-3.5 py-2.5 font-medium focus:outline-none focus:ring-1 focus:ring-indigo-500 cursor-pointer">
                  <option selected={@selected_subject == "Toutes les matières"}>Toutes les matières</option>
                  <option selected={@selected_subject == "Mathématiques"}>Mathématiques</option>
                  <option selected={@selected_subject == "Physique"}>Physique</option>
                  <option selected={@selected_subject == "Chimie"}>Chimie</option>
                  <option selected={@selected_subject == "Français"}>Français</option>
                </select>
              </div>

              <div class="relative w-full sm:w-auto">
                <select name="level" class="w-full sm:w-auto bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 text-xs rounded-xl px-3.5 py-2.5 font-medium focus:outline-none focus:ring-1 focus:ring-indigo-500 cursor-pointer">
                  <option selected={@selected_level == "Tous les niveaux"}>Tous les niveaux</option>
                  <option selected={@selected_level == "Terminale C"}>Terminale C</option>
                  <option selected={@selected_level == "Première C"}>Première C</option>
                  <option selected={@selected_level == "Seconde"}>Seconde</option>
                </select>
              </div>

              <div class="relative w-full sm:w-auto">
                <select name="sort" class="w-full sm:w-auto bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 text-xs rounded-xl px-3.5 py-2.5 font-medium focus:outline-none focus:ring-1 focus:ring-indigo-500 cursor-pointer">
                  <option selected={@selected_sort == "Plus récent"}>Trier par : Plus récent</option>
                  <option selected={@selected_sort == "Plus populaire"}>Plus populaire</option>
                  <option selected={@selected_sort == "Mieux notés"}>Mieux notés</option>
                </select>
              </div>
            </div>

            <button type="button" class="flex items-center justify-center gap-1.5 px-4 py-2.5 rounded-xl border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-bold transition-colors cursor-pointer">
              <.icon name="hero-funnel" class="w-3.5 h-3.5 text-indigo-600 dark:text-indigo-400" />
              <span>Filtrer</span>
            </button>
          </form>

          <!-- Grille des Ressources -->
          <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5">

            <.resource_card
              type="Fiche de révision"
              type_badge_bg="bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 border border-indigo-200/50 dark:border-indigo-800/50"
              format_badge="PDF - 12 pages"
              title="Fiche de révision : Dérivées"
              author="M. Franck T."
              author_avatar="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Terminale C", "Dérivées"]}
              downloads="1.2k"
              views="2.4k"
              preview_image="https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&h=300&fit=crop"
              is_video={false}
            />

            <.resource_card
              type="Annales"
              type_badge_bg="bg-amber-50 dark:bg-amber-950/60 text-amber-700 dark:text-amber-400 border border-amber-200/50 dark:border-amber-800/50"
              format_badge="PDF - 45 pages"
              title="Série d'annales Bac 2023 - Mathématiques"
              author="Sarah K."
              author_avatar="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Terminale C", "Bac"]}
              downloads="856"
              views="1.9k"
              preview_image="https://images.unsplash.com/photo-1543269865-cbf427effbad?w=500&h=300&fit=crop"
              is_video={false}
            />

            <.resource_card
              type="Vidéo"
              type_badge_bg="bg-purple-50 dark:bg-purple-950/60 text-purple-600 dark:text-purple-400 border border-purple-200/50 dark:border-purple-800/50"
              format_badge="12 min"
              title="Les fonctions : cours complet"
              author="M. David N."
              author_avatar="https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Terminale C", "Fonctions"]}
              downloads="856"
              views="1.5k"
              preview_image="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&h=300&fit=crop"
              is_video={true}
            />

            <.resource_card
              type="Exercice corrigé"
              type_badge_bg="bg-emerald-50 dark:bg-emerald-950/60 text-emerald-600 dark:text-emerald-400 border border-emerald-200/50 dark:border-emerald-800/50"
              format_badge="PDF - 8 pages"
              title="Exercices corrigés : Intégrales"
              author="M. Franck T."
              author_avatar="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Terminale C", "Intégrales"]}
              downloads="512"
              views="1.2k"
              preview_image="https://images.unsplash.com/photo-1509228468518-180dd4864904?w=500&h=300&fit=crop"
              is_video={false}
            />

            <.resource_card
              type="Fiche de révision"
              type_badge_bg="bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 border border-indigo-200/50 dark:border-indigo-800/50"
              format_badge="PDF - 10 pages"
              title="Les triangles et trigonométrie"
              author="Mme. Sarah K."
              author_avatar="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Première C", "Trigonométrie"]}
              downloads="398"
              views="986"
              preview_image="https://images.unsplash.com/photo-1509228468518-180dd4864904?w=500&h=300&fit=crop"
              is_video={false}
            />

            <.resource_card
              type="Lien utile"
              type_badge_bg="bg-sky-50 dark:bg-sky-950/60 text-sky-600 dark:text-sky-400 border border-sky-200/50 dark:border-sky-800/50"
              format_badge="Outil en ligne"
              title="Simulateur de calculatrice Casio"
              author="Équipe Repeto"
              author_avatar="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=80&h=80&fit=crop&crop=faces"
              tags={["Mathématiques", "Tous niveaux"]}
              downloads="287"
              views="724"
              preview_image="https://images.unsplash.com/photo-1587145820266-a5951ee6f620?w=500&h=300&fit=crop"
              description="Un outil en ligne pour s'entraîner à utiliser votre calculatrice scientifique."
              is_video={false}
            />

          </div>

        </main>

        <!-- Sidebar Droite (Masquable sur petits écrans, visible à partir de xl) -->
        <aside class="w-80 bg-white dark:bg-slate-900 border-l border-slate-200 dark:border-slate-800 hidden xl:flex flex-col p-5 overflow-y-auto space-y-6 shrink-0 h-full [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- Mes ressources favorites -->
          <div class="space-y-3.5">
            <div class="flex items-center justify-between">
              <h2 class="text-xs font-black uppercase tracking-wider text-slate-500 dark:text-slate-400">Mes ressources favorites</h2>
              <button class="text-[11px] font-bold text-indigo-600 dark:text-indigo-400 hover:text-indigo-700 dark:hover:text-indigo-300 cursor-pointer">Voir tout</button>
            </div>

            <div class="space-y-2.5">
              <.favorite_item
                icon="hero-document-text"
                icon_bg="bg-indigo-50 dark:bg-indigo-950 text-indigo-600 dark:text-indigo-400"
                title="Fiche de révision : Dérivées"
                subtitle="Mathématiques • Terminale C"
              />
              <.favorite_item
                icon="hero-book-open"
                icon_bg="bg-amber-50 dark:bg-amber-950 text-amber-700 dark:text-amber-400"
                title="Annales Bac 2023"
                subtitle="Mathématiques • Terminale C"
              />
              <.favorite_item
                icon="hero-academic-cap"
                icon_bg="bg-emerald-50 dark:bg-emerald-950 text-emerald-600 dark:text-emerald-400"
                title="Exercices corrigés : Intégrales"
                subtitle="Mathématiques • Terminale C"
              />
              <.favorite_item
                icon="hero-video-camera"
                icon_bg="bg-purple-50 dark:bg-purple-950 text-purple-600 dark:text-purple-400"
                title="Les fonctions : cours complet"
                subtitle="Mathématiques • Terminale C"
              />
              <.favorite_item
                icon="hero-calculator"
                icon_bg="bg-sky-50 dark:bg-sky-950 text-sky-600 dark:text-sky-400"
                title="Simulateur de calculatrice Casio"
                subtitle="Mathématiques • Tous niveaux"
              />
            </div>
          </div>

          <!-- Ressources populaires -->
          <div class="space-y-3.5 pt-2">
            <div class="flex items-center justify-between">
              <h2 class="text-xs font-black uppercase tracking-wider text-slate-500 dark:text-slate-400">Ressources populaires</h2>
            </div>

            <div class="flex items-center bg-slate-100 dark:bg-slate-800 p-1 rounded-xl text-[10px] font-bold text-slate-600 dark:text-slate-300">
              <button class="flex-1 py-1 rounded-lg bg-white dark:bg-slate-700 text-indigo-600 dark:text-indigo-400 shadow-2xs text-center">Cette semaine</button>
              <button class="flex-1 py-1 rounded-lg text-slate-500 dark:text-slate-400 hover:text-slate-800 dark:hover:text-white text-center">Ce mois</button>
              <button class="flex-1 py-1 rounded-lg text-slate-500 dark:text-slate-400 hover:text-slate-800 dark:hover:text-white text-center">Tous temps</button>
            </div>

            <div class="space-y-3">
              <.popular_item
                rank="1"
                title="Série d'annales Bac 2023"
                category="Mathématiques • Terminale C"
                downloads="2.8k"
                views="1.2k"
                img="https://images.unsplash.com/photo-1543269865-cbf427effbad?w=100&h=100&fit=crop"
              />
              <.popular_item
                rank="2"
                title="Fiche de révision : Dérivées"
                category="Mathématiques • Terminale C"
                downloads="2.4k"
                views="1.1k"
                img="https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=100&h=100&fit=crop"
              />
              <.popular_item
                rank="3"
                title="Les 15 formules de physique"
                category="Physique • Terminale C"
                downloads="2.1k"
                views="980"
                img="https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=100&h=100&fit=crop"
              />
              <.popular_item
                rank="4"
                title="Exercices corrigés : Fonctions"
                category="Mathématiques • Première C"
                downloads="1.8k"
                views="874"
                img="https://images.unsplash.com/project-images/placeholder.png"
              />
              <.popular_item
                rank="5"
                title="Chimie organique : fiches"
                category="Chimie • Terminale C"
                downloads="1.6k"
                views="762"
                img="https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?w=100&h=100&fit=crop"
              />
            </div>
          </div>

          <!-- Encart Partage de ressource -->
          <div class="bg-gradient-to-br from-indigo-900 to-indigo-950 p-4 rounded-2xl text-white space-y-3 shadow-md relative overflow-hidden">
            <div class="absolute right-0 bottom-0 opacity-10 pointer-events-none">
              <.icon name="hero-share" class="w-24 h-24" />
            </div>
            <div class="flex items-start gap-3 relative z-10">
              <div class="w-8 h-8 rounded-xl bg-white/10 flex items-center justify-center shrink-0">
                <.icon name="hero-bookmark" class="w-4 h-4 text-indigo-300" />
              </div>
              <div>
                <h3 class="text-xs font-black">Tu as une ressource à partager ?</h3>
                <p class="text-[11px] text-indigo-200 mt-1 leading-relaxed">
                  Aide la communauté en partageant tes fiches, annales ou liens utiles.
                </p>
              </div>
            </div>
            <button class="w-full bg-white text-indigo-950 hover:bg-indigo-50 font-black text-xs py-2.5 rounded-xl transition-colors cursor-pointer relative z-10 shadow-sm">
              Partager une ressource →
            </button>
          </div>

        </aside>

      </div>
    </Layouts.app>
    """
  end
end
