defmodule RepetoWeb.RegisterLive do
  use RepetoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:selected_role, :eleve)
      |> assign(:form_data, %{
        "fullname" => "",
        "email" => "",
        "phone" => "",
        "password" => "",
        "password_confirmation" => "",
        "accept_terms" => false,
        "receive_newsletter" => false
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("select_role", %{"role" => role}, socket) do
    {:noreply, assign(socket, :selected_role, String.to_existing_atom(role))}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, :form_data, user_params)}
  end

  @impl true
  def handle_event("save", %{"user" => user_params}, socket) do
    # Logique d'inscription ici
    {:noreply, assign(socket, :form_data, user_params)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-screen w-screen overflow-hidden bg-slate-950 flex items-center justify-center p-2 sm:p-4 font-sans relative">

      <!-- Vidéo YouTube globale en arrière-plan (visible, en boucle, sans son) -->
      <div class="absolute inset-0 pointer-events-none overflow-hidden z-0">
        <div class="absolute inset-0 bg-indigo-950/70 mix-blend-multiply z-10"></div>
        <div class="absolute inset-0 bg-black/40 z-10"></div>
        <iframe
          class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[300vw] h-[300vh] sm:w-[150vw] sm:h-[150vh] object-cover opacity-60 filter contrast-125"
          src="https://www.youtube-nocookie.com/embed/z8XmG5_0jKU?autoplay=1&mute=1&controls=0&loop=1&playlist=z8XmG5_0jKU&disablekb=1&modestbranding=1&showinfo=0"
          title="Fond Vidéo Repeto"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen>
        </iframe>
      </div>

      <!-- Conteneur Principal en plein écran sans scroll -->
      <div class="w-full max-w-6xl h-[94vh] max-h-[820px] bg-white/95 backdrop-blur-xl shadow-2xl rounded-3xl overflow-hidden grid grid-cols-1 lg:grid-cols-12 border border-white/20 relative z-20">

        <!-- Colonne de Gauche : Formulaire Complet -->
        <div class="lg:col-span-7 p-5 sm:p-7 bg-white/90 flex flex-col justify-between overflow-hidden">

          <!-- En-tête / Logo + Lien Connexion -->
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <div class="w-7 h-7 bg-indigo-600 rounded-xl flex items-center justify-center shadow-md">
                <span class="text-white font-black text-sm">R</span>
              </div>
              <div>
                <span class="text-sm font-black tracking-tight text-slate-900">Repeto</span>
                <p class="text-[9px] text-slate-500 font-medium">Learn together. Grow further.</p>
              </div>
            </div>

            <p class="text-[11px] text-slate-500">
              Déjà un compte ? <a href="#" class="font-bold text-indigo-600 hover:text-indigo-700 ml-1">Se connecter</a>
            </p>
          </div>

          <div class="max-w-lg w-full mx-auto space-y-2.5 my-auto">
            <div>
              <h2 class="text-base sm:text-lg font-black text-slate-900">Créer un compte</h2>
              <p class="text-[11px] text-slate-500">Sélectionnez votre profil et remplissez le formulaire.</p>
            </div>

            <!-- Formulaire principal -->
            <.form for={@form_data} id="register-form" phx-change="validate" phx-submit="save" class="space-y-2.5">

              <!-- Sélection du rôle -->
              <div class="space-y-1">
                <label class="block text-[11px] font-bold text-slate-700">Vous êtes :</label>
                <div class="grid grid-cols-2 sm:grid-cols-4 gap-2">

                  <% roles = [
                    %{id: :eleve, label: "Élève", icon: "hero-user"},
                    %{id: :parent, label: "Parent", icon: "hero-user-group"},
                    %{id: :repetiteur, label: "Répétiteur", icon: "hero-computer-desktop"},
                    %{id: :groupe, label: "Centre", icon: "hero-building-office-2"}
                  ] %>

                  <%= for role <- roles do %>
                    <button
                      type="button"
                      phx-click="select_role"
                      phx-value-role={role.id}
                      class={[
                        "relative p-2 rounded-xl border text-center transition-all flex flex-col items-center justify-center gap-1 cursor-pointer",
                        @selected_role == role.id
                          && "border-indigo-600 bg-indigo-50/50 ring-1 ring-indigo-600/30"
                          || "border-slate-200 hover:border-slate-300 bg-white"
                      ]}
                    >
                      <%= if @selected_role == role.id do %>
                        <div class="absolute top-1 right-1 w-3.5 h-3.5 bg-indigo-600 text-white rounded-full flex items-center justify-center text-[8px]">
                          <.icon name="hero-check" class="w-2.5 h-2.5" />
                        </div>
                      <% end %>
                      <div class={[
                        "w-4 h-4 rounded-lg flex items-center justify-center",
                        @selected_role == role.id && "text-indigo-600" || "text-slate-600"
                      ]}>
                        <.icon name={role.icon} class="w-3.5 h-3.5" />
                      </div>
                      <span class={["text-[10px] font-bold", @selected_role == role.id && "text-indigo-950" || "text-slate-700"]}>
                        {role.label}
                      </span>
                    </button>
                  <% end %>

                </div>
              </div>

              <!-- Champs inputs complets (Grille) -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <div class="space-y-0.5">
                  <label class="block text-[10px] font-bold text-slate-700">Nom complet</label>
                  <input
                    type="text"
                    name="user[fullname]"
                    value={@form_data["fullname"]}
                    placeholder="Jean Dupont"
                    class="w-full bg-slate-50/70 border border-slate-200 rounded-xl px-3 py-1.5 text-[11px] text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 transition-all placeholder:text-slate-400"
                  />
                </div>

                <div class="space-y-0.5">
                  <label class="block text-[10px] font-bold text-slate-700">E-mail</label>
                  <input
                    type="email"
                    name="user[email]"
                    value={@form_data["email"]}
                    placeholder="exemple@email.com"
                    class="w-full bg-slate-50/70 border border-slate-200 rounded-xl px-3 py-1.5 text-[11px] text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 transition-all placeholder:text-slate-400"
                  />
                </div>
              </div>

              <div class="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <div class="space-y-0.5">
                  <label class="block text-[10px] font-bold text-slate-700">Téléphone</label>
                  <input
                    type="text"
                    name="user[phone]"
                    value={@form_data["phone"]}
                    placeholder="+237 6..."
                    class="w-full bg-slate-50/70 border border-slate-200 rounded-xl px-3 py-1.5 text-[11px] text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 transition-all placeholder:text-slate-400"
                  />
                </div>

                <div class="space-y-0.5">
                  <label class="block text-[10px] font-bold text-slate-700">Mot de passe</label>
                  <input
                    type="password"
                    name="user[password]"
                    value={@form_data["password"]}
                    placeholder="••••••••"
                    class="w-full bg-slate-50/70 border border-slate-200 rounded-xl px-3 py-1.5 text-[11px] text-slate-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-600 transition-all placeholder:text-slate-400"
                  />
                </div>
              </div>

              <!-- Conditions -->
              <div class="pt-0.5">
                <label class="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    name="user[accept_terms]"
                    checked={@form_data["accept_terms"]}
                    class="rounded border-slate-300 text-indigo-600 focus:ring-indigo-500 w-3 h-3 cursor-pointer"
                  />
                  <span class="text-[10px] text-slate-600">
                    J'accepte les <a href="#" class="text-indigo-600 font-semibold hover:underline">Conditions d'utilisation</a> & la <a href="#" class="text-indigo-600 font-semibold hover:underline">Politique de confidentialité</a>.
                  </span>
                </label>
              </div>

              <!-- Bouton d'inscription -->
              <button
                type="submit"
                class="w-full py-2 px-4 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-[11px] rounded-xl shadow-md transition-colors cursor-pointer flex items-center justify-center gap-2"
              >
                <span>S'inscrire maintenant</span>
              </button>
            </.form>

            <!-- Séparateur minimaliste -->
            <div class="relative flex py-0.5 items-center">
              <div class="flex-grow border-t border-slate-200"></div>
              <span class="flex-shrink mx-3 text-slate-400 text-[10px] font-medium">ou continuer avec</span>
              <div class="flex-grow border-t border-slate-200"></div>
            </div>

            <!-- Boutons sociaux -->
            <div class="grid grid-cols-4 gap-2">
              <button type="button" class="flex items-center justify-center py-1.5 px-3 bg-white border border-slate-200 hover:bg-slate-50 rounded-xl transition-all shadow-2xs cursor-pointer">
                <svg class="w-3.5 h-3.5" viewBox="0 0 24 24">
                  <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                  <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                  <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
                  <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
                </svg>
              </button>

              <button type="button" class="flex items-center justify-center py-1.5 px-3 bg-white border border-slate-200 hover:bg-slate-50 rounded-xl transition-all shadow-2xs cursor-pointer">
                <svg class="w-3.5 h-3.5 text-[#1877F2]" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                </svg>
              </button>

              <button type="button" class="flex items-center justify-center py-1.5 px-3 bg-white border border-slate-200 hover:bg-slate-50 rounded-xl transition-all shadow-2xs cursor-pointer">
                <svg class="w-3.5 h-3.5 text-slate-900" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M15.97 5.04c.57-.69.96-1.65.85-2.61-.84.04-1.85.56-2.45 1.25-.53.59-.99 1.56-.86 2.5.95.08 1.91-.49 2.46-1.14z"/>
                </svg>
              </button>

              <button type="button" class="flex items-center justify-center py-1.5 px-3 bg-white border border-slate-200 hover:bg-slate-50 rounded-xl transition-all shadow-2xs cursor-pointer">
                <div class="grid grid-cols-2 gap-0.5 w-3 h-3">
                  <div class="bg-[#F25022]"></div>
                  <div class="bg-[#7FBA00]"></div>
                  <div class="bg-[#00A4EF]"></div>
                  <div class="bg-[#FFB900]"></div>
                </div>
              </button>
            </div>

          </div>

          <div class="text-center">
            <p class="text-[9px] text-slate-400">Repeto © 2026 — Tous droits réservés.</p>
          </div>

        </div>

        <!-- Colonne de Droite : Nouvelle Vidéo YouTube intégrée au-dessus des commentaires -->
        <div class="lg:col-span-5 bg-gradient-to-b from-indigo-950 via-indigo-900 to-indigo-950 p-4 text-white flex flex-col justify-between relative overflow-hidden">

          <div class="absolute -top-20 -right-20 w-64 h-64 bg-indigo-600/30 rounded-full blur-3xl pointer-events-none"></div>

          <!-- En-tête de la section de droite -->
          <div class="relative z-10 space-y-1">
            <span class="inline-block px-2.5 py-0.5 bg-white/10 backdrop-blur-md rounded-full text-[10px] font-bold text-indigo-200 border border-white/10">
              Découvrir le projet
            </span>
            <h1 class="text-sm sm:text-base font-black tracking-tight leading-snug">
              École Cameroun — Présentation officielle
            </h1>
          </div>

          <!-- LA NOUVELLE VIDÉO YOUTUBE INTÉGRÉE AU-DESSUS DES COMMENTAIRES/TÉMOIGNAGES -->
          <div class="relative z-10 my-2 w-full aspect-video rounded-xl overflow-hidden shadow-lg border border-white/20 bg-black">
            <iframe
              class="w-full h-full object-cover"
              src="https://www.youtube-nocookie.com/embed/5nOb3Q0bBSg?autoplay=1&mute=1&controls=1&loop=1&playlist=5nOb3Q0bBSg"
              title="Vidéo École Cameroun"
              frameborder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowfullscreen>
            </iframe>
          </div>

          <!-- Témoignages / Commentaires (Placés juste en dessous de la vidéo) -->
          <div class="relative z-10 space-y-1.5">
            <p class="text-[10px] font-bold text-indigo-200 uppercase tracking-wider">Avis & Témoignages</p>
            <div class="bg-white/10 backdrop-blur-md rounded-xl p-2 border border-white/10 space-y-0.5">
              <p class="text-[10px] text-indigo-100 italic leading-snug">
                "Grâce à Repeto, j'ai trouvé un super répétiteur en mathématiques. Mes notes ont explosé !"
              </p>
              <div class="flex items-center justify-between text-[9px] text-indigo-300">
                <span>Marc L., Élève</span>
                <span class="text-amber-400 font-bold">★ 5.0</span>
              </div>
            </div>

            <div class="bg-white/10 backdrop-blur-md rounded-xl p-2 border border-white/10 space-y-0.5">
              <p class="text-[10px] text-indigo-100 italic leading-snug">
                "Un suivi rigoureux et des profils vérifiés. En tant que parent, j'ai l'esprit tranquille."
              </p>
              <div class="flex items-center justify-between text-[9px] text-indigo-300">
                <span>Nadine K., Parent</span>
                <span class="text-amber-400 font-bold">★ 5.0</span>
              </div>
            </div>
          </div>

          <div class="relative z-10 flex items-center justify-between text-[9px] text-indigo-300 pt-1">
            <span>+ de 5 000 utilisateurs actifs</span>
            <span class="font-bold text-white">100% Vérifié</span>
          </div>

        </div>

      </div>
    </div>
    """
  end
end
