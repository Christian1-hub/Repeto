defmodule RepetoWeb.ProgressionLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, "progression")
      |> assign(:time_filter, "30j")
      |> assign(:current_scope, nil)
      |> assign(:user, %{
        name: "Christian B.",
        role: "Élève • Terminale C",
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=faces"
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("change_time_filter", %{"filter" => filter}, socket) do
    {:noreply, assign(socket, :time_filter, filter)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <!-- Conteneur global en plein écran flex sans scrollbar globale -->
      <div class="flex-1 flex overflow-hidden h-[calc(100vh-4rem)] bg-slate-50/50">

        <!-- Contenu Central (Scrollable sans barre visible) -->
        <main class="flex-1 p-6 overflow-y-auto space-y-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- En-tête de la page Progression -->
          <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-white p-6 rounded-2xl border border-slate-200/80 shadow-2xs">
            <div class="flex items-center gap-4">
              <div class="w-12 h-12 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center shrink-0">
                <.icon name="hero-chart-bar-square" class="w-6 h-6" />
              </div>
              <div>
                <h1 class="text-xl font-black text-slate-900">Ma progression</h1>
                <p class="text-xs text-slate-500 mt-0.5">Suivez vos progrès, identifiez vos points forts et améliorez ce qui compte.</p>
              </div>
            </div>
          </div>

          <!-- 4 Cartes de Statistiques Rapides -->
          <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">

            <!-- Carte 1 : Progression Globale -->
            <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs flex items-center gap-4">
              <div class="relative w-16 h-16 shrink-0 flex items-center justify-center">
                <svg class="w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                  <path class="text-slate-100" stroke-width="4" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                  <path class="text-indigo-600" stroke-dasharray="68, 100" stroke-width="4" stroke-linecap="round" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                </svg>
                <div class="absolute inset-0 flex items-center justify-center">
                  <span class="text-xs font-black text-slate-900">68%</span>
                </div>
              </div>
              <div>
                <p class="text-[11px] font-bold text-slate-400 uppercase tracking-wider">Progression globale</p>
                <p class="text-xs font-bold text-slate-900 mt-0.5">Tu es sur la bonne voie !</p>
                <p class="text-[10px] font-bold text-emerald-600 mt-1 flex items-center gap-1">
                  <.icon name="hero-arrow-trending-up" class="w-3 h-3" /> +12% cette semaine
                </p>
              </div>
            </div>

            <!-- Carte 2 : Cours complétés -->
            <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs flex flex-col justify-between space-y-3">
              <div class="flex items-center justify-between">
                <span class="text-[11px] font-bold text-slate-400 uppercase tracking-wider">Cours complétés</span>
                <div class="w-9 h-9 rounded-xl bg-indigo-50 text-indigo-600 flex items-center justify-center">
                  <.icon name="hero-book-open" class="w-4 h-4" />
                </div>
              </div>
              <div>
                <div class="flex items-baseline gap-1.5">
                  <span class="text-xl font-black text-slate-900">7</span>
                  <span class="text-xs text-slate-400 font-bold">/ 12</span>
                </div>
                <div class="w-full h-1.5 bg-slate-100 rounded-full mt-2.5 overflow-hidden">
                  <div class="h-full bg-indigo-600 rounded-full" style="width: 58%;"></div>
                </div>
              </div>
            </div>

            <!-- Carte 3 : Exercices réussis -->
            <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs flex flex-col justify-between space-y-3">
              <div class="flex items-center justify-between">
                <span class="text-[11px] font-bold text-slate-400 uppercase tracking-wider">Exercices réussis</span>
                <div class="w-9 h-9 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
                  <.icon name="hero-academic-cap" class="w-4 h-4" />
                </div>
              </div>
              <div>
                <div class="flex items-baseline gap-1.5">
                  <span class="text-xl font-black text-slate-900">18</span>
                  <span class="text-xs text-slate-400 font-bold">/ 32</span>
                </div>
                <div class="w-full h-1.5 bg-slate-100 rounded-full mt-2.5 overflow-hidden">
                  <div class="h-full bg-emerald-500 rounded-full" style="width: 56%;"></div>
                </div>
              </div>
            </div>

            <!-- Carte 4 : Quiz réussis -->
            <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs flex flex-col justify-between space-y-3">
              <div class="flex items-center justify-between">
                <span class="text-[11px] font-bold text-slate-400 uppercase tracking-wider">Quiz réussis</span>
                <div class="w-9 h-9 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center">
                  <.icon name="hero-light-bulb" class="w-4 h-4" />
                </div>
              </div>
              <div>
                <div class="flex items-baseline gap-1.5">
                  <span class="text-xl font-black text-slate-900">5</span>
                  <span class="text-xs text-slate-400 font-bold">/ 10</span>
                </div>
                <div class="w-full h-1.5 bg-slate-100 rounded-full mt-2.5 overflow-hidden">
                  <div class="h-full bg-amber-500 rounded-full" style="width: 50%;"></div>
                </div>
              </div>
            </div>

          </div>

          <!-- Section Graphique & Répartition -->
          <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">

            <!-- Évolution de la progression (Graphique) -->
            <div class="xl:col-span-2 bg-white p-6 rounded-2xl border border-slate-200/80 shadow-2xs space-y-6">
              <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <h2 class="text-sm font-black text-slate-900">Évolution de ta progression</h2>
                </div>
                <div class="flex items-center gap-1 bg-slate-100 p-1 rounded-xl text-xs font-bold text-slate-600">
                  <.time_filter_btn label="7j" active={@time_filter == "7j"} filter="7j" />
                  <.time_filter_btn label="30j" active={@time_filter == "30j"} filter="30j" />
                  <.time_filter_btn label="3 mois" active={@time_filter == "3_mois"} filter="3_mois" />
                  <.time_filter_btn label="6 mois" active={@time_filter == "6_mois"} filter="6_mois" />
                </div>
              </div>

              <!-- Zone graphique -->
              <div class="relative h-64 w-full pt-4">
                <!-- Lignes de repère horizontales -->
                <div class="absolute inset-0 flex flex-col justify-between text-[10px] text-slate-300 pointer-events-none pb-6">
                  <div class="border-b border-slate-100 w-full flex justify-between"><span>100%</span></div>
                  <div class="border-b border-slate-100 w-full flex justify-between"><span>75%</span></div>
                  <div class="border-b border-slate-100 w-full flex justify-between"><span>50%</span></div>
                  <div class="border-b border-slate-100 w-full flex justify-between"><span>25%</span></div>
                  <div class="border-b border-slate-100 w-full flex justify-between"><span>0%</span></div>
                </div>

                <!-- SVG Courbe précise -->
                <div class="absolute inset-x-0 bottom-6 top-6">
                  <svg class="w-full h-full overflow-visible" viewBox="0 0 700 160" preserveAspectRatio="none">
                    <defs>
                      <linearGradient id="chartGradient" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stop-color="#6366f1" stop-opacity="0.3" />
                        <stop offset="100%" stop-color="#6366f1" stop-opacity="0.0" />
                      </linearGradient>
                    </defs>
                    <path d="M 0,125 C 90,115 150,118 240,110 C 330,102 400,90 490,75 C 580,60 630,55 700,45 L 700,160 L 0,160 Z" fill="url(#chartGradient)" />
                    <path d="M 0,125 C 90,115 150,118 240,110 C 330,102 400,90 490,75 C 580,60 630,55 700,45" fill="none" stroke="#6366f1" stroke-width="3" stroke-linecap="round" />

                    <!-- Points -->
                    <circle cx="0" cy="125" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="87" cy="118" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="175" cy="116" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="262" cy="108" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="350" cy="98" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="437" cy="85" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="525" cy="68" r="4" class="fill-white stroke-indigo-600" stroke-width="2" />
                    <circle cx="612" cy="55" r="5" class="fill-indigo-600 stroke-white" stroke-width="2" />
                    <circle cx="700" cy="45" r="6" class="fill-indigo-600 stroke-white" stroke-width="2" />
                  </svg>

                  <!-- Popover tooltip -->
                  <div class="absolute right-0 top-2 bg-slate-900 text-white px-3 py-1.5 rounded-xl text-[11px] font-bold shadow-xl flex items-center gap-1.5">
                    <span class="w-2 h-2 rounded-full bg-indigo-400"></span>
                    <span>68% • aujourd'hui</span>
                  </div>
                </div>

                <!-- Axe X (Dates) -->
                <div class="absolute inset-x-0 bottom-0 flex justify-between text-[10px] text-slate-400 font-semibold">
                  <span>12 Avr</span>
                  <span>15 Avr</span>
                  <span>18 Avr</span>
                  <span>21 Avr</span>
                  <span>24 Avr</span>
                  <span>27 Avr</span>
                  <span>30 Avr</span>
                  <span>3 Mai</span>
                  <span>6 Mai</span>
                  <span>9 Mai</span>
                </div>
              </div>
            </div>

            <!-- Répartition par matière -->
            <div class="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-2xs flex flex-col justify-between space-y-4">
              <div class="flex items-center justify-between">
                <h2 class="text-sm font-black text-slate-900">Répartition par matière</h2>
                <.icon name="hero-chart-pie" class="w-4 h-4 text-slate-400" />
              </div>

              <!-- Cercle Donut -->
              <div class="relative w-36 h-36 mx-auto flex items-center justify-center my-1">
                <svg class="w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                  <circle cx="18" cy="18" r="15.9155" class="text-slate-100" stroke-width="4" stroke="currentColor" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-indigo-600" stroke-width="4" stroke-dasharray="42 58" stroke-dashoffset="0" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-sky-500" stroke-width="4" stroke-dasharray="18 82" stroke-dashoffset="-42" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-emerald-500" stroke-width="4" stroke-dasharray="12 88" stroke-dashoffset="-60" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-amber-500" stroke-width="4" stroke-dasharray="8 92" stroke-dashoffset="-72" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-pink-500" stroke-width="4" stroke-dasharray="6 94" stroke-dashoffset="-80" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-teal-500" stroke-width="4" stroke-dasharray="4 96" stroke-dashoffset="-86" fill="none" />
                  <circle cx="18" cy="18" r="15.9155" class="text-slate-400" stroke-width="4" stroke-dasharray="10 90" stroke-dashoffset="-90" fill="none" />
                </svg>
                <div class="absolute inset-0 flex flex-col items-center justify-center text-center">
                  <span class="text-lg font-black text-slate-900 leading-none">12</span>
                  <span class="text-[10px] text-slate-400 font-bold uppercase mt-0.5">matières</span>
                </div>
              </div>

              <!-- Légende -->
              <div class="grid grid-cols-2 gap-x-3 gap-y-1.5 text-[11px]">
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-indigo-600"></span>Mathématiques</span> <strong class="text-slate-900">42%</strong></div>
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-sky-500"></span>Physique</span> <strong class="text-slate-900">18%</strong></div>
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-emerald-500"></span>Chimie</span> <strong class="text-slate-900">12%</strong></div>
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-amber-500"></span>Français</span> <strong class="text-slate-900">8%</strong></div>
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-pink-500"></span>Anglais</span> <strong class="text-slate-900">6%</strong></div>
                <div class="flex items-center justify-between text-slate-600"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-teal-500"></span>Informatique</span> <strong class="text-slate-900">4%</strong></div>
                <div class="flex items-center justify-between text-slate-600 col-span-2 pt-1.5 border-t border-slate-100"><span class="flex items-center gap-1.5 font-medium"><span class="w-2 h-2 rounded-full bg-slate-400"></span>Autres</span> <strong class="text-slate-900">10%</strong></div>
              </div>

            </div>

          </div>

          <!-- Section Mes matières (Grille détaillée) -->
          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <h2 class="text-sm font-black text-slate-900">Mes matières</h2>
              <button class="text-xs font-bold text-indigo-600 hover:text-indigo-700 flex items-center gap-1 cursor-pointer">
                <span>Voir le détail</span>
                <.icon name="hero-arrow-right" class="w-3.5 h-3.5" />
              </button>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">

              <.subject_card
                title="Mathématiques"
                icon="hero-calculator"
                color="text-indigo-600"
                bg="bg-indigo-50"
                progress={75}
                progress_color="bg-indigo-600"
                cours_count="12 / 16 cours"
                weekly_gain="+3% cette semaine"
              />

              <.subject_card
                title="Physique"
                icon="hero-bolt"
                color="text-sky-500"
                bg="bg-sky-50"
                progress={62}
                progress_color="bg-sky-500"
                cours_count="8 / 13 cours"
                weekly_gain="+5% cette semaine"
              />

              <.subject_card
                title="Chimie"
                icon="hero-beaker"
                color="text-emerald-600"
                bg="bg-emerald-50"
                progress={48}
                progress_color="bg-emerald-500"
                cours_count="6 / 12 cours"
                weekly_gain="+2% cette semaine"
              />

              <.subject_card
                title="Français"
                icon="hero-book-open"
                color="text-rose-600"
                bg="bg-rose-50"
                progress={80}
                progress_color="bg-rose-500"
                cours_count="8 / 10 cours"
                weekly_gain="+4% cette semaine"
              />

              <.subject_card
                title="Anglais"
                icon="hero-language"
                color="text-teal-600"
                bg="bg-teal-50"
                progress={55}
                progress_color="bg-teal-500"
                cours_count="7 / 12 cours"
                weekly_gain="+1% cette semaine"
              />

            </div>
          </div>

          <!-- Section Mes derniers accomplissements -->
          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <h2 class="text-sm font-black text-slate-900">Mes derniers accomplissements</h2>
              <button class="text-xs font-bold text-indigo-600 hover:text-indigo-700 flex items-center gap-1 cursor-pointer">
                <span>Voir tous</span>
                <.icon name="hero-arrow-right" class="w-3.5 h-3.5" />
              </button>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">

              <.achievement_card
                title="Maîtrise des fonctions"
                description="Tu as complété tous les cours sur les fonctions."
                date="6 Mai 2025"
                icon="hero-trophy"
                badge_bg="bg-indigo-50 text-indigo-600"
              />

              <.achievement_card
                title="Champion des quiz"
                description="Tu as obtenu 100% au quiz sur les dérivées."
                date="4 Mai 2025"
                icon="hero-fire"
                badge_bg="bg-amber-50 text-amber-600"
              />

              <.achievement_card
                title="Assidu"
                description="7 jours consécutifs d'activité."
                date="3 Mai 2025"
                icon="hero-shield-check"
                badge_bg="bg-emerald-50 text-emerald-600"
              />

              <.achievement_card
                title="Révision efficace"
                description="Tu as étudié 3h aujourd'hui."
                date="2 Mai 2025"
                icon="hero-sparkles"
                badge_bg="bg-sky-50 text-sky-600"
              />

            </div>
          </div>

        </main>

        <!-- Sidebar Droite : Fixe et scrollable sans barre visible -->
        <aside class="w-80 bg-white border-l border-slate-200 hidden xl:flex flex-col p-5 overflow-y-auto space-y-6 shrink-0 h-full [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- Mes objectifs -->
          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <h2 class="text-xs font-black uppercase tracking-wider text-slate-500">Mes objectifs</h2>
              <button class="text-[11px] font-bold text-indigo-600 hover:text-indigo-700 cursor-pointer">Voir tout</button>
            </div>

            <div class="space-y-3">
              <.goal_item
                icon="hero-bookmark"
                title="Réviser intégrales"
                progress={70}
                details="Dans 5 jours • 8/12 cours"
              />

              <.goal_item
                icon="hero-academic-cap"
                title="Avoir 90% en mathématiques"
                progress={62}
                details="Dans 2 semaines • 12/20 exercices"
              />

              <.goal_item
                icon="hero-check-badge"
                title="Valider tous les quiz de terminale"
                progress={40}
                details="Dans 1 mois • 4/10 quiz"
              />
            </div>

            <button class="w-full bg-slate-50 hover:bg-slate-100 border border-slate-200/80 text-slate-700 font-bold text-xs py-2.5 rounded-xl transition-colors flex items-center justify-center gap-2 cursor-pointer">
              <.icon name="hero-plus" class="w-4 h-4 text-indigo-600" />
              <span>Ajouter un objectif</span>
            </button>
          </div>

          <!-- Activité récente -->
          <div class="space-y-3 pt-2">
            <div class="flex items-center justify-between">
              <h2 class="text-xs font-black uppercase tracking-wider text-slate-500">Activité récente</h2>
              <button class="text-[11px] font-bold text-indigo-600 hover:text-indigo-700 cursor-pointer">Voir tout</button>
            </div>

            <div class="space-y-3.5">
              <.activity_item
                icon="hero-book-open"
                icon_bg="bg-indigo-50 text-indigo-600"
                title="Tu as terminé le cours"
                subtitle="Les fonctions et leurs limites"
                time="Il y a 2 heures"
              />

              <.activity_item
                icon="hero-light-bulb"
                icon_bg="bg-amber-50 text-amber-600"
                title="Tu as réussi le quiz"
                subtitle="Dérivées – Niveau Moyen"
                time="Il y a 4 heures"
              />

              <.activity_item
                icon="hero-pencil-square"
                icon_bg="bg-sky-50 text-sky-600"
                title="Tu as complété l'exercice"
                subtitle="Étude d'une fonction"
                time="Il y a 6 heures"
              />

              <.activity_item
                icon="hero-question-mark-circle"
                icon_bg="bg-emerald-50 text-emerald-600"
                title="Tu as posé une question"
                subtitle="sur les intégrales"
                time="Il y a 8 heures"
              />

              <.activity_item
                icon="hero-users"
                icon_bg="bg-purple-50 text-purple-600"
                title="Tu as rejoint la communauté"
                subtitle="Mathématiques – Terminale C"
                time="Il y a 1 jour"
              />
            </div>
          </div>

        </aside>

      </div>
    </Layouts.app>
    """
  end

  def time_filter_btn(assigns) do
    ~H"""
    <button
      phx-click="change_time_filter"
      phx-value-filter={@filter}
      class={[
        "px-3 py-1.5 rounded-lg transition-all cursor-pointer",
        @active && "bg-white text-indigo-600 shadow-2xs font-black" || "text-slate-500 hover:text-slate-800"
      ]}
    >
      {@label}
    </button>
    """
  end

  def subject_card(assigns) do
    ~H"""
    <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs flex flex-col justify-between space-y-4 hover:shadow-md transition-all">
      <div class="flex items-center justify-between">
        <div class={"w-10 h-10 #{@bg} #{@color} rounded-xl flex items-center justify-center"}>
          <.icon name={@icon} class="w-5 h-5" />
        </div>
        <span class="text-[10px] font-bold text-emerald-600 bg-emerald-50 px-2 py-0.5 rounded-full">{@weekly_gain}</span>
      </div>

      <div>
        <h3 class="text-xs font-black text-slate-900">{@title}</h3>
        <p class="text-[11px] text-slate-400 font-medium mt-0.5">{@cours_count}</p>
      </div>

      <div class="space-y-1.5 pt-1">
        <div class="flex items-center justify-between text-xs">
          <span class="text-slate-500 font-medium text-[11px]">Progression</span>
          <span class="font-bold text-slate-900 text-[11px]">{@progress}%</span>
        </div>
        <div class="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
          <div class={"h-full #{@progress_color} rounded-full"} style={"width: #{@progress}%"}></div>
        </div>
      </div>
    </div>
    """
  end

  def achievement_card(assigns) do
    ~H"""
    <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-2xs space-y-3 flex flex-col justify-between">
      <div class="flex items-center justify-between">
        <div class={"w-9 h-9 #{@badge_bg} rounded-xl flex items-center justify-center"}>
          <.icon name={@icon} class="w-5 h-5" />
        </div>
        <span class="text-[10px] text-slate-400 font-medium">{@date}</span>
      </div>
      <div>
        <h3 class="text-xs font-black text-slate-900">{@title}</h3>
        <p class="text-[11px] text-slate-500 font-medium mt-1 leading-snug">{@description}</p>
      </div>
    </div>
    """
  end

  def goal_item(assigns) do
    ~H"""
    <div class="bg-slate-50 p-3.5 rounded-2xl border border-slate-200/80 space-y-2">
      <div class="flex items-center gap-2.5">
        <div class="w-7 h-7 bg-white text-indigo-600 rounded-lg shadow-2xs flex items-center justify-center shrink-0">
          <.icon name={@icon} class="w-3.5 h-3.5" />
        </div>
        <h3 class="text-xs font-bold text-slate-900 leading-tight">{@title}</h3>
      </div>
      <div class="space-y-1 pl-9">
        <div class="flex justify-between text-[10px]">
          <span class="text-slate-400 font-medium">{@details}</span>
          <span class="font-bold text-slate-800">{@progress}%</span>
        </div>
        <div class="w-full h-1.5 bg-slate-200/70 rounded-full overflow-hidden">
          <div class="h-full bg-indigo-600 rounded-full" style={"width: #{@progress}%"}></div>
        </div>
      </div>
    </div>
    """
  end

  def activity_item(assigns) do
    ~H"""
    <div class="flex items-start gap-2.5">
      <div class={"w-7 h-7 #{@icon_bg} rounded-xl flex items-center justify-center shrink-0 mt-0.5"}>
        <.icon name={@icon} class="w-3.5 h-3.5" />
      </div>
      <div class="space-y-0.5">
        <p class="text-[11px] text-slate-600 leading-snug">
          {@title} <strong class="text-slate-900 font-bold">{@subtitle}</strong>
        </p>
        <p class="text-[10px] text-slate-400">{@time}</p>
      </div>
    </div>
    """
  end
end
