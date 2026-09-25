defmodule RepetoWeb.MessageLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_nav, :messages)
      |> assign(:active_filter, :toutes)
      |> assign(:message_input, "")
      |> assign(:selected_conversation_id, 1)
      |> assign_messaging_data()

    {:ok, socket}
  end

  @impl true
  def handle_event("change_filter", %{"filter" => filter}, socket) do
    {:noreply, assign(socket, :active_filter, String.to_existing_atom(filter))}
  end

  @impl true
  def handle_event("select_conversation", %{"id" => id}, socket) do
    {:noreply, assign(socket, :selected_conversation_id, String.to_integer(id))}
  end

  @impl true
  def handle_event("update_message", %{"message_input" => content}, socket) do
    {:noreply, assign(socket, :message_input, content)}
  end

  @impl true
  def handle_event("send_message", _params, socket) do
    {:noreply, assign(socket, :message_input, "")}
  end

  defp assign_messaging_data(socket) do
    conversations = [
      %{
        id: 1,
        name: "M. Franck T.",
        subtitle: "Mathématiques",
        last_message: "Parfait ! On se retrouve demain...",
        time: "11:32",
        unread: 2,
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80",
        online: true,
        type: :user
      },
      %{
        id: 2,
        name: "Groupe : Terminale C",
        subtitle: "Aline D. : Voici le corrigé de l'exercice 4",
        last_message: "10:45",
        time: "10:45",
        unread: 8,
        avatar: "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :group
      },
      %{
        id: 3,
        name: "Mme. Sarah B.",
        subtitle: "Physique-Chimie",
        last_message: "N'oublie pas d'envoyer ton exercice.",
        time: "Hier",
        unread: 0,
        avatar: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :user
      },
      %{
        id: 4,
        name: "Lucas M.",
        subtitle: "Élève • Seconde",
        last_message: "Merci beaucoup pour l'explication !",
        time: "Hier",
        unread: 0,
        avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :user
      },
      %{
        id: 5,
        name: "Groupe : Mathématiques",
        subtitle: "M. David N. : Voici un nouveau quiz",
        last_message: "Hier",
        time: "Hier",
        unread: 3,
        avatar: "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :group
      },
      %{
        id: 6,
        name: "M. David N.",
        subtitle: "Anglais",
        last_message: "Hello Christian, comment vas-tu ?",
        time: "Lun.",
        unread: 0,
        avatar: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :user
      },
      %{
        id: 7,
        name: "Aline D.",
        subtitle: "Élève • Première S",
        last_message: "Je n'ai pas compris cette partie...",
        time: "Dim.",
        unread: 0,
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80",
        online: false,
        type: :user
      }
    ]

    active_contact = %{
      name: "M. Franck T.",
      role: "Mathématiques",
      verified: true,
      online: true,
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80"
    }

    messages = [
      %{
        id: 1,
        sender: :contact,
        text: "Salut Christian ! 👋\nComment se passe ta révision ?",
        time: "11:28",
        file: nil,
        image: nil
      },
      %{
        id: 2,
        sender: :user,
        text: "Salut ! Ça va, j'avance bien.",
        time: "11:29",
        file: nil,
        image: nil
      },
      %{
        id: 3,
        sender: :contact,
        text: "Regarde ce schéma explicatif :",
        time: "11:30",
        file: nil,
        image: "https://tse4.mm.bing.net/th/id/OIP.sHZD-YhGEOB3M5gaun1AmwHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
      },
      %{
        id: 4,
        sender: :user,
        text: "Ah d'accord, c'est beaucoup plus clair !",
        time: "11:31",
        file: nil,
        image: nil
      },
      %{
        id: 5,
        sender: :contact,
        text: "Je te joins également la fiche de synthèse au format PDF.",
        time: "11:32",
        file: %{name: "Correction_Exercice_3.pdf", size: "1.8 Mo"},
        image: nil
      },
      %{
        id: 6,
        sender: :user,
        text: "Parfait ! Merci beaucoup 🙏",
        time: "11:33",
        file: nil,
        image: nil
      }
    ]

    socket
    |> assign(:conversations, conversations)
    |> assign(:active_contact, active_contact)
    |> assign(:messages, messages)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="h-[calc(100vh-6rem)] bg-white dark:bg-slate-900 border border-slate-200/80 dark:border-slate-800 rounded-3xl overflow-hidden shadow-xs grid grid-cols-1 md:grid-cols-12">

        <!-- ================= COLONNE 1 : LISTE DES CONVERSATIONS (25% -> col-span-3) ================= -->
        <div class="col-span-12 md:col-span-3 border-r border-slate-200/80 dark:border-slate-800 flex flex-col bg-white dark:bg-slate-900 h-full overflow-hidden">
          <!-- Header Messages -->
          <div class="p-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between shrink-0">
            <h1 class="font-extrabold text-base text-slate-900 dark:text-slate-100 tracking-tight">Messages</h1>
            <button class="w-8 h-8 bg-indigo-50 dark:bg-indigo-950/50 hover:bg-indigo-100 dark:hover:bg-indigo-900 text-indigo-600 dark:text-indigo-400 rounded-xl flex items-center justify-center transition-colors cursor-pointer shadow-2xs">
              <.icon name="hero-pencil-square" class="w-4 h-4" />
            </button>
          </div>

          <!-- Recherche & Filtres -->
          <div class="p-3 border-b border-slate-100 dark:border-slate-800 space-y-2.5 shrink-0">
            <div class="relative">
              <.icon name="hero-magnifying-glass" class="w-4 h-4 text-slate-400 dark:text-slate-500 absolute left-3 top-2.5" />
              <input
                type="text"
                placeholder="Rechercher..."
                class="w-full bg-slate-100/80 dark:bg-slate-800/80 border border-slate-200/80 dark:border-slate-700/80 rounded-xl pl-9 pr-3 py-1.5 text-xs text-slate-700 dark:text-slate-200 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:bg-white dark:focus:bg-slate-800 transition-all placeholder:text-slate-400"
              />
            </div>

            <!-- Onglets de filtres -->
            <div class="flex items-center gap-1.5 overflow-x-auto scrollbar-none pb-0.5">
              <% filters = [%{id: :toutes, label: "Toutes"}, %{id: :non_lues, label: "Non lues", badge: "5"}, %{id: :groupes, label: "Groupes"}] %>
              <%= for f <- filters do %>
                <button
                  phx-click="change_filter"
                  phx-value-filter={f.id}
                  class={[
                    "px-2.5 py-1 rounded-xl text-[11px] font-bold transition-colors cursor-pointer flex items-center gap-1 shrink-0",
                    @active_filter == f.id
                      && "bg-indigo-600 text-white shadow-xs"
                      || "bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700"
                  ]}
                >
                  <span>{f.label}</span>
                  <%= if Map.get(f, :badge) do %>
                    <span class={["px-1.5 py-0.2 rounded-full text-[9px]", @active_filter == f.id && "bg-white text-indigo-600 font-black" || "bg-indigo-600 text-white font-bold"]}>{f.badge}</span>
                  <% end %>
                </button>
              <% end %>
            </div>
          </div>

          <!-- Liste scrollable -->
          <div class="flex-1 overflow-y-auto divide-y divide-slate-100 dark:divide-slate-800 scrollbar-none">
            <%= for convo <- @conversations do %>
              <div
                phx-click="select_conversation"
                phx-value-id={convo.id}
                class={[
                  "p-3 flex items-center gap-3 transition-colors cursor-pointer",
                  @selected_conversation_id == convo.id && "bg-indigo-50/60 dark:bg-indigo-950/40 border-l-4 border-indigo-600" || "hover:bg-slate-50 dark:hover:bg-slate-800/50"
                ]}
              >
                <div class="relative shrink-0">
                  <img src={convo.avatar} class="w-10 h-10 rounded-xl object-cover" />
                  <%= if convo.online do %>
                    <span class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-white dark:border-slate-900 rounded-full"></span>
                  <% end %>
                </div>

                <div class="flex-1 min-w-0">
                  <div class="flex items-center justify-between mb-0.5">
                    <h3 class="font-bold text-xs text-slate-900 dark:text-slate-100 truncate">{convo.name}</h3>
                    <span class="text-[9px] text-slate-400 dark:text-slate-500 shrink-0">{convo.time}</span>
                  </div>
                  <p class="text-[11px] text-slate-500 dark:text-slate-400 truncate">{convo.subtitle}</p>
                </div>

                <%= if convo.unread > 0 do %>
                  <span class="w-4 h-4 bg-indigo-600 text-white rounded-full flex items-center justify-center text-[9px] font-black shrink-0 shadow-xs">
                    {convo.unread}
                  </span>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>

        <!-- ================= COLONNE 2 : ZONE DE DISCUSSION (75% -> col-span-9) ================= -->
        <div class="hidden md:flex col-span-9 flex-col bg-[#efeae2]/40 dark:bg-slate-950 h-full overflow-hidden">

          <!-- En-tête chat actif (Fixe en haut) -->
          <div class="px-5 py-3 bg-white dark:bg-slate-900 border-b border-slate-200/80 dark:border-slate-800 flex items-center justify-between shadow-2xs shrink-0">
            <div class="flex items-center gap-3">
              <div class="relative">
                <img src={@active_contact.avatar} class="w-9 h-9 rounded-xl object-cover" />
                <span class="absolute bottom-0 right-0 w-2.5 h-2.5 bg-emerald-500 border-2 border-white dark:border-slate-900 rounded-full"></span>
              </div>
              <div>
                <h2 class="font-bold text-xs text-slate-900 dark:text-slate-100">{@active_contact.name}</h2>
                <p class="text-[9px] text-slate-500 dark:text-slate-400 font-medium">{@active_contact.role} • <span class="text-emerald-600 dark:text-emerald-400 font-bold">En ligne</span></p>
              </div>
            </div>

            <div class="flex items-center gap-1">
              <button class="p-1.5 text-slate-500 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors cursor-pointer">
                <.icon name="hero-phone" class="w-4 h-4" />
              </button>
              <button class="p-1.5 text-slate-500 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors cursor-pointer">
                <.icon name="hero-video-camera" class="w-4 h-4" />
              </button>
              <button class="p-1.5 text-slate-500 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors cursor-pointer">
                <.icon name="hero-ellipsis-horizontal" class="w-4 h-4" />
              </button>
            </div>
          </div>

          <!-- Fil de messages (Compact style WhatsApp) -->
          <div class="flex-1 overflow-y-auto px-6 py-4 space-y-3">
            <div class="text-center my-1">
              <span class="px-2.5 py-0.5 bg-slate-200/70 dark:bg-slate-800 text-slate-600 dark:text-slate-300 rounded-md text-[9px] font-bold shadow-2xs">AUJOURD'HUI</span>
            </div>

            <%= for msg <- @messages do %>
              <%= if msg.sender == :contact do %>
                <!-- Message reçu (compact) -->
                <div class="flex items-end gap-2 max-w-[65%]">
                  <div class="bg-white dark:bg-slate-900 border border-slate-200/70 dark:border-slate-800 rounded-2xl rounded-bl-xs px-3 py-2 shadow-2xs text-xs text-slate-800 dark:text-slate-200 space-y-1.5">
                    <%= if msg.text != "" do %>
                      <p class="leading-snug whitespace-pre-line">{msg.text}</p>
                    <% end %>

                    <%= if msg.image do %>
                      <div class="rounded-lg overflow-hidden max-w-xs bg-slate-100 dark:bg-slate-800 border border-slate-100 dark:border-slate-800">
                        <img src={msg.image} class="w-full h-auto object-cover max-h-48 cursor-pointer" />
                      </div>
                    <% end %>

                    <%= if msg.file do %>
                      <div class="flex items-center gap-2 bg-slate-50 dark:bg-slate-800/80 px-2.5 py-1.5 rounded-lg border border-slate-200/60 dark:border-slate-700 cursor-pointer">
                        <div class="w-7 h-7 bg-rose-50 dark:bg-rose-950/50 text-rose-500 rounded-md flex items-center justify-center font-bold shrink-0">
                          <.icon name="hero-document-text" class="w-3.5 h-3.5" />
                        </div>
                        <div class="flex-1 min-w-0">
                          <p class="font-bold text-[10px] text-slate-900 dark:text-slate-100 truncate">{msg.file.name}</p>
                          <p class="text-[8px] text-slate-500 dark:text-slate-400">{msg.file.size}</p>
                        </div>
                        <.icon name="hero-arrow-down-tray" class="w-3.5 h-3.5 text-slate-400 dark:text-slate-500" />
                      </div>
                    <% end %>

                    <div class="text-right">
                      <span class="text-[8px] text-slate-400 dark:text-slate-500">{msg.time}</span>
                    </div>
                  </div>
                </div>
              <% else %>
                <!-- Message envoyé (compact) -->
                <div class="flex flex-col items-end ml-auto max-w-[65%]">
                  <div class="bg-[#d9fdd3] dark:bg-emerald-900/80 border border-[#cfeec9] dark:border-emerald-800 text-slate-900 dark:text-slate-100 rounded-2xl rounded-br-xs px-3 py-2 shadow-2xs text-xs space-y-1.5">
                    <%= if msg.text != "" do %>
                      <p class="leading-snug whitespace-pre-line">{msg.text}</p>
                    <% end %>

                    <%= if msg.image do %>
                      <div class="rounded-lg overflow-hidden max-w-xs border border-emerald-200 dark:border-emerald-700">
                        <img src={msg.image} class="w-full h-auto object-cover max-h-48 cursor-pointer" />
                      </div>
                    <% end %>

                    <%= if msg.file do %>
                      <div class="flex items-center gap-2 bg-emerald-100/60 dark:bg-emerald-800/60 px-2.5 py-1.5 rounded-lg border border-emerald-200/60 dark:border-emerald-700 cursor-pointer">
                        <div class="w-7 h-7 bg-white dark:bg-emerald-950 text-rose-500 rounded-md flex items-center justify-center font-bold shrink-0">
                          <.icon name="hero-document-text" class="w-3.5 h-3.5" />
                        </div>
                        <div class="flex-1 min-w-0">
                          <p class="font-bold text-[10px] text-slate-900 dark:text-slate-100 truncate">{msg.file.name}</p>
                          <p class="text-[8px] text-emerald-700 dark:text-emerald-300">{msg.file.size}</p>
                        </div>
                        <.icon name="hero-arrow-down-tray" class="w-3.5 h-3.5 text-emerald-700 dark:text-emerald-300" />
                      </div>
                    <% end %>

                    <div class="flex items-center justify-end gap-1 pt-0.5">
                      <span class="text-[8px] text-slate-500 dark:text-slate-300">{msg.time}</span>
                      <.icon name="hero-check-badge" class="w-3 h-3 text-sky-600 dark:text-sky-400" />
                    </div>
                  </div>
                </div>
              <% end %>
            <% end %>
          </div>

          <!-- Saisie message (Fixe en bas) -->
          <div class="p-3 bg-white dark:bg-slate-900 border-t border-slate-200/80 dark:border-slate-800 shrink-0">
            <div class="flex items-center gap-2 bg-slate-100/85 dark:bg-slate-800 border border-slate-200/80 dark:border-slate-700 rounded-xl px-3 py-1.5 focus-within:bg-white dark:focus-within:bg-slate-900 focus-within:ring-2 focus-within:ring-indigo-500/20 transition-all">
              <button class="text-slate-400 dark:text-slate-500 hover:text-slate-600 dark:hover:text-slate-300 cursor-pointer">
                <.icon name="hero-paper-clip" class="w-4 h-4 rotate-45" />
              </button>
              <input
                type="text"
                value={@message_input}
                phx-keyup="update_message"
                name="message_input"
                placeholder="Tapez un message..."
                class="w-full bg-transparent text-xs text-slate-700 dark:text-slate-200 focus:outline-none placeholder:text-slate-400 dark:placeholder:text-slate-500"
              />
              <button class="text-slate-400 dark:text-slate-500 hover:text-slate-600 dark:hover:text-slate-300 cursor-pointer">
                <.icon name="hero-face-smile" class="w-4 h-4" />
              </button>
              <button phx-click="send_message" class="w-8 h-8 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg flex items-center justify-center shadow-xs transition-colors cursor-pointer shrink-0">
                <.icon name="hero-paper-airplane" class="w-3.5 h-3.5" />
              </button>
            </div>
          </div>

        </div>

      </div>
    </Layouts.app>
    """
  end
end
