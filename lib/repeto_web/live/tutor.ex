defmodule RepetoWeb.TutorLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, "trouver un répétiteur")
      |> assign(:search_query, "")
      |> assign(:filters, default_filters())
      |> assign(:sort_by, "pertinence")
      |> assign(:tutors, list_tutors())

    {:ok, socket}
  end

  @impl true
  def handle_event("update_filter", %{"field" => field, "value" => value}, socket) do
    filters = Map.put(socket.assigns.filters, String.to_existing_atom(field), value)
    {:noreply, assign(socket, :filters, filters)}
  end

  @impl true
  def handle_event("set_sort", %{"sort" => sort}, socket) do
    {:noreply, assign(socket, :sort_by, sort)}
  end

  @impl true
  def handle_event("select_filter_tag", %{"tag" => _tag}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"query" => query}, socket) do
    {:noreply, assign(socket, :search_query, query)}
  end

  defp default_filters do
    %{
      subject: "Toutes les matières",
      level: "Tous les niveaux",
      type: "Tous les types",
      location: "Douala, Cameroun"
    }
  end

  defp list_tutors do
    [
      %{
        id: 1,
        name: "M. Franck T.",
        title: "Répétiteur en Mathématiques & Physique",
        rating: 4.8,
        reviews_count: 87,
        students_count: 320,
        subjects: ["Mathématiques", "Physique", "Chimie"],
        experience: "5 ans d'expérience",
        location: "Douala, Akwa",
        distance: "À 8 km de vous",
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80",
        price: "50 000 FCFA",
        period: "mois",
        availability: "Disponible aujourd'hui",
        modes: ["Cours à domicile", "En ligne"]
      },
      %{
        id: 2,
        name: "Mme. Sarah K.",
        title: "Répétitrice en Anglais & Français",
        rating: 4.9,
        reviews_count: 64,
        students_count: 210,
        subjects: ["Anglais", "Français", "Littérature"],
        experience: "4 ans d'expérience",
        location: "Douala, Bonapriso",
        distance: "À 5 km de vous",
        avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80",
        price: "25 000 FCFA",
        period: "mois",
        availability: "Disponible demain",
        modes: ["Cours à domicile", "En ligne"]
      },
      %{
        id: 3,
        name: "M. David P.",
        title: "Répétiteur en SVT & Biologie",
        rating: 4.7,
        reviews_count: 51,
        students_count: 180,
        subjects: ["SVT", "Biologie", "Sciences"],
        experience: "3 ans d'expérience",
        location: "Douala, Logpom",
        distance: "À 10 km de vous",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80",
        price: "75 000 FCFA",
        period: "mois",
        availability: "Disponible aujourd'hui",
        modes: ["Cours à domicile"]
      },
      %{
        id: 4,
        name: "Mme. Claire M.",
        title: "Répétitrice en Économie & Comptabilité",
        rating: 4.6,
        reviews_count: 38,
        students_count: 140,
        subjects: ["Économie", "Comptabilité", "Maths G."],
        experience: "3 ans d'expérience",
        location: "Douala, Deido",
        distance: "À 4 km de vous",
        avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&auto=format&fit=crop&q=80",
        price: "20 000 FCFA",
        period: "mois",
        availability: "Disponible aujourd'hui",
        modes: ["Cours à domicile"]
      }
    ]
  end

  defp top_tutors do
    [
      %{name: "M. Franck T.", subject: "Mathématiques", rating: "4.8", reviews: "87", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80"},
      %{name: "Mme. Sarah K.", subject: "Anglais", rating: "4.9", reviews: "64", avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80"},
      %{name: "M. David P.", subject: "SVT", rating: "4.7", reviews: "51", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80"}
    ]
  end

  defp features do
    [
      %{icon: "🛡️", title: "Répétiteurs vérifiés", desc: "Tous nos répétiteurs sont évalués et vérifiés manuellement."},
      %{icon: "⭐", title: "Avis authentiques", desc: "Les avis sont laissés par de vrais élèves ayant suivi des cours."},
      %{icon: "💳", title: "Paiement sécurisé", desc: "Payez vos cours en toute sécurité sur la plateforme."},
      %{icon: "📈", title: "Suivi de progression", desc: "Suivez vos progrès et améliorez vos résultats."}
    ]
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <!-- Style CSS interne pour une scrollbar fine, courte et bleue -->
      <style>
        .custom-scrollbar::-webkit-scrollbar {
          width: 5px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
          background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
          background: #c7d2fe;
          border-radius: 9999px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
          background: #818cf8;
        }
        .dark .custom-scrollbar::-webkit-scrollbar-thumb {
          background: #374151;
        }
        .dark .custom-scrollbar::-webkit-scrollbar-thumb:hover {
          background: #4b5563;
        }
      </style>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

        <!-- ================= COLONNE PRINCIPALE (GAUCHE) ================= -->
        <div class="lg:col-span-2 space-y-6">

          <!-- 1. HERO -->
          <div class="relative bg-gradient-to-r from-indigo-950 via-indigo-900 to-indigo-800 dark:from-gray-900 dark:via-indigo-950 dark:to-gray-900 rounded-2xl p-6 sm:p-8 text-white overflow-hidden shadow-sm flex items-center justify-between border border-transparent dark:border-gray-800">
            <div class="relative z-10 max-w-md">
              <h1 class="text-2xl sm:text-3xl font-extrabold tracking-tight">Trouvez le répétiteur idéal</h1>
              <p class="text-indigo-200 dark:text-gray-300 text-sm mt-2">Des milliers de répétiteurs qualifiés pour vous aider à réussir.</p>
            </div>
            <div class="hidden sm:flex items-center justify-center relative z-10">
              <div class="relative w-48 h-32 flex items-end justify-center">
                <div class="absolute bottom-0 w-36 h-24 bg-indigo-800/60 dark:bg-gray-800/80 rounded-xl border border-indigo-700/50 dark:border-gray-700 p-2 shadow-inner flex flex-col justify-between">
                  <div class="flex items-center gap-1.5">
                    <div class="w-2 h-2 rounded-full bg-red-400"></div>
                    <div class="w-2 h-2 rounded-full bg-yellow-400"></div>
                    <div class="w-2 h-2 rounded-full bg-emerald-400"></div>
                  </div>
                  <div class="space-y-1">
                    <div class="w-16 h-1.5 bg-indigo-600/60 dark:bg-gray-700 rounded-full"></div>
                    <div class="w-10 h-1.5 bg-indigo-600/40 dark:bg-gray-700/60 rounded-full"></div>
                  </div>
                </div>
                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80" alt="Illustration Répétiteur" class="absolute -top-2 right-4 w-16 h-16 rounded-full object-cover border-2 border-indigo-400 dark:border-indigo-500 shadow-md" />
              </div>
            </div>
          </div>

          <!-- 2. BARRE DE FILTRES -->
          <div class="bg-white dark:bg-gray-900 rounded-2xl p-5 shadow-sm border border-gray-100 dark:border-gray-800 space-y-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
              <div>
                <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Matière</label>
                <select name="subject" phx-change="update_filter" phx-value-field="subject" class="w-full bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl px-3 py-2 text-sm text-gray-800 dark:text-gray-200 focus:ring-2 focus:ring-indigo-500">
                  <option selected={@filters.subject == "Toutes les matières"}>Toutes les matières</option>
                  <option selected={@filters.subject == "Mathématiques"}>Mathématiques</option>
                  <option selected={@filters.subject == "Physique"}>Physique</option>
                  <option selected={@filters.subject == "Anglais"}>Anglais</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Niveau scolaire</label>
                <select name="level" phx-change="update_filter" phx-value-field="level" class="w-full bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl px-3 py-2 text-sm text-gray-800 dark:text-gray-200 focus:ring-2 focus:ring-indigo-500">
                  <option selected={@filters.level == "Tous les niveaux"}>Tous les niveaux</option>
                  <option selected={@filters.level == "Terminale"}>Terminale</option>
                  <option selected={@filters.level == "Première"}>Première</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Type de cours</label>
                <select name="type" phx-change="update_filter" phx-value-field="type" class="w-full bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl px-3 py-2 text-sm text-gray-800 dark:text-gray-200 focus:ring-2 focus:ring-indigo-500">
                  <option selected={@filters.type == "Tous les types"}>Tous les types</option>
                  <option selected={@filters.type == "À domicile"}>À domicile</option>
                  <option selected={@filters.type == "En ligne"}>En ligne</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Localisation</label>
                <select name="location" phx-change="update_filter" phx-value-field="location" class="w-full bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl px-3 py-2 text-sm text-gray-800 dark:text-gray-200 focus:ring-2 focus:ring-indigo-500">
                  <option selected={@filters.location == "Douala, Cameroun"}>Douala, Cameroun</option>
                  <option selected={@filters.location == "Yaoundé, Cameroun"}>Yaoundé, Cameroun</option>
                </select>
              </div>
            </div>

            <div class="flex flex-wrap items-center justify-between pt-2 border-t border-gray-100 dark:border-gray-800 gap-2">
              <div class="flex flex-wrap items-center gap-2">
                <button phx-click="select_filter_tag" phx-value-tag="domicile" class="px-3 py-1.5 bg-indigo-50 dark:bg-indigo-950/60 text-indigo-700 dark:text-indigo-300 text-xs font-medium rounded-lg hover:bg-indigo-100 dark:hover:bg-indigo-900 transition flex items-center gap-1.5">
                  🏠 Cours à domicile
                </button>
                <button phx-click="select_filter_tag" phx-value-tag="enligne" class="px-3 py-1.5 bg-gray-50 dark:bg-gray-800 text-gray-700 dark:text-gray-300 text-xs font-medium rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition flex items-center gap-1.5">
                  💻 Cours en ligne
                </button>
                <button phx-click="select_filter_tag" phx-value-tag="dispo" class="px-3 py-1.5 bg-gray-50 dark:bg-gray-800 text-gray-700 dark:text-gray-300 text-xs font-medium rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition flex items-center gap-1.5">
                  🟢 Disponibles maintenant
                </button>
                <button phx-click="select_filter_tag" phx-value-tag="plus" class="px-3 py-1.5 bg-gray-50 dark:bg-gray-800 text-gray-700 dark:text-gray-300 text-xs font-medium rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition flex items-center gap-1.5">
                  ⚙️ Plus de filtres
                </button>
              </div>
              <button class="w-full sm:w-auto px-5 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-medium text-sm rounded-xl transition shadow-sm">
                Rechercher
              </button>
            </div>
          </div>

          <!-- 3. BARRE DE RÉSULTATS -->
          <div class="flex flex-col sm:flex-row sm:items-center justify-between text-sm text-gray-500 dark:text-gray-400 px-1 gap-3">
            <span class="font-semibold text-gray-900 dark:text-white">1 248 répétiteurs trouvés</span>
            <div class="flex flex-wrap items-center justify-between sm:justify-end gap-4">
              <div class="flex items-center gap-2">
                <span>Trier par :</span>
                <select name="sort" phx-change="set_sort" phx-value-sort={@sort_by} class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg px-3 py-1 text-xs text-gray-800 dark:text-gray-200 font-medium shadow-sm">
                  <option value="pertinence" selected={@sort_by == "pertinence"}>Pertinence</option>
                  <option value="note" selected={@sort_by == "note"}>Note croissante</option>
                  <option value="prix" selected={@sort_by == "prix"}>Prix croissant</option>
                </select>
              </div>
              <div class="flex items-center bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-0.5 shadow-sm gap-1">
                <button class="p-1 rounded bg-indigo-50 dark:bg-indigo-950 text-indigo-600 dark:text-indigo-400">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                </button>
                <button class="p-1 rounded text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                </button>
              </div>
            </div>
          </div>

          <!-- 4. LISTE DES CARTES DE RÉPÉTITEURS -->
          <div class="space-y-4">
            <%= for tutor <- @tutors do %>
              <div class="bg-white dark:bg-gray-900 rounded-2xl p-5 shadow-sm border border-gray-100 dark:border-gray-800 hover:shadow-md transition flex flex-col sm:flex-row items-start sm:items-center justify-between gap-6 relative">

                <!-- Bouton Favori -->
                <button class="absolute top-4 right-4 sm:static text-gray-300 dark:text-gray-700 hover:text-red-500 dark:hover:text-red-400 transition">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
                </button>

                <div class="flex items-start space-x-4 flex-1 w-full">
                  <div class="relative w-20 h-20 rounded-2xl bg-gray-100 dark:bg-gray-800 flex-shrink-0 overflow-hidden shadow-inner">
                    <img src={tutor.avatar} alt={tutor.name} class="w-full h-full object-cover" />
                    <span class="absolute bottom-1 right-1 w-3.5 h-3.5 bg-emerald-500 border-2 border-white dark:border-gray-900 rounded-full"></span>
                  </div>

                  <div class="flex-1 min-w-0">
                    <div class="flex items-center gap-1.5">
                      <h3 class="font-bold text-gray-900 dark:text-white text-base"><%= tutor.name %></h3>
                      <svg class="w-4 h-4 text-indigo-600 dark:text-indigo-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.25a.75.75 0 00-1.14-.976l-3.379 3.94-1.728-1.728a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.14-.094l4-4.5z" clip-rule="evenodd"/></svg>
                    </div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5"><%= tutor.title %></p>

                    <div class="flex items-center gap-3 mt-2 text-xs">
                      <span class="flex items-center font-bold text-amber-500 gap-1">⭐ <%= tutor.rating %> <span class="text-gray-400 dark:text-gray-500 font-normal">(<%= tutor.reviews_count %> avis)</span></span>
                      <span class="text-gray-300 dark:text-gray-700">•</span>
                      <span class="text-gray-600 dark:text-gray-300">👥 <%= tutor.students_count %> élèves accompagnés</span>
                    </div>

                    <div class="flex flex-wrap gap-1.5 mt-3">
                      <%= for subject <- tutor.subjects do %>
                        <span class="px-2.5 py-0.5 bg-indigo-50 dark:bg-indigo-950/60 text-indigo-700 dark:text-indigo-300 text-xs font-medium rounded-full"><%= subject %></span>
                      <% end %>
                    </div>

                    <div class="flex flex-wrap items-center gap-4 mt-3 text-[11px] text-gray-500 dark:text-gray-400">
                      <span>💼 <%= tutor.experience %></span>
                      <span>📍 <%= tutor.location %></span>
                      <span>🚗 <%= tutor.distance %></span>
                    </div>
                  </div>
                </div>

                <div class="flex flex-row sm:flex-col items-center sm:items-end justify-between w-full sm:w-auto pt-4 sm:pt-0 border-t sm:border-t-0 border-gray-100 dark:border-gray-800 gap-3">
                  <div class="flex sm:flex-col items-center sm:items-end gap-2 sm:gap-0">
                    <div class="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400 sm:mb-1">
                      <%= for mode <- tutor.modes do %>
                        <span><%= mode %></span>
                      <% end %>
                    </div>
                    <!-- PRIX MENSUEL ADAPTÉ AU CAMEROUN -->
                    <p class="text-lg font-bold text-gray-950 dark:text-white"><%= tutor.price %> <span class="text-xs font-normal text-gray-500 dark:text-gray-400">/ <%= tutor.period %></span></p>
                    <p class="text-xs font-medium text-emerald-600 dark:text-emerald-400 mt-0.5"><%= tutor.availability %></p>
                  </div>
                  <button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-semibold rounded-xl transition shadow-sm">
                    Voir le profil
                  </button>
                </div>

              </div>
            <% end %>
          </div>

        </div>

        <!-- ================= COLONNE SECONDAIRE (DROITE) ================= -->
        <div class="lg:sticky lg:top-6 space-y-6">
          <div class="lg:max-h-[550px] lg:overflow-y-auto pr-2 space-y-6 custom-scrollbar">

            <!-- BLOC 1 : Assistant AI -->
            <div class="bg-gradient-to-br from-indigo-900 to-indigo-950 dark:from-gray-900 dark:to-gray-950 text-white rounded-2xl p-5 shadow-sm relative overflow-hidden border border-transparent dark:border-gray-800">
              <div class="relative z-10 max-w-[200px]">
                <h3 class="font-bold text-base mb-1">Besoin d'aide ?</h3>
                <p class="text-xs text-indigo-200 dark:text-gray-300 mb-4 leading-relaxed">Parlez à notre assistant Repeto AI et trouvez le répétiteur idéal en quelques secondes.</p>
                <button class="w-full py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-medium text-xs rounded-xl transition shadow-md">
                  Discuter avec Repeto AI
                </button>
              </div>
              <div class="absolute right-2 bottom-2 text-4xl opacity-90">🤖</div>
            </div>

            <!-- BLOC 2 : Top répétiteurs -->
            <div class="bg-white dark:bg-gray-900 rounded-2xl p-5 shadow-sm border border-gray-100 dark:border-gray-800">
              <div class="flex items-center justify-between mb-4">
                <h3 class="font-bold text-gray-900 dark:text-white text-base">Top répétiteurs</h3>
                <a href="#" class="text-xs font-semibold text-indigo-600 dark:text-indigo-400 hover:text-indigo-800 dark:hover:text-indigo-300">Voir tout</a>
              </div>
              <div class="space-y-3">
                <%= for {t, idx} <- Enum.with_index(top_tutors(), 1) do %>
                  <div class="flex items-center justify-between py-1">
                    <div class="flex items-center space-x-3">
                      <span class="text-xs font-bold text-gray-400 dark:text-gray-600 w-4"><%= idx %></span>
                      <img src={t.avatar} alt={t.name} class="w-10 h-10 rounded-full object-cover border dark:border-gray-700" />
                      <div>
                        <p class="text-xs font-semibold text-gray-900 dark:text-white"><%= t.name %></p>
                        <p class="text-[11px] text-gray-500 dark:text-gray-400"><%= t.subject %></p>
                      </div>
                    </div>
                    <div class="text-right">
                      <p class="text-xs font-bold text-amber-500">⭐ <%= t.rating %></p>
                      <p class="text-[10px] text-gray-400 dark:text-gray-500">(<%= t.reviews %> avis)</p>
                    </div>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- BLOC 3 : Pourquoi choisir Repeto -->
            <div class="bg-white dark:bg-gray-900 rounded-2xl p-5 shadow-sm border border-gray-100 dark:border-gray-800 space-y-4">
              <h3 class="font-bold text-gray-900 dark:text-white text-base">Pourquoi choisir Repeto ?</h3>
              <div class="space-y-3 text-xs">
                <%= for f <- features() do %>
                  <div class="flex items-start space-x-3">
                    <div class="w-8 h-8 rounded-lg bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 flex items-center justify-center flex-shrink-0"><%= f.icon %></div>
                    <div>
                      <p class="font-semibold text-gray-900 dark:text-white"><%= f.title %></p>
                      <p class="text-gray-500 dark:text-gray-400 text-[11px]"><%= f.desc %></p>
                    </div>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- Carte Devenir Répétiteur -->
            <div class="bg-indigo-50/60 dark:bg-gray-800/50 border border-indigo-100 dark:border-gray-800 rounded-2xl p-5">
              <div class="flex items-center space-x-3 mb-3">
                <div class="w-10 h-10 rounded-xl bg-indigo-600 text-white flex items-center justify-center font-bold">🎓</div>
                <div>
                  <h4 class="font-bold text-gray-900 dark:text-white text-sm">Vous êtes répétiteur ?</h4>
                  <p class="text-[11px] text-gray-500 dark:text-gray-400">Rejoignez Repeto et développez votre activité dès aujourd'hui.</p>
                </div>
              </div>
              <a href="#" class="block text-center w-full py-2 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-semibold rounded-xl transition shadow-sm">
                Créer mon profil →
              </a>
            </div>

          </div>
        </div>

      </div>
    </Layouts.app>
    """
  end
end
