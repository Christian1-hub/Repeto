defmodule RepetoWeb.CommunauteLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, :communautes)
      |> assign(:active_tab, :discussions)
      |> assign(:post_content, "")
      |> assign(:playing_video_id, nil) # ID de la vidéo en cours de lecture sur place
      |> assign_community_data()

    {:ok, socket}
  end

  @impl true
  def handle_event("change_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, :active_tab, String.to_existing_atom(tab))}
  end

  @impl true
  def handle_event("update_post", %{"post_content" => content}, socket) do
    {:noreply, assign(socket, :post_content, content)}
  end

  @impl true
  def handle_event("submit_post", _params, socket) do
    # Logique d'ajout de publication ici
    {:noreply, assign(socket, :post_content, "")}
  end

  @impl true
  def handle_event("play_video", %{"video_id" => video_id}, socket) do
    {:noreply, assign(socket, :playing_video_id, video_id)}
  end

  defp assign_community_data(socket) do
    community = %{
      name: "Mathématiques",
      badge: "Communauté des passionnés de maths",
      members_count: "125 400 membres",
      type: "Public",
      created_by: "Créée par Repeto",
      banner: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=1200&auto=format&fit=crop&q=80",
      avatar: "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=200&auto=format&fit=crop&q=80",
      description: "Communauté dédiée aux mathématiques pour tous les élèves, étudiants et passionnés. Cours, exercices, astuces, discussions et préparation aux examens.",
      tags: ["#mathématiques", "#algèbre", "#analyse", "#géométrie", "#probabilités"],
      stats: %{members: "125,4K", publications: "8,7K", admins: "12"}
    }

    posts = [
      %{
        id: 1,
        type: :video_post,
        author: "M. Franck T.",
        role: "Répétiteur",
        verified: true,
        time: "À l'instant",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80",
        title: "🎥 Vidéo explicative : Méthode Capture Marquage Recapture (CMR)",
        content: "Je vous partage cette excellente vidéo pas à pas pour bien assimiler la méthode CMR en situation réelle (exemple du lac et des poissons). Idéal pour vos révisions !",
        video_id: "RyGar6oNSy8",
        video_title: "Méthode Capture Marquage Recapture - CMR",
        video_channel: "Quentin Fodere",
        video_thumbnail: "https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=1000&auto=format&fit=crop&q=80",
        video_duration: "10:17",
        likes: "184",
        comments: "12",
        shares: "29"
      },
      %{
        id: 2,
        type: :cmr_post,
        author: "M. Franck T.",
        role: "Répétiteur",
        verified: true,
        time: "Il y a 10 minutes",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80",
        title: "📌 Fiche méthode : La méthode de Capture-Marquage-Recapture (CMR)",
        content: "Bonjour la communauté !\nPour compléter nos révisions sur les statistiques et probabilités, voici un support visuel complet pour bien comprendre l'estimation d'une population dans un écosystème fermé.\n\nFormule d'estimation clé :\nN ≈ (M × n) / m",
        images: [
          "https://tse1.mm.bing.net/th/id/OIP.sMDhUySlE162lrabLtyIdgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
          "https://tse1.mm.bing.net/th/id/OIP.4ZP3scotY9Cut4N_Xb2q2gHaKe?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
        ],
        video_url: "https://youtu.be/RyGar6oNSy8?si=YuUsF1SJi5iUu58Z",
        video_title: "Méthode Capture Marquage Recapture - CMR (Quentin Fodere)",
        likes: "342",
        comments: "28",
        shares: "45"
      },
      %{
        id: 3,
        type: :standard,
        author: "M. Franck T.",
        role: "Répétiteur",
        verified: true,
        time: "il y a 3 heures",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80",
        title: "Comprendre les fonctions de référence : mémo visuel",
        content: "Voici un récapitulatif graphique indispensable pour visualiser rapidement l'allure des courbes de référence (parabole, hyperbole, racine carrée).",
        image: "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800&auto=format&fit=crop&q=80",
        attachment: %{title: "Fiche_Methodo_Fonctions.pdf", type: "PDF • 4.2 Mo", color: "text-rose-500", bg: "bg-rose-50"},
        likes: "1 248",
        comments: "127",
        shares: "356"
      },
      %{
        id: 4,
        type: :question,
        author: "Estelle N.",
        role: "Élève — Terminale C",
        verified: false,
        time: "il y a 5 heures",
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80",
        title: "Aide exercice sur les limites et formes indéterminées",
        content: "Bonjour la communauté !\nJe bloque sur le calcul de cette limite avec une forme indéterminée :\n\nlim (x → +∞) [ √(x² + 2x) - x ]\n\nQuelqu'un peut m'expliquer comment utiliser l'expression conjuguée ici ?",
        image: nil,
        attachment: nil,
        likes: "186",
        comments: "45",
        shares: nil
      },
      %{
        id: 5,
        type: :quiz,
        author: "Repeto Académie",
        role: "Officiel",
        verified: true,
        time: "il y a 1 jour",
        avatar: "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=100&auto=format&fit=crop&q=80",
        title: "⚡ Mini-Quiz Flash : Calcul de Dérivées",
        content: "Testez vos connaissances en 1 question : Quelle est la dérivée exacte de la fonction f(x) = ln(3x² + 1) ?",
        options: [
          %{id: 1, text: "6x / (3x² + 1)", votes: "64%"},
          %{id: 2, text: "3 / (3x² + 1)", votes: "12%"},
          %{id: 3, text: "6x / (3x)", votes: "24%"}
        ],
        likes: "412",
        comments: "32",
        shares: "15"
      }
    ]

    resources = [
      %{title: "Cours de mathématiques — Terminale", author: "Par M. Franck T. • 12 pages", downloads: "12,4K téléchargements", icon: "hero-document-text", color: "text-rose-500", bg: "bg-rose-50"},
      %{title: "Fiche de révision — Dérivées", author: "Par Repeto • 6 pages", downloads: "9,6K téléchargements", icon: "hero-document-text", color: "text-blue-500", bg: "bg-blue-50"},
      %{title: "Épreuves de Maths TC 2024", author: "Par Repeto • 11 pages", downloads: "15,2K téléchargements", icon: "hero-document-text", color: "text-emerald-500", bg: "bg-emerald-50"}
    ]

    online_members = [
      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
      "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100",
      "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100",
      "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100"
    ]

    socket
    |> assign(:community, community)
    |> assign(:posts, posts)
    |> assign(:resources, resources)
    |> assign(:online_members, online_members)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="space-y-6 pb-12">

        <!-- Bouton de retour vers la liste des communautés -->
        <div>
          <.link navigate={~p"/communautes"} class="inline-flex items-center gap-2 px-3.5 py-2 bg-white hover:bg-slate-50 border border-slate-200/80 rounded-xl text-xs font-bold text-slate-700 transition-colors shadow-xs cursor-pointer">
            <.icon name="hero-arrow-left" class="w-4 h-4 text-slate-500" />
            <span>Retour aux communautés</span>
          </.link>
        </div>

      <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-xs">
        <div class="relative h-48 sm:h-64 overflow-hidden">
          <img src={@community.banner} class="w-full h-full object-cover" />
          <div class="absolute inset-0 bg-gradient-to-t from-slate-900/40 to-transparent"></div>
        </div>

        <div class="px-6 sm:px-8 pb-6 pt-0 relative">
          <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-4 -mt-12 sm:-mt-14 mb-4">
            <div class="flex items-end gap-4">
              <img src={@community.avatar} class="w-24 h-24 sm:w-28 sm:h-28 rounded-2xl object-cover ring-4 ring-white shadow-md bg-indigo-900" />
              <div class="mb-1">
                <div class="flex items-center gap-1.5">
                  <h1 class="text-xl sm:text-2xl font-black text-slate-900">{@community.name}</h1>
                  <.icon name="hero-check-badge" class="w-5 h-5 text-indigo-600" />
                </div>
                <p class="text-xs text-slate-500 font-medium mt-0.5">{@community.badge}</p>
              </div>
            </div>

            <div class="flex items-center gap-2">
              <button class="flex items-center gap-2 px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl transition-colors shadow-sm cursor-pointer">
                <.icon name="hero-check" class="w-4 h-4" />
                <span>Membre</span>
              </button>
              <button class="p-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl transition-colors cursor-pointer">
                <.icon name="hero-bell" class="w-4 h-4" />
              </button>
              <button class="p-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl transition-colors cursor-pointer">
                <.icon name="hero-ellipsis-horizontal" class="w-4 h-4" />
              </button>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-4 text-xs text-slate-500 pt-2 border-t border-slate-100">
            <span class="flex items-center gap-1.5 font-medium">
              <.icon name="hero-user-group" class="w-4 h-4 text-slate-400" />
              {@community.members_count}
            </span>
            <span class="flex items-center gap-1.5 font-medium">
              <.icon name="hero-globe-alt" class="w-4 h-4 text-slate-400" />
              {@community.type}
            </span>
            <span class="flex items-center gap-1.5 font-medium">
              <.icon name="hero-shield-check" class="w-4 h-4 text-slate-400" />
              {@community.created_by}
            </span>

          </div>

          <div class="flex items-center gap-1 sm:gap-6 overflow-x-auto pt-6 border-t border-slate-100 mt-4 scrollbar-none">
            <% tabs = [
              %{id: :discussions, label: "Discussions", icon: "hero-chat-bubble-left-right"},
              %{id: :ressources, label: "Ressources", icon: "hero-document-text"},
              %{id: :cours, label: "Cours", icon: "hero-book-open"},
              %{id: :quiz, label: "Quiz", icon: "hero-question-mark-circle"},
              %{id: :evenements, label: "Événements", icon: "hero-calendar"},
              %{id: :membres, label: "Membres", icon: "hero-user-group"},
              %{id: :apropos, label: "À propos", icon: "hero-information-circle"}
            ] %>

            <%= for tab <- tabs do %>
              <button
                phx-click="change_tab"
                phx-value-tab={tab.id}
                class={[
                  "flex items-center gap-2 pb-3 px-2 text-xs font-bold transition-colors border-b-2 whitespace-nowrap cursor-pointer",
                  @active_tab == tab.id
                    && "border-indigo-600 text-indigo-600"
                    || "border-transparent text-slate-500 hover:text-slate-800"
                ]}
              >
                <.icon name={tab.icon} class="w-4 h-4" />
                <span>{tab.label}</span>
              </button>
            <% end %>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

        <div class="lg:col-span-2 space-y-6">

          <div class="bg-white border border-slate-200/80 rounded-2xl p-4 shadow-xs space-y-4">
            <div class="flex items-center gap-3">
              <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100" class="w-10 h-10 rounded-full object-cover" />
              <input
                type="text"
                value={@post_content}
                phx-keyup="update_post"
                name="post_content"
                placeholder="Écrivez une publication dans Mathématiques..."
                class="w-full bg-slate-100/80 border border-slate-200/80 rounded-full px-4 py-2.5 text-xs text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:bg-white transition-all"
              />
            </div>

            <div class="flex items-center justify-between pt-2 border-t border-slate-100">
              <div class="flex items-center gap-1 sm:gap-2">
                <button class="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-[11px] font-semibold transition-colors cursor-pointer">
                  <.icon name="hero-photo" class="w-4 h-4 text-indigo-600" />
                  <span>Image</span>
                </button>
                <button class="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-[11px] font-semibold transition-colors cursor-pointer">
                  <.icon name="hero-document-text" class="w-4 h-4 text-rose-500" />
                  <span>Fichier PDF</span>
                </button>
                <button class="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-[11px] font-semibold transition-colors cursor-pointer hidden sm:flex">
                  <.icon name="hero-chart-bar" class="w-4 h-4 text-amber-500" />
                  <span>Sondage</span>
                </button>
                <button class="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-[11px] font-semibold transition-colors cursor-pointer hidden sm:flex">
                  <.icon name="hero-calculator" class="w-4 h-4 text-emerald-500" />
                  <span>Équation</span>
                </button>
              </div>

              <button phx-click="submit_post" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl transition-colors shadow-sm cursor-pointer">
                Publier
              </button>
            </div>
          </div>

          <div class="flex items-center justify-between">
            <h2 class="font-extrabold text-sm sm:text-base text-slate-900">Publications</h2>
            <div class="flex items-center gap-2 bg-white border border-slate-200/80 px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-700 cursor-pointer shadow-xs">
              <span>Plus récentes</span>
              <.icon name="hero-chevron-down" class="w-3.5 h-3.5 text-slate-400" />
            </div>
          </div>

          <div class="space-y-4">
            <%= for post <- @posts do %>
              <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">

                <div class="flex items-start justify-between">
                  <div class="flex items-center gap-3">
                    <img src={post.avatar} class="w-10 h-10 rounded-full object-cover" />
                    <div>
                      <div class="flex items-center gap-1.5">
                        <span class="font-bold text-xs text-slate-900">{post.author}</span>
                        <%= if post.verified do %>
                          <.icon name="hero-check-badge" class="w-4 h-4 text-indigo-600" />
                        <% end %>
                        <span class="px-2 py-0.5 bg-indigo-50 text-indigo-600 text-[10px] font-bold rounded-md">{post.role}</span>
                      </div>
                      <p class="text-[10px] text-slate-400 mt-0.5">{post.time}</p>
                    </div>
                  </div>
                  <.icon name="hero-ellipsis-horizontal" class="w-4 h-4 text-slate-400 cursor-pointer" />
                </div>

                <div class="space-y-2">
                  <%= if post.title do %>
                    <h3 class="font-bold text-xs sm:text-sm text-slate-900">{post.title}</h3>
                  <% end %>
                  <p class="text-xs text-slate-700 whitespace-pre-line leading-relaxed">{post.content}</p>
                </div>

                <%= if post.type == :video_post do %>
                  <div class="rounded-2xl overflow-hidden border border-slate-200/80 bg-slate-900 shadow-sm">
                    <%= if @playing_video_id == post.video_id do %>
                      <div class="relative w-full h-64 sm:h-72 bg-black">
                        <iframe
                          src={"https://www.youtube.com/embed/#{post.video_id}?autoplay=1"}
                          class="w-full h-full"
                          frameborder="0"
                          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                          allowfullscreen
                        ></iframe>
                      </div>
                    <% else %>
                      <button phx-click="play_video" phx-value-video_id={post.video_id} class="group relative block w-full h-64 sm:h-72 overflow-hidden bg-slate-900 cursor-pointer text-left">
                        <img src={post.video_thumbnail} class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500 opacity-90" />
                        <div class="absolute inset-0 bg-gradient-to-t from-slate-950/80 via-slate-950/20 to-transparent"></div>

                        <div class="absolute inset-0 flex items-center justify-center">
                          <div class="w-16 h-16 bg-rose-600 group-hover:bg-rose-500 text-white rounded-full flex items-center justify-center shadow-lg transition-transform transform group-hover:scale-110">
                            <.icon name="hero-play" class="w-8 h-8 fill-current ml-1" />
                          </div>
                        </div>

                        <div class="absolute bottom-0 inset-x-0 p-4 flex items-center justify-between text-white">
                          <div class="space-y-0.5">
                            <p class="font-bold text-xs sm:text-sm line-clamp-1">{post.video_title}</p>
                            <p class="text-[11px] text-slate-300 font-medium">Par {post.video_channel} • Regarder directement ici</p>
                          </div>
                          <span class="px-2.5 py-1 bg-black/60 backdrop-blur-md rounded-lg text-[10px] font-bold text-white shrink-0">
                            {post.video_duration}
                          </span>
                        </div>
                      </button>
                    <% end %>
                  </div>
                <% end %>

                <%= if Map.get(post, :images) && post.images do %>
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <%= for img <- post.images do %>
                      <div class="rounded-2xl overflow-hidden border border-slate-200/80 h-48 bg-slate-100">
                        <img src={img} class="w-full h-full object-cover hover:scale-102 transition-transform duration-300 cursor-pointer" />
                      </div>
                    <% end %>
                  </div>
                <% end %>

                <%= if Map.get(post, :image) && post.image do %>
                  <div class="rounded-2xl overflow-hidden border border-slate-200/80 max-h-80 bg-slate-100">
                    <img src={post.image} class="w-full h-full object-cover hover:scale-102 transition-transform duration-300 cursor-pointer" />
                  </div>
                <% end %>

                <%= if post.type == :quiz do %>
                  <div class="space-y-2 pt-1">
                    <%= for opt <- post.options do %>
                      <div class="w-full text-left p-3 rounded-xl border border-slate-200 bg-slate-50 hover:bg-indigo-50/50 hover:border-indigo-300 transition-all flex items-center justify-between text-xs font-semibold text-slate-700 cursor-pointer">
                        <span>{opt.text}</span>
                        <span class="text-xs font-bold text-indigo-600 bg-white px-2.5 py-1 rounded-lg border border-slate-200 shadow-2xs">{opt.votes}</span>
                      </div>
                    <% end %>
                  </div>
                <% end %>

                <%= if Map.get(post, :attachment) && post.attachment do %>
                  <div class="border border-slate-200/80 rounded-xl p-3.5 bg-slate-50 flex items-center gap-3 hover:bg-slate-100 transition-colors cursor-pointer">
                    <div class={"w-10 h-10 #{post.attachment.bg} #{post.attachment.color} rounded-xl flex items-center justify-center shrink-0 font-bold"}>
                      <.icon name="hero-document-text" class="w-5 h-5" />
                    </div>
                    <div class="space-y-0.5">
                      <p class="font-bold text-xs text-slate-900">{post.attachment.title}</p>
                      <p class="text-[10px] text-slate-500 font-semibold">{post.attachment.type}</p>
                    </div>
                  </div>
                <% end %>

                <div class="flex items-center justify-between pt-3 border-t border-slate-100 text-[11px] text-slate-500">
                  <div class="flex items-center gap-2">
                    <div class="flex items-center -space-x-1">
                      <span class="w-5 h-5 bg-rose-500 rounded-full flex items-center justify-center text-[10px] text-white">❤️</span>
                      <span class="w-5 h-5 bg-amber-500 rounded-full flex items-center justify-center text-[10px] text-white">👍</span>
                      <span class="w-5 h-5 bg-orange-500 rounded-full flex items-center justify-center text-[10px] text-white">😲</span>
                    </div>
                    <span class="font-bold text-slate-700">{post.likes}</span>
                  </div>

                  <div class="flex items-center gap-4">
                    <%= if post.comments do %>
                      <span>{post.comments} commentaires</span>
                    <% end %>
                    <%= if post.shares do %>
                      <span>{post.shares} partages</span>
                    <% end %>
                    <.icon name="hero-bookmark" class="w-4 h-4 text-slate-400 cursor-pointer hover:text-indigo-600" />
                  </div>
                </div>

              </div>
            <% end %>
          </div>

        </div>

        <div class="space-y-6 lg:sticky lg:top-6">

          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <div class="flex items-center justify-between">
              <h3 class="font-extrabold text-xs text-slate-900">À propos</h3>
              <.icon name="hero-ellipsis-horizontal" class="w-4 h-4 text-slate-400 cursor-pointer" />
            </div>

            <p class="text-xs text-slate-600 leading-relaxed">{@community.description}</p>

            <div class="flex flex-wrap gap-1.5 pt-1">
              <%= for tag <- @community.tags do %>
                <span class="px-2.5 py-1 bg-slate-100 text-slate-600 rounded-lg text-[10px] font-semibold">{tag}</span>
              <% end %>
            </div>

            <div class="grid grid-cols-3 gap-2 pt-3 border-t border-slate-100 text-center">
              <div>
                <p class="font-black text-xs text-slate-900">{@community.stats.members}</p>
                <p class="text-[10px] text-slate-400">Membres</p>
              </div>
              <div>
                <p class="font-black text-xs text-slate-900">{@community.stats.publications}</p>
                <p class="text-[10px] text-slate-400">Publications</p>
              </div>
              <div>
                <p class="font-black text-xs text-slate-900">{@community.stats.admins}</p>
                <p class="text-[10px] text-slate-400">Admins</p>
              </div>
            </div>
          </div>

          <div class="bg-gradient-to-br from-indigo-50 to-purple-50 border border-indigo-100 rounded-2xl p-4 flex items-center gap-3.5">
            <div class="w-10 h-10 bg-indigo-600 text-white rounded-xl flex items-center justify-center shrink-0 shadow-sm">
              🏆
            </div>
            <div>
              <h4 class="font-bold text-xs text-indigo-900">Communauté active</h4>
              <p class="text-[11px] text-slate-600 mt-0.5">Classée parmi les 3 communautés les plus dynamiques de Repeto.</p>
            </div>
          </div>

          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <div class="flex items-center justify-between">
              <h3 class="font-extrabold text-xs text-slate-900">Ressources populaires</h3>
              <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
            </div>

            <div class="space-y-3">
              <%= for res <- @resources do %>
                <div class="space-y-1 pb-3 border-b border-slate-100 last:border-0 last:pb-0">
                  <h4 class="font-bold text-xs text-slate-900 leading-snug hover:text-indigo-600 cursor-pointer">{res.title}</h4>
                  <div class="flex items-center justify-between text-[10px] text-slate-400">
                    <span>{res.author}</span>
                    <span class="text-indigo-600 font-semibold">{res.downloads}</span>
                  </div>
                </div>
              <% end %>
            </div>
          </div>

          <div class="bg-white border border-slate-200/80 rounded-2xl p-5 shadow-xs space-y-4">
            <div class="flex items-center justify-between">
              <h3 class="font-extrabold text-xs text-slate-900">Membres en ligne</h3>
              <a href="#" class="text-xs font-bold text-indigo-600 hover:underline">Voir tout</a>
            </div>

            <div class="flex items-center -space-x-2 overflow-hidden py-1">
              <%= for avatar <- @online_members do %>
                <img src={avatar} class="w-9 h-9 rounded-full object-cover ring-2 ring-white" />
              <% end %>
              <div class="w-9 h-9 rounded-full bg-slate-100 border border-slate-200 text-[10px] font-bold text-slate-600 flex items-center justify-center ring-2 ring-white">
                +247
              </div>
            </div>
          </div>

        </div>

      </div>

    </div>
    </Layouts.app>
    """
  end
end
