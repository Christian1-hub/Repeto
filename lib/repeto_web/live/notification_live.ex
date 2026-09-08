defmodule RepetoWeb.NotificationLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_tab, "toutes")
      |> assign(:active_nav, "notifications")
      |> assign(:notifications, list_notifications())
      |> assign(:preferences, default_preferences())

    {:ok, socket}
  end

  @impl true
  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, :active_tab, tab)}
  end

  @impl true
  def handle_event("mark_all_read", _, socket) do
    updated_notifications = Enum.map(socket.assigns.notifications, &Map.put(&1, :read, true))
    {:noreply, assign(socket, :notifications, updated_notifications)}
  end

  @impl true
  def handle_event("toggle_pref", %{"key" => key}, socket) do
    prefs = socket.assigns.preferences
    updated_prefs = Map.update!(prefs, String.to_existing_atom(key), &(!&1))
    {:noreply, assign(socket, :preferences, updated_prefs)}
  end

  @impl true
  def handle_event("accept_invite", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("ignore_invite", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  defp list_notifications do
    [
      %{
        id: 1,
        section: "Aujourd'hui",
        type: "reponse",
        read: false,
        user: %{name: "M. Franck T.", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80"},
        text: "a répondu à votre question dans Mathématiques.",
        subtext: "Comment résoudre cette équation du second degré ?",
        time: "Il y a 2 minutes",
        preview_image: "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=300&auto=format&fit=crop&q=80",
        has_unread_dot: true
      },
      %{
        id: 2,
        section: "Aujourd'hui",
        type: "like",
        read: false,
        user: %{name: "Mme. Sarah B.", avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80"},
        text: "a aimé votre publication dans Physique-Chimie.",
        subtext: nil,
        time: "Il y a 15 minutes",
        preview_image: "https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=300&auto=format&fit=crop&q=80",
        has_unread_dot: true
      },
      %{
        id: 3,
        section: "Aujourd'hui",
        type: "invitation",
        read: false,
        user: %{name: "Excellence Academy", avatar: "https://images.unsplash.com/photo-1562774053-701939374585?w=150&auto=format&fit=crop&q=80"},
        text: "vous a invité(e) à rejoindre leur groupe.",
        subtext: "Groupe : Prépa Bac 2025",
        time: "Il y a 45 minutes",
        actions: true,
        has_unread_dot: true
      },
      %{
        id: 4,
        section: "Aujourd'hui",
        type: "follow",
        read: true,
        user: %{name: "David L.", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80"},
        text: "a commencé à vous suivre.",
        subtext: nil,
        time: "Il y a 1 heure",
        has_unread_dot: false
      },
      %{
        id: 5,
        section: "Aujourd'hui",
        type: "rappel",
        read: true,
        user: nil,
        text: "Rappel : Vous avez un cours dans 30 minutes",
        subtext: "Mathématiques – À domicile\nAujourd'hui à 16:00",
        time: "Il y a 1 heure",
        icon: "bell",
        has_unread_dot: false
      },
      %{
        id: 6,
        section: "Hier",
        type: "commentaire",
        read: true,
        user: %{name: "Aline D.", avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&auto=format&fit=crop&q=80"},
        text: "a commenté votre publication dans Mathématiques.",
        subtext: "Très bonne explication, merci beaucoup !",
        time: "Hier à 20:15",
        preview_image: "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=300&auto=format&fit=crop&q=80",
        has_unread_dot: false
      },
      %{
        id: 7,
        section: "Hier",
        type: "like",
        read: true,
        user: %{name: "Lucas M.", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80"},
        text: "a aimé votre réponse dans Physique-Chimie.",
        subtext: nil,
        time: "Il y a 8 heures",
        has_unread_dot: false
      },
      %{
        id: 8,
        section: "Hier",
        type: "groupe",
        read: true,
        user: nil,
        text: "Vous avez été ajouté(e) au groupe Mathématiques – Terminale C par M. Franck T.",
        subtext: nil,
        time: "Il y a 12 heures",
        has_unread_dot: false
      },
      %{
        id: 9,
        section: "Cette semaine",
        type: "badge",
        read: true,
        user: nil,
        text: "Félicitations ! Vous avez gagné le badge « Répondeur actif »",
        subtext: "Vous avez aidé 10 personnes avec vos réponses.",
        time: "Mar. à 18:30",
        badge_count: 10,
        has_unread_dot: false
      },
      %{
        id: 10,
        section: "Cette semaine",
        type: "paiement",
        read: true,
        user: nil,
        text: "Paiement confirmé",
        subtext: "Votre paiement pour le cours Mathématiques – Franck T. a été confirmé.",
        time: "Mar. à 14:22",
        has_unread_dot: false
      },
      %{
        id: 11,
        section: "Cette semaine",
        type: "avis",
        read: true,
        user: nil,
        text: "Votre avis sur M. Franck T. a été publié.",
        subtext: "Merci pour votre retour !",
        time: "Lun. à 10:05",
        has_unread_dot: false
      }
    ]
  end

  defp default_preferences do
    %{
      messages: true,
      reponses: true,
      mentions: true,
      likes: true,
      abonnes: true,
      invitations: true,
      cours: true,
      paiements: true,
      evenements: false,
      actualites: false,
      offres: false
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
    <div class="min-h-screen bg-gray-50 flex flex-col font-sans">
      <div class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-6 grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

        <!-- Colonne de gauche (Contenu principal) -->
        <div class="lg:col-span-2 space-y-6">

          <div class="flex items-center justify-between">
            <div>
              <h1 class="text-2xl font-bold text-gray-900">Notifications</h1>
              <p class="text-sm text-gray-500 mt-0.5">Restez informé de tout ce qui se passe sur Repeto.</p>
            </div>
            <div class="flex items-center space-x-4">
              <button phx-click="mark_all_read" class="text-xs font-medium text-indigo-600 hover:text-indigo-800 flex items-center gap-1">
                Tout marquer comme lu <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
              </button>
              <button class="text-xs font-medium text-gray-600 hover:text-gray-900 flex items-center gap-1">
                Paramètres <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 11-6 0 3 3 0 016 0z"></path></svg>
              </button>
            </div>
          </div>

          <div class="border-b border-gray-200 flex space-x-8 text-sm font-medium">
            <% tabs = [{"toutes", "Toutes"}, {"non_lues", "Non lues"}, {"mentions", "Mentions"}, {"reponses", "Réponses"}, {"cours", "Cours"}, {"systeme", "Système"}] %>
            <%= for {key, label} <- tabs do %>
              <button
                phx-click="set_tab"
                phx-value-tab={key}
                class={"pb-3 border-b-2 transition-colors flex items-center gap-1.5 #{if @active_tab == key, do: "border-indigo-600 text-indigo-600 font-semibold", else: "border-transparent text-gray-500 hover:text-gray-700"}"}>
                <%= label %>
              </button>
            <% end %>
          </div>

          <div class="space-y-6">

            <div>
              <h2 class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-3">Aujourd'hui</h2>

              <div class="space-y-3">
                <%= for notif <- @notifications |> Enum.filter(&(&1.section == "Aujourd'hui")) do %>
                  <div class={"relative bg-white rounded-xl p-4 shadow-sm border transition-all flex items-start justify-between gap-4 #{if !notif.read, do: "border-indigo-100 bg-indigo-50/20", else: "border-gray-100"}"}>

                    <div class="flex items-start space-x-3 flex-1">
                      <div class="w-10 h-10 rounded-full bg-indigo-100 flex items-center justify-center overflow-hidden font-bold text-indigo-700 flex-shrink-0">
                        <%= if notif.user && notif.user.avatar do %>
                          <img src={notif.user.avatar} alt={notif.user.name} class="w-full h-full object-cover" />
                        <% else %>
                          <%= if notif.user, do: String.slice(notif.user.name, 0, 2), else: "🔔" %>
                        <% end %>
                      </div>

                      <div class="flex-1 min-w-0">
                        <p class="text-sm text-gray-800">
                          <%= if notif.user do %>
                            <span class="font-semibold text-gray-900"><%= notif.user.name %></span>
                          <% end %>
                          <span><%= notif.text %></span>
                        </p>

                        <%= if notif.subtext do %>
                          <p class="text-xs text-gray-500 mt-1 whitespace-pre-line bg-gray-50 p-2 rounded border border-gray-100"><%= notif.subtext %></p>
                        <% end %>

                        <p class="text-[11px] text-gray-400 mt-1.5"><%= notif.time %></p>

                        <%= if Map.get(notif, :actions) do %>
                          <div class="flex items-center gap-2 mt-3">
                            <button phx-click="ignore_invite" phx-value-id={notif.id} class="px-3 py-1.5 text-xs font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors">Ignorer</button>
                            <button phx-click="accept_invite" phx-value-id={notif.id} class="px-3 py-1.5 text-xs font-medium text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg transition-colors">Accepter</button>
                          </div>
                        <% end %>
                      </div>
                    </div>

                    <%= if Map.get(notif, :preview_image) do %>
                      <div class="hidden sm:block flex-shrink-0 w-24 h-16 bg-gray-100 rounded-lg overflow-hidden border border-gray-200">
                        <img src={notif.preview_image} alt="Aperçu" class="w-full h-full object-cover" />
                      </div>
                    <% end %>

                    <div class="flex items-center space-x-2">
                      <%= if notif.has_unread_dot do %>
                        <span class="w-2.5 h-2.5 bg-indigo-600 rounded-full"></span>
                      <% end %>
                      <button class="text-gray-400 hover:text-gray-600 p-1">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"/></svg>
                      </button>
                    </div>

                  </div>
                <% end %>
              </div>
            </div>

            <div>
              <h2 class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-3">Hier</h2>

              <div class="space-y-3">
                <%= for notif <- @notifications |> Enum.filter(&(&1.section == "Hier")) do %>
                  <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100 flex items-start justify-between gap-4">
                    <div class="flex items-start space-x-3 flex-1">
                      <div class="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center overflow-hidden font-bold text-gray-700 flex-shrink-0">
                        <%= if notif.user && notif.user.avatar do %>
                          <img src={notif.user.avatar} alt={notif.user.name} class="w-full h-full object-cover" />
                        <% else %>
                          <%= if notif.user, do: String.slice(notif.user.name, 0, 2), else: "🔔" %>
                        <% end %>
                      </div>
                      <div class="flex-1 min-w-0">
                        <p class="text-sm text-gray-800">
                          <%= if notif.user do %>
                            <span class="font-semibold text-gray-900"><%= notif.user.name %></span>
                          <% end %>
                          <span><%= notif.text %></span>
                        </p>
                        <%= if notif.subtext do %>
                          <p class="text-xs text-gray-500 mt-1"><%= notif.subtext %></p>
                        <% end %>
                        <p class="text-[11px] text-gray-400 mt-1.5"><%= notif.time %></p>
                      </div>
                    </div>

                    <%= if Map.get(notif, :preview_image) do %>
                      <div class="hidden sm:block flex-shrink-0 w-24 h-16 bg-gray-100 rounded-lg overflow-hidden border border-gray-200">
                        <img src={notif.preview_image} alt="Aperçu" class="w-full h-full object-cover" />
                      </div>
                    <% end %>

                    <button class="text-gray-400 hover:text-gray-600 p-1"><svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"/></svg></button>
                  </div>
                <% end %>
              </div>
            </div>

            <div>
              <h2 class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-3">Cette semaine</h2>

              <div class="space-y-3">
                <%= for notif <- @notifications |> Enum.filter(&(&1.section == "Cette semaine")) do %>
                  <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100 flex items-start justify-between gap-4">
                    <div class="flex items-start space-x-3 flex-1">
                      <div class="w-10 h-10 rounded-xl bg-indigo-50 text-indigo-600 flex items-center justify-center flex-shrink-0">
                        <%= cond do %>
                          <% notif.type == "badge" -> %> 🏆
                          <% notif.type == "paiement" -> %> ✅
                          <% true -> %> ⭐
                        <% end %>
                      </div>
                      <div class="flex-1 min-w-0">
                        <p class="text-sm font-semibold text-gray-900"><%= notif.text %></p>
                        <p class="text-xs text-gray-500 mt-0.5"><%= notif.subtext %></p>
                        <p class="text-[11px] text-gray-400 mt-1.5"><%= notif.time %></p>
                      </div>
                    </div>

                    <%= if Map.get(notif, :badge_count) do %>
                      <div class="w-12 h-12 bg-indigo-600 rounded-xl flex flex-col items-center justify-center text-white font-bold shadow-md">
                        <span class="text-lg leading-none">10</span>
                      </div>
                    <% end %>

                    <button class="text-gray-400 hover:text-gray-600 p-1"><svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"/></svg></button>
                  </div>
                <% end %>
              </div>
            </div>

          </div>

          <div class="text-center pt-4">
            <button class="text-xs font-semibold text-indigo-600 hover:text-indigo-800 flex items-center justify-center gap-1 mx-auto">
              Voir les notifications plus anciennes <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
            </button>
          </div>

        </div>

        <!-- Colonne de droite (Fixe / Sticky) -->
        <div class="space-y-6 sticky top-6">

          <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-900 text-base mb-4">Résumé</h3>
            <div class="flex items-center justify-center py-2 bg-indigo-50/50 rounded-xl mb-6">
              <div class="text-center">
                <div class="w-12 h-12 bg-indigo-100 text-indigo-600 rounded-full flex items-center justify-center mx-auto mb-2 text-xl">🔔</div>
              </div>
            </div>
            <div class="space-y-3 text-sm">
              <div class="flex justify-between items-center text-gray-600">
                <span>Non lues</span>
                <span class="font-bold text-indigo-600 bg-indigo-50 px-2.5 py-0.5 rounded-full">3</span>
              </div>
              <div class="flex justify-between items-center text-gray-600">
                <span>Cette semaine</span>
                <span class="font-bold text-gray-900">27</span>
              </div>
              <div class="flex justify-between items-center text-gray-600">
                <span>Ce mois-ci</span>
                <span class="font-bold text-gray-900">112</span>
              </div>
            </div>
          </div>

          <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-900 text-base mb-1">Préférences de notifications</h3>
            <p class="text-xs text-gray-500 mb-4">Gérez ce pour quoi vous souhaitez être notifié.</p>

            <div class="space-y-3">
              <%= for {key, label} <- [
                {:messages, "Messages"},
                {:reponses, "Réponses à mes questions"},
                {:mentions, "Mentions"},
                {:likes, "Likes et réactions"},
                {:abonnes, "Nouveaux abonnés"},
                {:invitations, "Invitations de groupe"},
                {:cours, "Cours et rappels"},
                {:paiements, "Paiements et factures"},
                {:evenements, "Événements"},
                {:actualites, "Actualités Repeto"},
                {:offres, "Offres et promotions"}
              ] do %>
                <div class="flex items-center justify-between">
                  <span class="text-xs text-gray-700 font-medium"><%= label %></span>
                  <button
                    type="button"
                    phx-click="toggle_pref"
                    phx-value-key={key}
                    class={"relative inline-flex h-5 w-9 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none #{if Map.get(@preferences, key), do: "bg-indigo-600", else: "bg-gray-200"}"}>
                    <span class={"pointer-events-none inline-block h-4 w-4 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out #{if Map.get(@preferences, key), do: "translate-x-4", else: "translate-x-0"}"}></span>
                  </button>
                </div>
              <% end %>
            </div>

            <div class="mt-5 pt-4 border-t border-gray-100 text-center">
              <a href="#" class="text-xs font-semibold text-indigo-600 hover:text-indigo-800">Voir tous les paramètres</a>
            </div>
          </div>

        </div>

      </div>
    </div>
    </Layouts.app>
    """
  end
end
