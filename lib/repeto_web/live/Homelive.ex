defmodule RepetoWeb.HomeLive do
  use RepetoWeb, :live_view

  def mount(_params, _session, socket) do
    # Simulation d'un délai de 5 secondes pour tester le loader (à retirer en production)
    Process.sleep(5000)

    socket =
      assign(socket,
        active_tab: "pour_toi",
        active_nav: :accueil,
        search_query: "",
        loaded: connected?(socket)
      )

    {:ok, socket}
  end

  # Action lorsque l'utilisateur clique sur les onglets (Abonnements, Communautés, etc.)
  def handle_event("set_tab", %{"tab" => tab_id}, socket) do
    {:noreply, assign(socket, :active_tab, tab_id)}
  end

  # Gestion de la recherche en temps réel
  def handle_event("update_search", %{"search_query" => query}, socket) do
    {:noreply, assign(socket, search_query: query)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <!-- Conteneur global avec padding bas généreux pour ne pas être masqué par la nav mobile -->
      <div class="w-full max-w-[1440px] mx-auto px-3 sm:px-6 lg:px-8 pb-28 lg:pb-12">

        <!-- ÉTAT DE CHARGEMENT SIMULÉ -->
        <%= if !@loaded do %>
          <div class="flex flex-col items-center justify-center min-h-[60vh] space-y-4">
            <div class="w-12 h-12 border-4 border-indigo-600 border-t-transparent rounded-full animate-spin"></div>
            <p class="text-xs font-semibold text-slate-500 animate-pulse">Chargement de ton espace Repeto en cours...</p>
          </div>
        <% else %>

          <!-- Grille responsive : 1 colonne sur mobile, 2 colonnes sur grands écrans -->
          <div class="grid grid-cols-1 lg:grid-cols-[1fr_340px] xl:grid-cols-[1fr_380px] gap-4 sm:gap-6 items-start">

            <!-- ================= COLONNE CENTRALE (FEED) ================= -->
            <div class="space-y-4 sm:space-y-6 min-w-0 w-full">

              <!-- Carte "Que veux-tu partager aujourd'hui ?" -->
              <div class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-3 sm:p-5 shadow-xs space-y-3 sm:space-y-4">
                <div class="flex items-center gap-2 sm:gap-3">
                  <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100" class="w-9 h-9 sm:w-10 sm:h-10 rounded-full object-cover shrink-0 ring-2 ring-slate-100" />

                  <!-- FORMULAIRE DE RECHERCHE EN TEMPS RÉEL -->
                  <div class="w-full relative">
                    <.form for={%{}} phx-change="update_search">
                      <input
                        type="text"
                        name="search_query"
                        value={@search_query}
                        placeholder="Que veux-tu partager aujourd'hui ? (ou rechercher...)"
                        class="w-full bg-slate-50 hover:bg-slate-100/80 focus:bg-white border border-slate-200/80 rounded-xl sm:rounded-2xl px-3.5 sm:px-4 py-2.5 sm:py-3 text-xs text-slate-800 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all"
                      />
                    </.form>
                  </div>
                </div>

                <!-- Indicateur visuel si l'utilisateur recherche quelque chose -->
                <%= if @search_query != "" do %>
                  <div class="text-[11px] text-indigo-600 font-medium px-2 flex items-center justify-between bg-indigo-50/50 py-1.5 rounded-lg">
                    <span>Recherche en cours pour : <strong>"{@search_query}"</strong></span>
                    <button phx-click="update_search" phx-value-search_query="" class="hover:underline text-slate-500 text-[10px]">Effacer</button>
                  </div>
                <% end %>

                <div class="flex items-center justify-between pt-1 overflow-x-auto scrollbar-none gap-2 pb-1">
                  <div class="flex items-center gap-1.5 sm:gap-2 shrink-0">
                    <.action_pill icon="hero-question-mark-circle" label="Question" color="bg-indigo-50 text-indigo-600 hover:bg-indigo-100" />
                    <.action_pill icon="hero-book-open" label="Cours" color="bg-emerald-50 text-emerald-600 hover:bg-emerald-100" />
                    <.action_pill icon="hero-pencil-square" label="Exercice" color="bg-amber-50 text-amber-600 hover:bg-amber-100" />
                    <.action_pill icon="hero-light-bulb" label="Quiz" color="bg-violet-50 text-violet-600 hover:bg-violet-100" />
                    <.action_pill icon="hero-video-camera" label="Vidéo" color="bg-rose-50 text-rose-600 hover:bg-rose-100" />
                  </div>
                  <button class="text-slate-400 hover:text-slate-600 p-2 rounded-xl hover:bg-slate-50 transition-colors shrink-0 hidden sm:block">
                    <.icon name="hero-ellipsis-horizontal" class="w-5 h-5" />
                  </button>
                </div>
              </div>

              <!-- Onglets du Feed -->
              <div class="flex gap-4 sm:gap-6 border-b border-slate-200/85 px-2 overflow-x-auto scrollbar-none">
                <.tab_btn label="Pour toi" id="pour_toi" active={@active_tab == "pour_toi"} />
                <.tab_btn label="Abonnements" id="abonnements" active={@active_tab == "abonnements"} />
                <.tab_btn label="Communautés" id="communautes" active={@active_tab == "communautes"} />
                <.tab_btn label="Tendances" id="tendances" active={@active_tab == "tendances"} />
              </div>

              <!-- ================= LISTE DES PUBLICATIONS (VIA COMPOSANT GÉNÉRALISTE) ================= -->
              <div class="space-y-4 sm:space-y-6">

                <!-- 1. POST YOUTUBE 1 -->
                <.post_card
                  author_name="M. Franck T."
                  author_role="Répétiteur • Mathématiques"
                  time="1h"
                  avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"
                  badge="hero-check-badge"
                  tag_label="Vidéo explicative"
                  tag_color="bg-rose-50 text-rose-600"
                  title="Maîtriser les fonctions dérivées en 10 minutes"
                  description="Une capsule vidéo interactive pour comprendre visuellement l'interprétation géométrique de la dérivée. 🎥👇"
                  likes="1,4K"
                  comments="95"
                  shares="204"
                >
                  <div class="relative w-full pt-[56.25%] bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80">
                    <iframe
                      src="https://www.youtube.com/embed/12s5R-W_8Wk"
                      title="YouTube video player"
                      class="absolute top-0 left-0 w-full h-full border-0"
                      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                      allowfullscreen>
                    </iframe>
                  </div>
                </.post_card>

                <!-- 2. POST IMAGE : Le Bled Parle -->
                <.post_card
                  author_name="Camille Actualités"
                  author_role="Communauté • Prépa Examens"
                  time="2h"
                  avatar="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"
                  badge="hero-check-badge"
                  tag_label="Actualité Examens"
                  tag_color="bg-amber-50 text-amber-600"
                  title="Préparation Officielle Baccalauréat"
                  description="Informations clés, calendriers et conseils pratiques pour aborder sereinement les épreuves de fin d'année."
                  likes="940"
                  comments="42"
                  shares="118"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://www.lebledparle.com/wp-content/uploads/2024/07/Bac-.webp" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 3. POST YOUTUBE 2 -->
                <.post_card
                  author_name="Dr. Jean-Paul M."
                  author_role="Répétiteur • Physique"
                  time="3h"
                  avatar="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100"
                  badge="hero-check-badge"
                  tag_label="Expérience Vidéo"
                  tag_color="bg-indigo-50 text-indigo-600"
                  title="Oscillations et Circuits RLC"
                  description="Démonstration en laboratoire des régimes transitoires et permanents."
                  likes="830"
                  comments="54"
                  shares="112"
                >
                  <div class="relative w-full pt-[56.25%] bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80">
                    <iframe
                      src="https://www.youtube.com/embed/xwapaWompV0"
                      title="YouTube video player"
                      class="absolute top-0 left-0 w-full h-full border-0"
                      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                      allowfullscreen>
                    </iframe>
                  </div>
                </.post_card>

                <!-- 4. POST IMAGE : PDF 37118 -->
                <.post_card
                  author_name="Mme. Sarah B."
                  author_role="Répétiteur • Physique-Chimie"
                  time="4h"
                  avatar="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100"
                  badge="hero-check-badge"
                  tag_label="Épreuve Corrigée"
                  tag_color="bg-emerald-50 text-emerald-600"
                  title="Sujet type d'évaluation - Sciences Physiques"
                  description="Examen complet extrait de la base documentaire Epreuves et Corrigés."
                  likes="530"
                  comments="29"
                  shares="64"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://epreuvesetcorriges.com/media/com_edocman/document/gen-pdf-37118-6984a389473009.79992707.jpg" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 5. POST YOUTUBE 3 -->
                <.post_card
                  author_name="Marc E."
                  author_role="Répétiteur • Anglais"
                  time="5h"
                  avatar="https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100"
                  badge="hero-check-badge"
                  tag_label="Listening & Pronunciation"
                  tag_color="bg-amber-50 text-amber-600"
                  title="Top 5 Phrasal Verbs for English Exams"
                  description="Améliorez votre aisance orale et gagnez des points précieux à l'épreuve d'expression écrite."
                  likes="612"
                  comments="38"
                  shares="89"
                >
                  <div class="relative w-full pt-[56.25%] bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80">
                    <iframe
                      src="https://www.youtube.com/embed/jkwSI9G_j-s"
                      title="YouTube video player"
                      class="absolute top-0 left-0 w-full h-full border-0"
                      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                      allowfullscreen>
                    </iframe>
                  </div>
                </.post_card>

                <!-- 6. POST IMAGE : Schéma technique (jatXdOnJnk7...) -->
                <.post_card
                  author_name="M. David N."
                  author_role="Répétiteur • Mathématiques"
                  time="6h"
                  avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"
                  badge="hero-check-badge"
                  tag_label="Fiche de Cours"
                  tag_color="bg-violet-50 text-violet-600"
                  title="Géométrie et Représentations Graphiques"
                  description="Support visuel pour l'analyse des courbes et des théorèmes fondamentaux."
                  likes="750"
                  comments="31"
                  shares="92"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://tse2.mm.bing.net/th/id/OIP.jatXdOnJnk7QF2WwFrmeNwHaKe?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 7. POST IMAGE : PDF 3098 -->
                <.post_card
                  author_name="M. Franck T."
                  author_role="Répétiteur • Mathématiques"
                  time="7h"
                  avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"
                  badge="hero-check-badge"
                  tag_label="Examen Officiel"
                  tag_color="bg-indigo-50 text-indigo-600"
                  title="Sujet officiel avec éléments de correction"
                  description="Document de référence pour les entraînements intensifs aux concours."
                  likes="890"
                  comments="45"
                  shares="134"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://epreuvesetcorriges.com/media/com_edocman/document/gen-pdf-3098-69832d8e21e565.01300733.jpg" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 8. POST IMAGE : Illustration Bing (mNuDObi_...) -->
                <.post_card
                  author_name="Cellule Pédagogique"
                  author_role="Communauté • Sciences"
                  time="8h"
                  avatar="https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=100"
                  badge="hero-check-badge"
                  tag_label="Méthodologie"
                  tag_color="bg-rose-50 text-rose-600"
                  title="Astuces de calcul rapide et logique"
                  description="Ressource illustrée pour gagner en efficacité lors des compositions écrites."
                  likes="420"
                  comments="19"
                  shares="48"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://tse2.mm.bing.net/th/id/OIP.mNuDObi_1ypFPVrVrDVzGwAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 9. POST IMAGE : Illustration Bing (EFtnC7w7j...) -->
                <.post_card
                  author_name="Mme. Sarah B."
                  author_role="Répétiteur • Physique-Chimie"
                  time="9h"
                  avatar="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100"
                  badge="hero-check-badge"
                  tag_label="Travaux Pratiques"
                  tag_color="bg-emerald-50 text-emerald-600"
                  title="Schématisation des montage électriques"
                  description="Support visuel indispensable pour aborder les épreuves pratiques et théoriques."
                  likes="660"
                  comments="27"
                  shares="81"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://tse4.mm.bing.net/th/id/OIP.EFtnC7w7jB8i3YNXWuyyiAHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

                <!-- 10. POST INITIAL : MATHÉMATIQUES -->
                <.post_card
                  author_name="M. Franck T."
                  author_role="Répétiteur • Mathématiques"
                  time="10h"
                  avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"
                  badge="hero-check-badge"
                  tag_label="Épreuve"
                  tag_color="bg-indigo-50 text-indigo-600"
                  title="Épreuve type de Mathématiques - Analyse et Algèbre"
                  description="Voici un sujet complet d'évaluation de mathématiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇"
                  likes="1,2K"
                  comments="86"
                  shares="153"
                >
                  <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center">
                    <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl" />
                  </div>
                </.post_card>

              </div>
            </div>

            <!-- ================= COLONNE DE DROITE (SIDEBAR) ================= -->
            <aside class="hidden lg:block space-y-4 sm:space-y-6 lg:sticky lg:top-20 self-start max-h-[calc(100vh-6rem)] overflow-y-auto scrollbar-none">
              <!-- Répétiteurs recommandés -->
              <div class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-5 shadow-xs space-y-4">
                <div class="flex items-center justify-between">
                  <h4 class="font-bold text-xs text-slate-900">Répétiteurs recommandés pour toi</h4>
                  <a href={~p"/repetiteurs"} class="text-[11px] font-semibold text-indigo-600 hover:underline">Voir tout</a>
                </div>
                <div class="space-y-4">
                  <.tutor_row name="M. David N." subject="Mathématiques" rating="4.9 (128 avis)" mode="À domicile & En ligne" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" />
                  <.tutor_row name="Mme. Sarah B." subject="Physique-Chimie" rating="4.8 (96 avis)" mode="En ligne" avatar="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100" />
                  <.tutor_row name="M. James E." subject="Anglais" rating="4.7 (84 avis)" mode="À domicile" avatar="https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=100" />
                </div>
              </div>

              <!-- Communautés populaires -->
              <div class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-5 shadow-xs space-y-4">
                <div class="flex items-center justify-between">
                  <h4 class="font-bold text-xs text-slate-900">Communautés populaires</h4>
                  <a href={~p"/communautes"} class="text-[11px] font-semibold text-indigo-600 hover:underline">Voir tout</a>
                </div>
                <div class="space-y-3.5">
                  <.community_row name="Mathématiques" members="1,2M membres" icon="hero-calculator" bg="bg-indigo-600" />
                  <.community_row name="Physique-Chimie" members="850K membres" icon="hero-beaker" bg="bg-emerald-600" />
                  <.community_row name="Prépa Bac" members="1,1M membres" icon="hero-academic-cap" bg="bg-amber-600" />
                  <.community_row name="Informatique" members="620K membres" icon="hero-code-bracket" bg="bg-violet-600" />
                  <.community_row name="Anglais" members="540K membres" icon="hero-flag" bg="bg-rose-600" />
                </div>
              </div>
            </aside>

          </div>
        <% end %>
      </div>

      <!-- ================= MENU NAVIGATION EN BAS (MOBILE RESPONSIVE) ================= -->
      <nav class="lg:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-slate-200 px-4 py-2.5 z-50 shadow-lg">
        <div class="flex items-center justify-around">
          <a href={~p"/"} class={["flex flex-col items-center gap-1 text-[10px] font-medium transition-colors", @active_nav == :accueil && "text-indigo-600", @active_nav != :accueil && "text-slate-400 hover:text-slate-600"]}>
            <.icon name="hero-home" class="w-5 h-5" />
            <span>Accueil</span>
          </a>
          <a href={~p"/communautes"} class="flex flex-col items-center gap-1 text-[10px] font-medium text-slate-400 hover:text-slate-600">
            <.icon name="hero-users" class="w-5 h-5" />
            <span>Groupes</span>
          </a>
          <a href={~p"/messages"} class="flex flex-col items-center gap-1 text-[10px] font-medium text-slate-400 hover:text-slate-600">
            <.icon name="hero-chat-bubble-oval-left-ellipsis" class="w-5 h-5" />
            <span>Messages</span>
          </a>
          <a href={~p"/notifications"} class="flex flex-col items-center gap-1 text-[10px] font-medium text-slate-400 hover:text-slate-600">
            <.icon name="hero-bell" class="w-5 h-5" />
            <span>Notifs</span>
          </a>
          <a href={~p"/profil"} class="flex flex-col items-center gap-1 text-[10px] font-medium text-slate-400 hover:text-slate-600">
            <.icon name="hero-user" class="w-5 h-5" />
            <span>Profil</span>
          </a>
        </div>
      </nav>

    </Layouts.app>
    """
  end

  # =========================================================================
  # --- COMPOSANTS DE STRUCTURATION DES POSTS ET UI ---
  # =========================================================================

  attr :author_name, :string, required: true
  attr :author_role, :string, required: true
  attr :time, :string, required: true
  attr :avatar, :string, required: true
  attr :badge, :string, default: nil
  attr :tag_label, :string, required: true
  attr :tag_color, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :likes, :string, required: true
  attr :comments, :string, required: true
  attr :shares, :string, required: true
  slot :inner_block, required: true # Permet d'injecter n'importe quel média (Image, Iframe Vidéo, PDF, Document, etc.)

  def post_card(assigns) do
    ~H"""
    <article class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4">

      <!-- En-tête de l'auteur du post -->
      <div class="flex items-center justify-between gap-2">
        <div class="flex items-center gap-2.5 sm:gap-3 min-w-0">
          <img src={@avatar} class="w-9 h-9 sm:w-10 sm:h-10 rounded-full object-cover ring-2 ring-slate-100 shrink-0" />
          <div class="min-w-0">
            <div class="flex items-center gap-1.5">
              <h5 class="text-xs font-bold text-slate-900 truncate">{@author_name}</h5>
              <%= if @badge do %>
                <.icon name={@badge} class="w-4 h-4 text-indigo-600 fill-indigo-50 shrink-0" />
              <% end %>
            </div>
            <p class="text-[10px] text-slate-400 truncate">{@author_role} • <span class="text-slate-600 font-medium">{@time}</span></p>
          </div>
        </div>
        <div class="flex items-center gap-1.5 sm:gap-2 shrink-0">
          <button class="bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold px-3 py-1.5 rounded-xl text-xs transition-colors cursor-pointer">
            Suivre
          </button>
          <button class="text-slate-400 hover:text-slate-600 p-1.5 rounded-xl hover:bg-slate-50 transition-colors hidden sm:block cursor-pointer">
            <.icon name="hero-ellipsis-horizontal" class="w-5 h-5" />
          </button>
        </div>
      </div>

      <!-- Corps textuel et badge thématique du post -->
      <div class="space-y-2">
        <span class={["text-[10px] font-bold px-2.5 py-1 rounded-full inline-block", @tag_color]}>
          {@tag_label}
        </span>
        <h4 class="text-xs font-bold text-slate-900">{@title}</h4>
        <p class="text-xs text-slate-600 leading-relaxed">{@description}</p>
      </div>

      <!-- Contenu dynamique injecté (Média : Image, Vidéo YouTube, Document, etc.) -->
      <div class="w-full">
        {render_slot(@inner_block)}
      </div>

      <!-- Pied de page du post (Interactions : Likes, Commentaires, Partages) -->
      <div class="flex items-center justify-between pt-3 border-t border-slate-100 text-slate-500 text-xs font-semibold">
        <button class="flex items-center gap-1.5 hover:text-rose-600 transition-colors cursor-pointer">
          <.icon name="hero-heart-solid" class="w-4 h-4 text-rose-500" /> <span>{@likes}</span>
        </button>
        <button class="flex items-center gap-1.5 hover:text-indigo-600 transition-colors cursor-pointer">
          <.icon name="hero-chat-bubble-left" class="w-4 h-4" /> <span>{@comments}</span>
        </button>
        <button class="flex items-center gap-1.5 hover:text-indigo-600 transition-colors cursor-pointer">
          <.icon name="hero-share" class="w-4 h-4" /> <span>{@shares}</span>
        </button>
        <button class="text-slate-400 hover:text-slate-600 hidden sm:block cursor-pointer">
          <.icon name="hero-bookmark" class="w-4 h-4" />
        </button>
      </div>

    </article>
    """
  end

  attr :label, :string, required: true
  attr :id, :string, required: true
  attr :active, :boolean, default: false

  def tab_btn(assigns) do
    ~H"""
    <button phx-click="set_tab" phx-value-tab={@id} class={["pb-3 text-xs font-bold transition-colors border-b-2 shrink-0 cursor-pointer whitespace-nowrap", @active && "border-indigo-600 text-indigo-600", !@active && "border-transparent text-slate-400 hover:text-slate-600"]}>
      {@label}
    </button>
    """
  end

  attr :icon, :string, required: true
  attr :label, :string, required: true
  attr :color, :string, required: true

  def action_pill(assigns) do
    ~H"""
    <button class={["flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs font-semibold shrink-0 transition-colors cursor-pointer", @color]}>
      <.icon name={@icon} class="w-4 h-4" />
      <span>{@label}</span>
    </button>
    """
  end

  attr :name, :string, required: true
  attr :subject, :string, required: true
  attr :rating, :string, required: true
  attr :mode, :string, required: true
  attr :avatar, :string, required: true

  def tutor_row(assigns) do
    ~H"""
    <div class="flex items-center justify-between gap-3">
      <div class="flex items-center gap-3 overflow-hidden min-w-0">
        <img src={@avatar} class="w-9 h-9 rounded-full object-cover shrink-0 ring-1 ring-slate-100" />
        <div class="min-w-0">
          <h5 class="text-xs font-bold text-slate-900 truncate">{@name}</h5>
          <p class="text-[10px] text-slate-500 truncate">{@subject}</p>
        </div>
      </div>
    </div>
    """
  end

  attr :name, :string, required: true
  attr :members, :string, required: true
  attr :icon, :string, required: true
  attr :bg, :string, required: true

  def community_row(assigns) do
    ~H"""
    <div class="flex items-center justify-between gap-2">
      <div class="flex items-center gap-2.5 min-w-0">
        <div class={["w-8 h-8 rounded-xl flex items-center justify-center text-white shrink-0 shadow-xs", @bg]}>
          <.icon name={@icon} class="w-4 h-4" />
        </div>
        <div class="min-w-0">
          <h5 class="text-xs font-bold text-slate-900 truncate">{@name}</h5>
          <p class="text-[10px] text-slate-400 truncate">{@members}</p>
        </div>
      </div>
    </div>
    """
  end
end
