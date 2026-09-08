defmodule RepetoWeb.ExplorerLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, :explorer)
      |> assign(:selected_category, "tout")
      |> assign_explore_data()

    {:ok, socket}
  end

  @impl true
  def handle_event("filter_category", %{"category" => category}, socket) do
    {:noreply, assign(socket, :selected_category, category)}
  end

  defp assign_explore_data(socket) do
    communities = [
      %{name: "Mathématiques", members: "125 400 membres", desc: "Partage de cours, exercices et astuces sur les maths.", image: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&auto=format&fit=crop&q=80", icon_bg: "bg-indigo-600"},
      %{name: "Prépa Bac 2024", members: "98 230 membres", desc: "Tout pour réussir ton Bac : conseils, épreuves, révisions.", image: "https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&auto=format&fit=crop&q=80", icon_bg: "bg-emerald-600"},
      %{name: "Terminale C", members: "76 890 membres", desc: "Communauté des élèves de Terminale C.", image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=400&auto=format&fit=crop&q=80", icon_bg: "bg-blue-600"},
      %{name: "Physique-Chimie", members: "54 120 membres", desc: "Cours, exercices et expériences expliquées simplement.", image: "https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400&auto=format&fit=crop&q=80", icon_bg: "bg-purple-600"}
    ]

    tutors = [
      %{name: "M. Franck T.", role: "Mathématiques & Physique", rating: "4.8", reviews: "87 avis", city: "Douala, Cameroun", price: "6 000 FCFA", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80"},
      %{name: "Mme. Sarah K.", role: "Mathématiques", rating: "4.9", reviews: "64 avis", city: "Yaoundé, Cameroun", price: "5 000 FCFA", avatar: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100&auto=format&fit=crop&q=80"},
      %{name: "M. David P.", role: "Physique & SVT", rating: "4.7", reviews: "51 avis", city: "Douala, Cameroun", price: "5 500 FCFA", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80"},
      %{name: "Mme. Lina M.", role: "Anglais", rating: "4.6", reviews: "38 avis", city: "Bafoussam, Cameroun", price: "4 000 FCFA", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80"}
    ]

    resources = [
      %{title: "Cours de mathématiques Terminale", type: "PDF • 12 pages", author: "Par M. Franck T.", downloads: "12,4K téléchargements", icon_color: "text-rose-500", bg_color: "bg-rose-50"},
      %{title: "Formules importantes en Physique", type: "PPT • 18 diapositives", author: "Par M. David P.", downloads: "8,7K téléchargements", icon_color: "text-amber-500", bg_color: "bg-amber-50"},
      %{title: "Résumé de chimie organique", type: "DOC • 15 pages", author: "Par Mme. Sarah K.", downloads: "6,1K téléchargements", icon_color: "text-blue-500", bg_color: "bg-blue-50"},
      %{title: "Épreuves de Maths TC 2024", type: "PDF • 11 pages", author: "Par Repeto", downloads: "15,2K téléchargements", icon_color: "text-emerald-500", bg_color: "bg-emerald-50"}
    ]

    trends = [
      %{title: "Épreuves TC 2024", count: "12,5K publications"},
      %{title: "Dérivées et applications", count: "8,7K publications"},
      %{title: "Révisions Bac", count: "6,3K publications"},
      %{title: "Suites numériques", count: "4,9K publications"},
      %{title: "Probabilités", count: "3,6K publications"}
    ]

    subjects = ["mathématiques", "physique", "bac", "révisions", "exercices", "terminale", "chimie", "anglais"]

    socket
    |> assign(:communities, communities)
    |> assign(:tutors, tutors)
    |> assign(:resources, resources)
    |> assign(:trends, trends)
    |> assign(:subjects, subjects)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="space-y-8 pb-12">

      <!-- En-tête de la page -->
      <div>
        <h1 class="text-xl sm:text-2xl font-black text-slate-900 tracking-tight">Explorer</h1>
        <p class="text-xs sm:text-sm text-slate-500 mt-1">Découvrez du contenu, des personnes et des communautés qui vous aideront à apprendre et à réussir.</p>
      </div>

      <!-- Filtres par catégories (Icônes de matières) -->
      <div class="flex items-center gap-3 overflow-x-auto pb-2 scrollbar-none">
        <% categories = [
          %{"id" => "tout", "label" => "Tout", "icon" => "hero-squares-2x2"},
          %{"id" => "mathematiques", "label" => "Mathématiques", "icon" => "hero-calculator"},
          %{"id" => "physique", "label" => "Physique", "icon" => "hero-bolt"},
          %{"id" => "chimie", "label" => "Chimie", "icon" => "hero-beaker"},
          %{"id" => "svt", "label" => "SVT", "icon" => "hero-globe-alt"},
          %{"id" => "anglais", "label" => "Anglais", "icon" => "hero-language"},
          %{"id" => "economie", "label" => "Économie", "icon" => "hero-chart-bar"},
          %{"id" => "plus", "label" => "Plus", "icon" => "hero-ellipsis-horizontal"}
        ] %>

        <%= for cat <- categories do %>
          <button
            phx-click="filter_category"
            phx-value-category={cat["id"]}
            class={[
              "flex flex-col items-center justify-center gap-2 p-3.5 rounded-2xl min-w-[88px] transition-all cursor-pointer border shrink-0 font-semibold text-xs",
              @selected_category == cat["id"]
                && "bg-indigo-600 text-white border-indigo-600 shadow-md shadow-indigo-200"
                || "bg-white text-slate-600 border-slate-200/80 hover:bg-slate-50"
            ]}
          >
            <.icon name={cat["icon"]} class="w-6 h-6" />
            <span>{cat["label"]}</span>
          </button>
        <% end %>
      </div>

      <!-- Grille Principale (2 colonnes : Contenu central + Sidebar droite) -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

        <!-- COLONNE GAUCHE & CENTRE (2/3) -->
        <div class="lg:col-span-2 space-y-10">

          <!-- COMMUNAUTÉS POPULAIRES -->
          <section class="space-y-4 relative">
            <div class="flex items-center justify-between">
              <h2 class="font-extrabold text-sm sm:text-base text-slate-900">Communautés populaires</h2>
              <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
            </div>

            <div class="relative">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <%= for comm <- @communities do %>
                  <div class="bg-white border border-slate-200/80 rounded-2xl overflow-hidden shadow-xs hover:shadow-md transition-all flex flex-col justify-between">
                    <div class="relative h-28 overflow-hidden">
                      <img src={comm.image} class="w-full h-full object-cover" />
                      <div class="absolute inset-0 bg-gradient-to-t from-slate-900/60 to-transparent"></div>
                      <div class="absolute bottom-3 left-3 flex items-center gap-2 text-white">
                        <div class="w-8 h-8 rounded-xl bg-white/20 backdrop-blur-md flex items-center justify-center font-bold">
                          <.icon name="hero-user-group" class="w-4 h-4 text-white" />
                        </div>
                        <div>
                          <h3 class="font-bold text-xs leading-tight">{comm.name}</h3>
                          <p class="text-[10px] text-slate-200">{comm.members}</p>
                        </div>
                      </div>
                    </div>

                    <div class="p-4 space-y-3 flex-1 flex flex-col justify-between">
                      <p class="text-xs text-slate-600 leading-relaxed">{comm.desc}</p>
                      <button class="w-full py-2 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold text-xs rounded-xl transition-colors text-center cursor-pointer">
                        Rejoindre
                      </button>
                    </div>
                  </div>
                <% end %>
              </div>

              <button class="absolute -right-4 top-1/2 -translate-y-1/2 w-9 h-9 bg-white border border-slate-200 shadow-md rounded-full flex items-center justify-center text-slate-600 hover:bg-slate-50 transition-all z-10 cursor-pointer hidden sm:flex">
                <.icon name="hero-chevron-right" class="w-4 h-4" />
              </button>
            </div>
          </section>

          <!-- RÉPÉTITEURS POPULAIRES -->
          <section class="space-y-4 relative">
            <div class="flex items-center justify-between">
              <h2 class="font-extrabold text-sm sm:text-base text-slate-900">Répétiteurs populaires</h2>
              <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
            </div>

            <div class="relative">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <%= for tutor <- @tutors do %>
                  <div class="bg-white border border-slate-200/80 rounded-2xl p-4 shadow-xs hover:shadow-md transition-all space-y-4 flex flex-col justify-between">
                    <div class="flex items-start justify-between">
                      <div class="flex items-center gap-3">
                        <img src={tutor.avatar} class="w-12 h-12 rounded-full object-cover ring-2 ring-indigo-500/20" />
                        <div>
                          <div class="flex items-center gap-1">
                            <h3 class="font-bold text-xs text-slate-900">{tutor.name}</h3>
                            <.icon name="hero-check-badge" class="w-4 h-4 text-indigo-600" />
                          </div>
                          <p class="text-[11px] text-slate-500">{tutor.role}</p>
                          <div class="flex items-center gap-1 text-xs text-amber-500 font-bold mt-0.5">
                            ★ {tutor.rating} <span class="text-slate-400 font-normal">({tutor.reviews})</span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="flex items-center justify-between text-[11px] text-slate-500 border-t border-slate-100 pt-3">
                      <span class="flex items-center gap-1">
                        <.icon name="hero-map-pin" class="w-3.5 h-3.5 text-slate-400" />
                        {tutor.city}
                      </span>
                      <span class="font-extrabold text-indigo-600 text-xs">{tutor.price} <span class="text-[10px] text-slate-400 font-normal">/ heure</span></span>
                    </div>

                    <button class="w-full py-2 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold text-xs rounded-xl transition-colors cursor-pointer">
                      Voir le profil
                    </button>
                  </div>
                <% end %>
              </div>

              <button class="absolute -right-4 top-1/2 -translate-y-1/2 w-9 h-9 bg-white border border-slate-200 shadow-md rounded-full flex items-center justify-center text-slate-600 hover:bg-slate-50 transition-all z-10 cursor-pointer hidden sm:flex">
                <.icon name="hero-chevron-right" class="w-4 h-4" />
              </button>
            </div>
          </section>

          <!-- RESSOURCES POPULAIRES -->
          <section class="space-y-4 relative">
            <div class="flex items-center justify-between">
              <h2 class="font-extrabold text-sm sm:text-base text-slate-900">Ressources populaires</h2>
              <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
            </div>

            <div class="relative">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <%= for res <- @resources do %>
                  <div class="bg-white border border-slate-200/80 rounded-2xl p-4 shadow-xs hover:shadow-md transition-all space-y-4 flex flex-col justify-between">
                    <div class="flex items-start gap-3">
                      <div class={"w-10 h-10 #{res.bg_color} #{res.icon_color} rounded-xl flex items-center justify-center shrink-0 font-bold text-xs"}>
                        <.icon name="hero-document-text" class="w-5 h-5" />
                      </div>
                      <div class="space-y-1">
                        <h3 class="font-bold text-xs text-slate-900 leading-snug">{res.title}</h3>
                        <p class="text-[10px] font-semibold text-indigo-600">{res.type}</p>
                        <p class="text-[11px] text-slate-500">{res.author}</p>
                      </div>
                    </div>

                    <div class="flex items-center justify-between border-t border-slate-100 pt-3 text-[11px] text-slate-400">
                      <span class="flex items-center gap-1">
                        <.icon name="hero-arrow-down-tray" class="w-3.5 h-3.5" />
                        {res.downloads}
                      </span>
                    </div>
                  </div>
                <% end %>
              </div>

              <button class="absolute -right-4 top-1/2 -translate-y-1/2 w-9 h-9 bg-white border border-slate-200 shadow-md rounded-full flex items-center justify-center text-slate-600 hover:bg-slate-50 transition-all z-10 cursor-pointer hidden sm:flex">
                <.icon name="hero-chevron-right" class="w-4 h-4" />
              </button>
            </div>
          </section>

        </div>

        <!-- COLONNE DROITE / SIDEBAR SECONDAIRE (1/3) -->
        <div class="lg:sticky lg:top-8 space-y-6">

          <!-- TENDANCES -->
          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <h3 class="font-extrabold text-xs text-slate-900">Tendances</h3>

            <div class="space-y-3">
              <%= for {trend, index} <- Enum.with_index(@trends, 1) do %>
                <div class="flex items-center justify-between">
                  <div class="flex items-center gap-3">
                    <span class="w-5 h-5 rounded-full bg-slate-100 text-slate-600 text-[10px] font-bold flex items-center justify-center">{index}</span>
                    <div>
                      <p class="font-bold text-xs text-slate-800 leading-none">{trend.title}</p>
                      <p class="text-[10px] text-slate-400 mt-1">{trend.count}</p>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>

            <a href="#" class="block text-center text-xs font-bold text-indigo-600 hover:underline pt-2 border-t border-slate-100">
              Voir toutes les tendances →
            </a>
          </div>

          <!-- SUJETS POPULAIRES -->
          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <h3 class="font-extrabold text-xs text-slate-900">Sujets populaires</h3>

            <div class="flex flex-wrap gap-1.5">
              <%= for subject <- @subjects do %>
                <span class="px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-xs font-medium transition-colors cursor-pointer">
                  #{subject}
                </span>
              <% end %>
            </div>

            <a href="#" class="block text-center text-xs font-bold text-indigo-600 hover:underline pt-2 border-t border-slate-100">
              Voir plus de sujets →
            </a>
          </div>

          <!-- PERSONNES À SUIVRE -->
          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <h3 class="font-extrabold text-xs text-slate-900">Personnes à suivre</h3>

            <div class="space-y-3">
              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                  <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100" class="w-9 h-9 rounded-full object-cover" />
                  <div>
                    <p class="font-bold text-xs text-slate-800 leading-none">M. Franck T.</p>
                    <p class="text-[10px] text-slate-400 mt-0.5">Répétiteur en Mathématiques</p>
                  </div>
                </div>
                <button class="px-3 py-1 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold text-xs rounded-xl transition-colors cursor-pointer">
                  Suivre
                </button>
              </div>

              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                  <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100" class="w-9 h-9 rounded-full object-cover" />
                  <div>
                    <p class="font-bold text-xs text-slate-800 leading-none">Mme. Sarah K.</p>
                    <p class="text-[10px] text-slate-400 mt-0.5">Répétitrice en Mathématiques</p>
                  </div>
                </div>
                <button class="px-3 py-1 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold text-xs rounded-xl transition-colors cursor-pointer">
                  Suivre
                </button>
              </div>

              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                  <div class="w-9 h-9 bg-indigo-600 text-white rounded-full flex items-center justify-center font-bold text-xs">R</div>
                  <div>
                    <p class="font-bold text-xs text-slate-800 leading-none">Repeto Officiel</p>
                    <p class="text-[10px] text-slate-400 mt-0.5">Actualités & conseils</p>
                  </div>
                </div>
                <button class="px-3 py-1 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold text-xs rounded-xl transition-colors cursor-pointer">
                  Suivre
                </button>
              </div>
            </div>

            <a href="#" class="block text-center text-xs font-bold text-indigo-600 hover:underline pt-2 border-t border-slate-100">
              Voir toutes les recommandations →
            </a>
          </div>

          <!-- BANNIÈRE DEVENIR RÉPÉTITEUR -->
          <div class="bg-gradient-to-br from-indigo-50 to-purple-50 border border-indigo-100 rounded-2xl p-5 space-y-4 relative overflow-hidden">
            <div>
              <h4 class="font-black text-xs text-indigo-900">Vous êtes répétiteur ?</h4>
              <p class="text-[11px] text-slate-600 mt-1 leading-relaxed">Développez votre activité, trouvez plus d'élèves et gagnez en visibilité.</p>
            </div>
            <button class="w-full py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs rounded-xl transition-colors shadow-sm cursor-pointer">
              Créer mon profil
            </button>
          </div>

        </div>

      </div>
    </div>
    </Layouts.app>
    """
  end
end
