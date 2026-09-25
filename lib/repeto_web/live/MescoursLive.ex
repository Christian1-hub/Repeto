defmodule RepetoWeb.MesCoursLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_tab, "tous")
      |> assign(:search_query, "")
      |> assign(:active_nav, "cours")
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
  def handle_event("search", %{"query" => query}, socket) do
    {:noreply, assign(socket, :search_query, query)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <!-- Conteneur global en plein écran flex sans scrollbar globale -->
      <div class="flex-1 flex overflow-hidden h-[calc(100vh-4rem)] bg-gray-50 dark:bg-gray-950">

        <!-- Contenu Central (Scrollable sans barre visible) -->
        <main class="flex-1 p-4 sm:p-6 overflow-y-auto space-y-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- En-tête de la page Mes cours -->
          <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-white dark:bg-gray-900 p-6 rounded-2xl border border-slate-200/80 dark:border-gray-800 shadow-2xs">
            <div class="flex items-start gap-4">
              <div class="w-12 h-12 bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 rounded-2xl flex items-center justify-center shrink-0">
                <.icon name="hero-book-open" class="w-6 h-6" />
              </div>
              <div>
                <h1 class="text-xl font-black text-slate-900 dark:text-white">Mes cours</h1>
                <p class="text-xs text-slate-500 dark:text-gray-400 mt-0.5">Retrouvez tous vos cours, suivez votre progression et continuez à apprendre.</p>
              </div>
            </div>

            <!-- Barre de recherche spécifique aux cours -->
            <div class="relative w-full md:w-72">
              <.icon name="hero-magnifying-glass" class="w-4 h-4 text-slate-400 dark:text-gray-500 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                type="text"
                placeholder="Rechercher dans mes cours..."
                class="w-full bg-slate-50 dark:bg-gray-800 border border-slate-200 dark:border-gray-700 rounded-xl pl-10 pr-4 py-2 text-xs text-slate-700 dark:text-gray-200 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 dark:focus:border-indigo-500 transition-all placeholder:text-slate-400 dark:placeholder:text-gray-500"
              />
            </div>
          </div>

          <!-- Onglets de filtrage et Tri -->
          <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200 dark:border-gray-800 pb-3">
            <div class="flex items-center gap-2 overflow-x-auto [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
              <.tab_button label="Tous mes cours" count="6" active={@active_tab == "tous"} tab="tous" />
              <.tab_button label="En cours" count="3" active={@active_tab == "en_cours"} tab="en_cours" />
              <.tab_button label="Terminés" count="1" active={@active_tab == "termines"} tab="termines" />
              <.tab_button label="Favoris" count="2" active={@active_tab == "favoris"} tab="favoris" />
            </div>

            <div class="flex items-center gap-2 text-xs text-slate-500 dark:text-gray-400 self-end sm:self-auto">
              <span>Trier par :</span>
              <button class="font-bold text-slate-800 dark:text-gray-200 bg-white dark:bg-gray-900 border border-slate-200 dark:border-gray-700 px-3 py-1.5 rounded-xl shadow-2xs flex items-center gap-1 cursor-pointer">
                <span>Plus récents</span>
                <.icon name="hero-chevron-down" class="w-3.5 h-3.5 text-slate-400" />
              </button>
            </div>
          </div>

          <!-- Grille des Cours -->
          <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">

            <!-- Carte 1 -->
            <.course_card
              title="Les dérivées : cours complet"
              category="Mathématiques"
              category_bg="bg-indigo-600"
              bg_image="bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-indigo-900 via-slate-900 to-indigo-950"
              formula="f'(x) = \lim_{h \to 0} \frac{f(x+h) - f(x)}{h}"
              author="M. Franck T."
              details="Terminale C • 4 chapitres • 12 leçons"
              progress={60}
              duration="12h 45min"
              date="Ajouté le 10 mars 2025"
              button_label="Continuer le cours"
            />

            <!-- Carte 2 -->
            <.course_card
              title="Mécanique : principes fondamentaux"
              category="Physique"
              category_bg="bg-sky-500"
              bg_image="bg-gradient-to-br from-slate-800 via-slate-700 to-slate-900"
              formula="\sum \vec{F} = m \vec{a}"
              author="Mme. Sarah K."
              details="Terminale C • 5 chapitres • 15 leçons"
              progress={32}
              duration="8h 20min"
              date="Ajouté le 8 mars 2025"
              button_label="Continuer le cours"
            />

            <!-- Carte 3 -->
            <.course_card
              title="Chimie organique : les bases"
              category="Chimie"
              category_bg="bg-emerald-600"
              bg_image="bg-gradient-to-br from-cyan-900 via-blue-950 to-slate-900"
              formula="R-OH + R'-COOH \rightleftharpoons R'-COO-R + H_2O"
              author="M. David N."
              details="Terminale C • 6 chapitres • 18 leçons"
              progress={0}
              duration="0h 00min"
              date="Ajouté le 8 mars 2025"
              button_label="Commencer le cours"
            />

            <!-- Carte 4 -->
            <.course_card
              title="Fonctions : étude et représentations"
              category="Mathématiques"
              category_bg="bg-indigo-600"
              bg_image="bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-indigo-950 via-slate-900 to-indigo-900"
              formula="f(x) = ax^2 + bx + c"
              author="M. Franck T."
              details="Terminale C • 4 chapitres • 14 leçons"
              progress={85}
              duration="10h 30min"
              date="Ajouté le 28 fév. 2025"
              button_label="Continuer le cours"
            />

            <!-- Carte 5 -->
            <.course_card
              title="Chimie générale : notions essentielles"
              category="Chimie"
              category_bg="bg-emerald-600"
              bg_image="bg-gradient-to-br from-emerald-950 via-slate-900 to-teal-950"
              formula="pH = -\log[H_3O^+]"
              author="Mme. Lina M."
              details="Terminale C • 5 chapitres • 16 leçons"
              progress={45}
              duration="7h 15min"
              date="Ajouté le 25 fév. 2025"
              button_label="Continuer le cours"
            />

            <!-- Carte 6 -->
            <.course_card
              title="Python : bases et logique de programmation"
              category="Informatique"
              category_bg="bg-amber-600"
              bg_image="bg-gradient-to-br from-amber-950 via-slate-900 to-slate-950"
              formula="def fib(n): return n if n < 2 else fib(n-1) + fib(n-2)"
              author="M. David N."
              details="DUT • 6 chapitres • 20 leçons"
              progress={20}
              duration="6h 40min"
              date="Ajouté le 20 fév. 2025"
              button_label="Continuer le cours"
            />

          </div>

        </main>

        <!-- Sidebar Droite : Fixe, scrollable mais sans barre visible (Masquée sur mobile/tablette, visible sur grands écrans xl+) -->
        <aside class="w-80 bg-white dark:bg-gray-900 border-l border-slate-200 dark:border-gray-800 hidden xl:flex flex-col p-5 overflow-y-auto space-y-6 shrink-0 h-full [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">

          <!-- Progression globale -->
          <div class="space-y-4">
            <h2 class="text-xs font-black uppercase tracking-wider text-slate-500 dark:text-gray-400">Ma progression globale</h2>

            <div class="bg-slate-50 dark:bg-gray-800/60 border border-slate-200/80 dark:border-gray-700/80 rounded-2xl p-4 flex items-center gap-4">
              <!-- Cercle de progression -->
              <div class="relative w-16 h-16 shrink-0 flex items-center justify-center">
                <svg class="w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                  <path class="text-slate-200 dark:text-gray-700" stroke-width="3.5" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                  <path class="text-indigo-600 dark:text-indigo-400" stroke-dasharray="42, 100" stroke-width="3.5" stroke-linecap="round" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                </svg>
                <div class="absolute inset-0 flex items-center justify-center">
                  <span class="text-sm font-black text-slate-900 dark:text-white">42%</span>
                </div>
              </div>
              <div>
                <p class="text-xs font-bold text-slate-900 dark:text-white">de mes cours complétés</p>
                <p class="text-xs text-slate-500 dark:text-gray-400 font-medium mt-0.5">3 / 7</p>
              </div>
            </div>

            <!-- Liste des matières progress -->
            <div class="space-y-3">
              <.subject_progress title="Mathématiques" progress={67} current="2" total="3" color="bg-indigo-600" />
              <.subject_progress title="Physique" progress={50} current="1" total="2" color="bg-sky-500" />
              <.subject_progress title="Chimie" progress={0} current="0" total="2" color="bg-emerald-600" />
            </div>
          </div>

          <!-- Activité récente -->
          <div class="space-y-3 pt-2">
            <h2 class="text-xs font-black uppercase tracking-wider text-slate-500 dark:text-gray-400">Activité récente</h2>

            <div class="space-y-3">
              <.activity_item
                icon="hero-book-open"
                icon_bg="bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400"
                title="Vous avez terminé une leçon de"
                subtitle="Les dérivées : cours complet"
                time="Il y a 2 heures"
              />

              <.activity_item
                icon="hero-play"
                icon_bg="bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400"
                title="Vous avez commencé"
                subtitle="Mécanique : principes fondamentaux"
                time="Il y a 4 heures"
              />

              <.activity_item
                icon="hero-bell"
                icon_bg="bg-amber-50 dark:bg-amber-950/60 text-amber-600 dark:text-amber-400"
                title="Nouveau cours disponible :"
                subtitle="Probabilités et statistiques"
                time="Il y a 1 jour"
              />

              <.activity_item
                icon="hero-academic-cap"
                icon_bg="bg-indigo-50 dark:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400"
                title="M. Franck T. a publié un nouveau cours"
                subtitle="Intégrales : méthodes et applications"
                time="Il y a 1 jour"
              />
            </div>

            <button class="text-xs font-bold text-indigo-600 dark:text-indigo-400 hover:text-indigo-700 dark:hover:text-indigo-300 flex items-center gap-1 pt-1 cursor-pointer">
              <span>Voir toute l'activité</span>
              <.icon name="hero-arrow-right" class="w-3.5 h-3.5" />
            </button>
          </div>

          <!-- Bloc Trophée / Premium Sidebar Droite -->
          <div class="bg-gradient-to-br from-indigo-600 via-indigo-700 to-indigo-900 dark:from-indigo-950 dark:via-gray-900 dark:to-indigo-900 rounded-2xl p-4 text-white space-y-3 shadow-lg shadow-indigo-200/50 dark:shadow-none border border-transparent dark:border-gray-800">
            <div class="flex items-center gap-2.5">
              <div class="w-9 h-9 bg-white/10 rounded-xl flex items-center justify-center shrink-0">
                <.icon name="hero-trophy" class="w-5 h-5 text-amber-300" />
              </div>
              <div>
                <h3 class="text-xs font-black">Débloquez tout votre potentiel</h3>
                <p class="text-[10px] text-indigo-100 dark:text-gray-300">Passez à Repeto Premium et accédez à :</p>
              </div>
            </div>

            <div class="space-y-1 text-[11px] text-indigo-100 dark:text-gray-300">
              <p class="flex items-center gap-1.5"><.icon name="hero-check" class="w-3.5 h-3.5 text-amber-300 shrink-0" /> Tous les cours premium</p>
              <p class="flex items-center gap-1.5"><.icon name="hero-check" class="w-3.5 h-3.5 text-amber-300 shrink-0" /> Vidéos en haute qualité</p>
              <p class="flex items-center gap-1.5"><.icon name="hero-check" class="w-3.5 h-3.5 text-amber-300 shrink-0" /> Certificats de réussite</p>
              <p class="flex items-center gap-1.5"><.icon name="hero-check" class="w-3.5 h-3.5 text-amber-300 shrink-0" /> Et bien plus encore !</p>
            </div>

            <button class="w-full bg-white text-indigo-900 hover:bg-indigo-50 font-bold text-xs py-2 rounded-xl shadow transition-colors cursor-pointer">
              Découvrir Premium
            </button>
          </div>

        </aside>

      </div>
    </Layouts.app>
    """
  end

  # Composant pour les onglets de filtrage
  def tab_button(assigns) do
    ~H"""
    <button
      phx-click="change_tab"
      phx-value-tab={@tab}
      class={[
        "px-4 py-2 rounded-xl font-bold text-xs transition-all flex items-center gap-2 shrink-0 cursor-pointer",
        @active
          && "bg-indigo-600 text-white shadow-md shadow-indigo-200 dark:shadow-none"
          || "bg-white dark:bg-gray-900 border border-slate-200 dark:border-gray-800 text-slate-600 dark:text-gray-400 hover:bg-slate-50 dark:hover:bg-gray-800"
      ]}
    >
      <span>{@label}</span>
      <span class={[
        "px-1.5 py-0.5 rounded-full text-[10px]",
        @active && "bg-indigo-700 text-white" || "bg-slate-100 dark:bg-gray-800 text-slate-600 dark:text-gray-400"
      ]}>{@count}</span>
    </button>
    """
  end

  # Composant pour une carte de cours
  def course_card(assigns) do
    ~H"""
    <div class="bg-white dark:bg-gray-900 border border-slate-200/80 dark:border-gray-800 rounded-2xl overflow-hidden shadow-2xs hover:shadow-md dark:hover:border-gray-700 transition-all flex flex-col justify-between group">

      <!-- En-tête de la carte avec fond graphique style tableau/formules -->
      <div class={"relative h-36 #{@bg_image} p-4 flex flex-col justify-between overflow-hidden"}>
        <!-- Effet de grille en arrière-plan -->
        <div class="absolute inset-0 opacity-20 bg-[radial-gradient(#cbd5e1_1px,transparent_1px)] dark:bg-[radial-gradient(#475569_1px,transparent_1px)] [background-size:16px_16px]"></div>

        <!-- Formules mathématiques/scientifiques en filigrane -->
        <div class="absolute inset-0 flex items-center justify-center opacity-15 font-mono text-xs text-white select-none px-2 text-center pointer-events-none">
          {@formula}
        </div>

        <div class="flex items-center justify-between relative z-10">
          <span class={"px-3 py-1 #{@category_bg} text-white font-bold text-[10px] rounded-full shadow-sm"}>
            {@category}
          </span>
          <button class="w-8 h-8 rounded-xl bg-black/30 backdrop-blur-md text-white flex items-center justify-center hover:bg-black/50 transition-colors cursor-pointer">
            <.icon name="hero-bookmark" class="w-4 h-4" />
          </button>
        </div>

        <div class="relative z-10">
          <h3 class="text-white font-black text-sm drop-shadow-sm line-clamp-1">{@title}</h3>
        </div>
      </div>

      <!-- Corps de la carte -->
      <div class="p-4 space-y-3.5 flex-1 flex flex-col justify-between">
        <div class="space-y-2">
          <!-- Auteur -->
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <div class="w-6 h-6 rounded-full bg-slate-200 dark:bg-gray-800 flex items-center justify-center font-bold text-[10px] text-slate-700 dark:text-gray-300">
                {String.at(@author, 0)}
              </div>
              <span class="text-xs font-bold text-slate-800 dark:text-gray-200">{@author}</span>
            </div>
            <.icon name="hero-check-badge" class="w-4 h-4 text-indigo-600 dark:text-indigo-400" />
          </div>

          <p class="text-[11px] text-slate-500 dark:text-gray-400 font-medium">{@details}</p>
        </div>

        <!-- Barre de progression -->
        <div class="space-y-1">
          <div class="w-full h-2 bg-slate-100 dark:bg-gray-800 rounded-full overflow-hidden">
            <div class="h-full bg-indigo-600 dark:bg-indigo-500 rounded-full transition-all" style={"width: #{@progress}%"}></div>
          </div>
          <div class="flex justify-end">
            <span class="text-[10px] font-bold text-slate-600 dark:text-gray-400">{@progress}%</span>
          </div>
        </div>

        <!-- Pied de carte : Durée, date et bouton d'action -->
        <div class="pt-3 border-t border-slate-100 dark:border-gray-800 space-y-3">
          <div class="flex items-center justify-between text-[10px] text-slate-400 dark:text-gray-500 font-medium">
            <span class="flex items-center gap-1">
              <.icon name="hero-clock" class="w-3.5 h-3.5" />
              {@duration}
            </span>
            <span>{@date}</span>
          </div>

          <button class="w-full bg-indigo-600 hover:bg-indigo-700 dark:bg-indigo-600 dark:hover:bg-indigo-500 text-white font-bold text-xs py-2.5 rounded-xl shadow-md shadow-indigo-100 dark:shadow-none transition-colors flex items-center justify-center gap-2 cursor-pointer">
            <.icon name="hero-play" class="w-4 h-4 fill-current" />
            <span>{@button_label}</span>
          </button>
        </div>

      </div>

    </div>
    """
  end

  # Composant pour la progression par matière
  def subject_progress(assigns) do
    ~H"""
    <div class="space-y-1.5">
      <div class="flex items-center justify-between text-xs">
        <span class="font-bold text-slate-800 dark:text-gray-200">{@title}</span>
        <span class="text-slate-500 dark:text-gray-400 font-medium">{@current} / {@total} <span class="text-slate-400 dark:text-gray-500 ml-1">{@progress}%</span></span>
      </div>
      <div class="w-full h-2 bg-slate-100 dark:bg-gray-800 rounded-full overflow-hidden">
        <div class={"h-full #{@color} rounded-full"} style={"width: #{@progress}%"}></div>
      </div>
    </div>
    """
  end

  # Composant pour un élément d'activité récente
  def activity_item(assigns) do
    ~H"""
    <div class="flex items-start gap-2.5">
      <div class={"w-7 h-7 #{@icon_bg} rounded-xl flex items-center justify-center shrink-0 mt-0.5"}>
        <.icon name={@icon} class="w-3.5 h-3.5" />
      </div>
      <div class="space-y-0.5">
        <p class="text-[11px] text-slate-600 dark:text-gray-400 leading-snug">
          {@title} <strong class="text-slate-900 dark:text-white font-bold">{@subtitle}</strong>
        </p>
        <p class="text-[10px] text-slate-400 dark:text-gray-500">{@time}</p>
      </div>
    </div>
    """
  end
end
