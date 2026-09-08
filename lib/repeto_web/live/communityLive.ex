defmodule RepetoWeb.CommunityLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, :communautes)
      |> assign(:active_filter, :toutes)
      |> assign(:active_tab, :pour_vous)
      |> assign_community_data()

    {:ok, socket}
  end

  @impl true
  def handle_event("change_filter", %{"filter" => filter}, socket) do
    {:noreply, assign(socket, :active_filter, String.to_existing_atom(filter))}
  end

  @impl true
  def handle_event("change_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, :active_tab, String.to_existing_atom(tab))}
  end

  @impl true
  def handle_event("join_community", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  defp assign_community_data(socket) do
    popular_communities = [
      %{
        id: 1,
        name: "Mathématiques",
        members: "1,2M membres",
        desc: "Tout sur les maths : exercices, astuces, cours et discussions.",
        color: "bg-indigo-50 text-indigo-600 border-indigo-100",
        btn_color: "border-indigo-200 text-indigo-600 hover:bg-indigo-50",
        avatars: [
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
          "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100"
        ],
        extra_count: "+128",
        icon: "hero-calculator"
      },
      %{
        id: 2,
        name: "Physique-Chimie",
        members: "850K membres",
        desc: "Cours, expériences, exercices et entraide entre élèves.",
        color: "bg-emerald-50 text-emerald-600 border-emerald-100",
        btn_color: "border-emerald-200 text-emerald-600 hover:bg-emerald-50",
        avatars: [
          "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100",
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
          "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=100"
        ],
        extra_count: "+84",
        icon: "hero-beaker"
      },
      %{
        id: 3,
        name: "Prépa Bac 2025",
        members: "1,1M membres",
        desc: "Réussis ton bac avec des conseils, fiches et entraînements.",
        color: "bg-amber-50 text-amber-600 border-amber-100",
        btn_color: "border-amber-200 text-amber-600 hover:bg-amber-50",
        avatars: [
          "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=100",
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"
        ],
        extra_count: "+96",
        icon: "hero-academic-cap"
      },
      %{
        id: 4,
        name: "Informatique",
        members: "620K membres",
        desc: "Programmation, algorithmique, outils et actualités tech.",
        color: "bg-blue-50 text-blue-600 border-blue-100",
        btn_color: "border-blue-200 text-blue-600 hover:bg-blue-50",
        avatars: [
          "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100",
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
          "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100"
        ],
        extra_count: "+72",
        icon: "hero-code-bracket"
      },
      %{
        id: 5,
        name: "Français",
        members: "540K membres",
        desc: "Grammaire, littérature, rédaction et méthodologie.",
        color: "bg-rose-50 text-rose-600 border-rose-100",
        btn_color: "border-rose-200 text-rose-600 hover:bg-rose-50",
        avatars: [
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
          "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=100"
        ],
        extra_count: "+63",
        icon: "hero-book-open"
      }
    ]

    my_communities = [
      %{name: "Mathématiques", time: "2 min", icon: "hero-calculator", color: "bg-indigo-50 text-indigo-600"},
      %{name: "Prépa Bac 2025", time: "5 min", icon: "hero-academic-cap", color: "bg-amber-50 text-amber-600"},
      %{name: "Physique-Chimie", time: "1 h", icon: "hero-beaker", color: "bg-emerald-50 text-emerald-600"},
      %{name: "Informatique", time: "3 h", icon: "hero-code-bracket", color: "bg-blue-50 text-blue-600"},
      %{name: "Anglais", time: "1 j", icon: "hero-book-open", color: "bg-rose-50 text-rose-600"}
    ]

    suggested_communities = [
      %{name: "Méthodes d'étude", members: "210K membres", icon: "hero-light-bulb"},
      %{name: "SVT", members: "180K membres", icon: "hero-globe-alt"},
      %{name: "Orientation & Carrières", members: "160K membres", icon: "hero-briefcase"},
      %{name: "Sciences Éco", members: "120K membres", icon: "hero-chart-bar"},
      %{name: "Philosophie", members: "98K membres", icon: "hero-chat-bubble-bottom-center-text"}
    ]

    feed_posts = [
      %{
        id: 1,
        community: "Mathématiques",
        community_icon: "hero-calculator",
        community_bg: "bg-indigo-50 text-indigo-600 border-indigo-100",
        author: "M. Franck T.",
        role: "Répétiteur",
        verified: true,
        time: "2h",
        title: "Nouvel exercice sur les fonctions affines !",
        text: "Essayez de le résoudre et partagez vos méthodes 👇",
        type: :math_exercise,
        likes: 234,
        comments: 68,
        shares: 16
      },
      %{
        id: 2,
        community: "Prépa Bac 2025",
        community_icon: "hero-academic-cap",
        community_bg: "bg-amber-50 text-amber-600 border-amber-100",
        author: "Aline D.",
        role: "Élève • Terminale C",
        verified: false,
        time: "3h",
        title: "Voici un planning de révision efficace sur 3 mois avant le Bac. Qu'en pensez-vous ?",
        text: nil,
        type: :planning_table,
        likes: 312,
        comments: 94,
        shares: 27
      },
      %{
        id: 3,
        community: "Physique-Chimie",
        community_icon: "hero-beaker",
        community_bg: "bg-emerald-50 text-emerald-600 border-emerald-100",
        author: "Dr. Alima S.",
        role: "Professeure de Physique",
        verified: true,
        time: "4h",
        title: "Schéma explicatif des forces et des champs magnétiques",
        text: "Voici une illustration claire pour vos révisions sur l'électromagnétisme.",
        type: :image_card,
        media_url: "https://tse1.mm.bing.net/th/id/OIP.L-jp-Z4k0EXkl85vgZ0SbwHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
        likes: 189,
        comments: 24,
        shares: 12
      },
      %{
        id: 4,
        community: "SVT",
        community_icon: "hero-globe-alt",
        community_bg: "bg-teal-50 text-teal-600 border-teal-100",
        author: "Marc L.",
        role: "Étudiant en Biologie",
        verified: false,
        time: "5h",
        title: "Infographie détaillée sur la mitose cellulaire",
        text: "Idéal pour mémoriser les différentes phases rapidement avant l'interro !",
        type: :image_card,
        media_url: "https://tse3.mm.bing.net/th/id/OIP.EyaUPvtYeY5L1ZNXOsG6jgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
        likes: 245,
        comments: 31,
        shares: 19
      },
      %{
        id: 5,
        community: "Informatique",
        community_icon: "hero-code-bracket",
        community_bg: "bg-blue-50 text-blue-600 border-blue-100",
        author: "Christian R.",
        role: "Développeur & Étudiant",
        verified: false,
        time: "6h",
        title: "Architecture réseau et flux de données",
        text: "Un schéma visuel simple pour comprendre comment fonctionnent les passerelles et les routeurs.",
        type: :image_card,
        media_url: "https://tse2.mm.bing.net/th/id/OIP.XK1ifTJzPekBz9PyQwA1LgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
        likes: 156,
        comments: 18,
        shares: 7
      },
      %{
        id: 6,
        community: "Mathématiques",
        community_icon: "hero-calculator",
        community_bg: "bg-indigo-50 text-indigo-600 border-indigo-100",
        author: "Chaîne Mathsfacile",
        role: "Ressource Vidéo",
        verified: true,
        time: "7h",
        title: "Tutoriel Vidéo : Tout comprendre sur les suites numériques",
        text: "Regardez cette capsule vidéo explicative pour maîtriser les limites et les suites arithmético-géométriques.",
        type: :youtube_card,
        youtube_id: "Xzf-ewTs31I",
        likes: 512,
        comments: 83,
        shares: 64
      },
      %{
        id: 7,
        community: "Prépa Bac 2025",
        community_icon: "hero-academic-cap",
        community_bg: "bg-amber-50 text-amber-600 border-amber-100",
        author: "Campus Academy",
        role: "Expert Examen",
        verified: true,
        time: "10h",
        title: "Méthode infaillible pour réussir sa dissertation",
        text: "Une vidéo pas à pas pour structurer votre plan, rédiger l'introduction et soigner votre conclusion.",
        type: :youtube_card,
        youtube_id: "jZ0zo8XtNGY",
        likes: 830,
        comments: 120,
        shares: 195
      },
      %{
        id: 8,
        community: "Informatique",
        community_icon: "hero-code-bracket",
        community_bg: "bg-blue-50 text-blue-600 border-blue-100",
        author: "CodeCraft TV",
        role: "Créateur Tech",
        verified: true,
        time: "1 j",
        title: "Découverte de Phoenix LiveView et Elixir en action",
        text: "Voyez comment créer des applications web temps réel ultra performantes sans écrire de JavaScript complexe.",
        type: :youtube_card,
        youtube_id: "By7TaezZ0Rc",
        likes: 420,
        comments: 55,
        shares: 41
      },
      %{
        id: 9,
        community: "Méthodes d'étude",
        community_icon: "hero-light-bulb",
        community_bg: "bg-yellow-50 text-yellow-600 border-yellow-100",
        author: "Dr. Paul K.",
        role: "Conseiller d'orientation",
        verified: true,
        time: "1 j",
        title: "La technique Pomodoro expliquée aux étudiants",
        text: "25 minutes de concentration intense, 5 minutes de pause. Testez et observez votre productivité grimper !",
        type: :simple_text,
        likes: 410,
        comments: 53,
        shares: 82
      },
      %{
        id: 10,
        community: "Philosophie",
        community_icon: "hero-chat-bubble-bottom-center-text",
        community_bg: "bg-orange-50 text-orange-600 border-orange-100",
        author: "Marc V.",
        role: "Professeur de Philo",
        verified: true,
        time: "2 j",
        title: "La liberté est-elle une illusion ?",
        text: "Citation du jour pour vos révisions de dissertation : « L'homme est condamné à être libre » - Jean-Paul Sartre. Qu'en pensez-vous ?",
        type: :simple_text,
        likes: 156,
        comments: 48,
        shares: 11
      }
    ]

    socket
    |> assign(:popular_communities, popular_communities)
    |> assign(:my_communities, my_communities)
    |> assign(:suggested_communities, suggested_communities)
    |> assign(:feed_posts, feed_posts)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="max-w-[1600px] mx-auto px-4 py-6">

        <!-- ================= HEADER COMMUNAUTÉS ================= -->
        <div class="bg-white border border-slate-200/80 rounded-3xl p-6 mb-6 shadow-2xs flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
          <div>
            <h1 class="font-extrabold text-2xl text-slate-900 tracking-tight">Communautés</h1>
            <p class="text-xs text-slate-500 mt-1">Rejoignez des communautés, échangez, apprenez et progressez ensemble.</p>
          </div>

          <div class="flex items-center gap-3 w-full md:w-auto">
            <div class="relative flex-1 md:w-72">
              <.icon name="hero-magnifying-glass" class="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
              <input
                type="text"
                placeholder="Rechercher une communauté..."
                class="w-full bg-slate-100/80 border border-slate-200/80 rounded-2xl pl-10 pr-4 py-2.5 text-xs text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:bg-white transition-all"
              />
            </div>
            <button class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl text-xs font-bold flex items-center gap-2 shadow-sm transition-colors cursor-pointer shrink-0">
              <.icon name="hero-plus" class="w-4 h-4" />
              <span>Créer une communauté</span>
            </button>
          </div>
        </div>

        <!-- ================= FILTRES HORIZONTAUX ================= -->
        <div class="flex items-center gap-2 overflow-x-auto scrollbar-none pb-4 mb-6">
          <% filters = [
            %{id: :toutes, label: "Toutes", icon: "hero-squares-2x2"},
            %{id: :matieres, label: "Matières", icon: "hero-book-open"},
            %{id: :examens, label: "Examens", icon: "hero-academic-cap"},
            %{id: :niveaux, label: "Niveaux", icon: "hero-signal"},
            %{id: :methodes, label: "Méthodes d'étude", icon: "hero-light-bulb"},
            %{id: :carrieres, label: "Carrières", icon: "hero-briefcase"},
            %{id: :langues, label: "Langues", icon: "hero-language"},
            %{id: :technologie, label: "Technologie", icon: "hero-cpu-chip"},
            %{id: :autres, label: "Autres", icon: "hero-ellipsis-horizontal"}
          ] %>
          <%= for f <- filters do %>
            <button
              phx-click="change_filter"
              phx-value-filter={f.id}
              class={[
                "px-4 py-2.5 rounded-2xl text-xs font-bold transition-all cursor-pointer flex items-center gap-2 shrink-0 border shadow-2xs",
                @active_filter == f.id
                  && "bg-indigo-600 text-white border-indigo-600 shadow-xs"
                  || "bg-white text-slate-700 border-slate-200/80 hover:bg-slate-50"
              ]}
            >
              <.icon name={f.icon} class="w-4 h-4" />
              <span>{f.label}</span>
            </button>
          <% end %>
        </div>

        <!-- ================= LAYOUT GLOBAL 3 COLONNES ================= -->
        <div class="grid grid-cols-12 gap-6 items-start">

          <!-- COLONNE PRINCIPALE : POPULAIRES & POSTS (Span 9) -->
          <div class="col-span-12 lg:col-span-9 space-y-6">

            <!-- Communautés populaires -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-2xs">
              <div class="flex items-center justify-between mb-5">
                <h2 class="font-extrabold text-base text-slate-900">Communautés populaires</h2>
                <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-3 xl:grid-cols-5 gap-4">
                <%= for comm <- @popular_communities do %>
                  <div class="bg-slate-50/60 border border-slate-200/80 rounded-2xl p-4 flex flex-col justify-between hover:border-indigo-300 transition-all group">
                    <div class="space-y-3">
                      <div class={["w-12 h-12 rounded-2xl flex items-center justify-center border shadow-2xs", comm.color]}>
                        <.icon name={comm.icon} class="w-6 h-6" />
                      </div>
                      <div>
                        <h3 class="font-extrabold text-xs text-slate-900 group-hover:text-indigo-600 transition-colors">{comm.name}</h3>
                        <p class="text-[10px] text-slate-400 font-medium">{comm.members}</p>
                      </div>
                      <p class="text-[11px] text-slate-600 leading-relaxed line-clamp-2">{comm.desc}</p>
                    </div>

                    <div class="pt-4 mt-4 border-t border-slate-200/60 space-y-3">
                      <div class="flex items-center justify-between">
                        <div class="flex -space-x-1.5 overflow-hidden">
                          <%= for avatar <- comm.avatars do %>
                            <img src={avatar} class="w-6 h-6 rounded-full object-cover border-2 border-white" />
                          <% end %>
                        </div>
                        <span class="text-[10px] font-bold text-slate-400">{comm.extra_count}</span>
                      </div>
                      <.link navigate={~p"/communaute"} class={["block text-center w-full py-2 rounded-xl text-xs font-bold border transition-colors cursor-pointer", comm.btn_color]}>
  Rejoindre
</.link>
                    </div>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- Onglets du fil d'actualités -->
            <div class="flex items-center gap-2 border-b border-slate-200/80 pb-3">
              <% tabs = [
                %{id: :pour_vous, label: "Pour vous"},
                %{id: :nouvelles, label: "Nouvelles"},
                %{id: :discussions, label: "Discussions", badge: "12"},
                %{id: :questions, label: "Questions"},
                %{id: :ressources, label: "Ressources"},
                %{id: :evenements, label: "Événements"}
              ] %>
              <%= for t <- tabs do %>
                <button
                  phx-click="change_tab"
                  phx-value-tab={t.id}
                  class={[
                    "px-4 py-2 rounded-xl text-xs font-bold transition-colors cursor-pointer flex items-center gap-1.5",
                    @active_tab == t.id
                      && "bg-indigo-50 text-indigo-600 shadow-2xs"
                      || "text-slate-500 hover:text-slate-900 hover:bg-slate-100"
                  ]}
                >
                  <span>{t.label}</span>
                  <%= if Map.get(t, :badge) do %>
                    <span class="px-1.5 py-0.5 bg-indigo-600 text-white rounded-full text-[9px] font-black">{t.badge}</span>
                  <% end %>
                </button>
              <% end %>
            </div>

            <!-- GRILLE DES POSTS -->
            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6">
              <%= for post <- @feed_posts do %>
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-2xs flex flex-col justify-between space-y-4">
                  <div class="space-y-3">
                    <!-- En-tête du post -->
                    <div class="flex items-start justify-between">
                      <div class="flex items-center gap-3">
                        <div class={["w-10 h-10 rounded-2xl flex items-center justify-center border shrink-0 font-bold", post.community_bg]}>
                          <.icon name={post.community_icon} class="w-5 h-5" />
                        </div>
                        <div>
                          <h3 class="font-extrabold text-xs text-slate-900">{post.community}</h3>
                          <p class="text-[10px] text-slate-500">
                            Publié par {post.author} • {post.role}
                            <%= if post.verified do %>
                              <.icon name="hero-check-badge" class="w-3.5 h-3.5 text-indigo-600 inline ml-0.5" />
                            <% end %>
                          </p>
                          <p class="text-[9px] text-slate-400">{post.time} • <.icon name="hero-globe-alt" class="w-3 h-3 inline" /></p>
                        </div>
                      </div>
                      <button class="text-slate-400 hover:text-slate-600 cursor-pointer">
                        <.icon name="hero-ellipsis-horizontal" class="w-5 h-5" />
                      </button>
                    </div>

                    <!-- Contenu textuel -->
                    <div>
                      <h4 class="font-extrabold text-xs text-slate-900 mb-1">{post.title}</h4>
                      <%= if post.text do %>
                        <p class="text-xs text-slate-600 leading-relaxed">{post.text}</p>
                      <% end %>
                    </div>

                    <!-- Exercice de Maths -->
                    <%= if post.type == :math_exercise do %>
                      <div class="bg-slate-50/80 border border-slate-200/80 rounded-2xl p-4 space-y-2 text-xs text-slate-800">
                        <p class="italic text-[11px]">Soit f la fonction affine définie par f(x) = 2x - 3.</p>
                        <ol class="list-decimal list-inside space-y-1 text-[11px] font-medium text-slate-700">
                          <li>Déterminer l'image de 4 par la fonction f.</li>
                          <li>Déterminer l'antécédent de 5 par la fonction f.</li>
                          <li>Tracer la courbe représentative de la fonction f.</li>
                        </ol>
                      </div>
                    <% end %>

                    <!-- Tableau de planning -->
                    <%= if post.type == :planning_table do %>
                      <div class="bg-slate-50/80 border border-slate-200/80 rounded-2xl p-3 overflow-x-auto">
                        <table class="w-full text-left text-[10px] text-slate-700">
                          <thead>
                            <tr class="border-b border-slate-200 font-extrabold text-slate-900">
                              <th class="pb-1.5">Semaine</th>
                              <th class="pb-1.5">Maths</th>
                              <th class="pb-1.5">Physique</th>
                              <th class="pb-1.5">Français</th>
                              <th class="pb-1.5">Objectif</th>
                            </tr>
                          </thead>
                          <tbody class="divide-y divide-slate-100">
                            <tr>
                              <td class="py-1.5 font-bold">S1</td>
                              <td>Fonctions</td>
                              <td>Mécanique</td>
                              <td>Dissertation</td>
                              <td class="font-semibold text-indigo-600">Bases solides</td>
                            </tr>
                            <tr>
                              <td class="py-1.5 font-bold">S2</td>
                              <td>Suites</td>
                              <td>Électricité</td>
                              <td>Commentaire</td>
                              <td class="font-semibold text-indigo-600">Application</td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    <% end %>

                    <!-- Image intégrée -->
                    <%= if post.type == :image_card do %>
                      <div class="rounded-2xl overflow-hidden bg-slate-100 border border-slate-200/80 p-1.5">
                        <img src={post.media_url} class="w-full h-44 object-cover rounded-xl" alt="Média post" />
                      </div>
                    <% end %>

                    <!-- Vidéo YouTube intégrée -->
                    <%= if post.type == :youtube_card do %>
                      <div class="rounded-2xl overflow-hidden bg-slate-900 border border-slate-800 aspect-video relative flex items-center justify-center">
                        <iframe
                          src={"https://www.youtube.com/embed/#{post.youtube_id}"}
                          class="w-full h-full absolute inset-0"
                          frameborder="0"
                          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                          allowfullscreen
                        ></iframe>
                      </div>
                    <% end %>
                  </div>

                  <!-- Actions du post -->
                  <div class="pt-3 border-t border-slate-100 flex items-center justify-between text-slate-500 text-xs">
                    <div class="flex items-center gap-4">
                      <button class="flex items-center gap-1.5 hover:text-rose-600 transition-colors cursor-pointer">
                        <span class="w-4 h-4 rounded-full bg-rose-500 text-white flex items-center justify-center text-[8px]">❤️</span>
                        <span class="text-[11px] font-bold">{post.likes}</span>
                      </button>
                      <button class="flex items-center gap-1 hover:text-indigo-600 transition-colors cursor-pointer">
                        <.icon name="hero-chat-bubble-left" class="w-4 h-4" />
                        <span class="text-[11px] font-bold">{post.comments}</span>
                      </button>
                      <button class="flex items-center gap-1 hover:text-indigo-600 transition-colors cursor-pointer">
                        <.icon name="hero-share" class="w-4 h-4" />
                        <span class="text-[11px] font-bold">{post.shares}</span>
                      </button>
                    </div>
                    <button class="text-slate-400 hover:text-slate-600 cursor-pointer">
                      <.icon name="hero-bookmark" class="w-4 h-4" />
                    </button>
                  </div>
                </div>
              <% end %>
            </div>

          </div>

          <!-- ================= COLONNE LATÉRALE DROITE FIXE (Span 3) ================= -->
          <div class="col-span-12 lg:col-span-3 space-y-6 sticky top-6">

            <!-- Mes communautés -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-5 shadow-2xs space-y-4">
              <div class="flex items-center justify-between">
                <h3 class="font-extrabold text-xs text-slate-900">Mes communautés</h3>
                <a href="#" class="text-[11px] font-bold text-indigo-600 hover:underline">Voir tout</a>
              </div>

              <div class="space-y-3">
                <%= for comm <- @my_communities do %>
                  <div class="flex items-center justify-between group cursor-pointer hover:bg-slate-50 p-1.5 rounded-xl transition-colors">
                    <div class="flex items-center gap-3 min-w-0">
                      <div class={["w-9 h-9 rounded-xl flex items-center justify-center shrink-0 border", comm.color]}>
                        <.icon name={comm.icon} class="w-4 h-4" />
                      </div>
                      <div class="min-w-0">
                        <p class="font-bold text-xs text-slate-900 truncate">{comm.name}</p>
                        <p class="text-[10px] text-slate-400">Dernière activité : {comm.time}</p>
                      </div>
                    </div>
                    <button class="text-slate-400 hover:text-slate-600">
                      <.icon name="hero-ellipsis-horizontal" class="w-4 h-4" />
                    </button>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- Communautés suggérées -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-5 shadow-2xs space-y-4">
              <div class="flex items-center justify-between">
                <h3 class="font-extrabold text-xs text-slate-900">Communautés suggérées</h3>
                <a href="#" class="text-[11px] font-bold text-indigo-600 hover:underline">Voir tout</a>
              </div>

              <div class="space-y-3">
                <%= for sugg <- @suggested_communities do %>
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2.5 min-w-0">
                      <div class="w-8 h-8 rounded-xl bg-slate-100 text-slate-600 flex items-center justify-center shrink-0 border border-slate-200/60">
                        <.icon name={sugg.icon} class="w-4 h-4" />
                      </div>
                      <div class="min-w-0">
                        <p class="font-bold text-xs text-slate-900 truncate">{sugg.name}</p>
                        <p class="text-[10px] text-slate-400">{sugg.members}</p>
                      </div>
                    </div>
                    <button class="px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 rounded-xl text-[11px] font-bold transition-colors cursor-pointer shrink-0">
                      Rejoindre
                    </button>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- Événements à venir -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-5 shadow-2xs space-y-4">
              <div class="flex items-center justify-between">
                <h3 class="font-extrabold text-xs text-slate-900">Événements à venir</h3>
                <a href="#" class="text-[11px] font-bold text-indigo-600 hover:underline">Voir tout</a>
              </div>

              <div class="bg-slate-50/80 border border-slate-200/80 rounded-2xl p-4 flex items-center gap-3.5">
                <div class="w-12 h-12 bg-indigo-600 text-white rounded-2xl flex flex-col items-center justify-center shrink-0 shadow-xs">
                  <span class="text-[9px] font-bold uppercase tracking-wider">Mai</span>
                  <span class="text-sm font-black">24</span>
                </div>
                <div class="min-w-0 space-y-1">
                  <h4 class="font-extrabold text-xs text-slate-900 truncate">Webinaire : Réussir les maths au Bac 2025</h4>
                  <p class="text-[10px] text-slate-500">Avec M. Franck T.</p>
                  <p class="text-[10px] font-bold text-indigo-600">Samedi à 16:00</p>
                </div>
              </div>

              <button class="w-full py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl text-xs font-bold transition-colors shadow-xs cursor-pointer">
                S'inscrire
              </button>
            </div>

          </div>

        </div>

      </div>
    </Layouts.app>
    """
  end
end
