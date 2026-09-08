defmodule RepetoWeb.HomeLive123 do
  use RepetoWeb, :live_view

  def mount(_params,_session,socket) do
    Process.sleep(3000)

    socket =
      assign(socket,
      active_tab: "pour_toi",
      active_nav: :accueil,
      search_query: "",
      loaded: connected?(socket)
      )
    {:ok, socket}
  end

  def handle_event("set_tab",%{"tab" => tab}, socket)do
    {:noreply, assign(socket, active_tab: tab)}
 end
 def handle_event("updated_search", %{"search_query" => query}, socket)do
    {:noreply, assign(socket, search_query: query)}
  end

  def render(assigns) do
  ~H"""
  <Layouts.app flash={@flash} current_scope={assigns[:current_scope]} active_nav={@active_nav}>
      <div class="w-full max-w-1440px mx-auto px-3 sm:px-6 lg:px-8 lg:pb-12  ">
        <%= if !@loaded do %>
        <div class="flex flex-col items-center justify-center min-h-[60vh] space-y-4"  >
          <div class="w-12 h-12 border-4 border-indigo-600 border-t-transparent rounded-full animate-spin"></div>
          <p class="text-xs font-semibold text-slate-500 animate-pulse ">Chargement de ton espace Repeto</p>
        </div>
        <% else %>
        <div class="grid grid-cols-1 lg:grid-cols-[1fr_340px] xl:grid-cols-[1fr_380px] gap-4 sm:gap-6 items-start">
          <div class="space-y-4 sm:space-y-6 min-w-0  w-full "  >
          <div class="bg-white border border-slate-200/85 rounded-2xl  sm:rounded-3xl p-3 sm:p-5 shadow-xs space-y-3 sm:space-y-4 "  >
            <div class="flex items-center gap-2 sm:gap-3" >
                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100" class="w-9 h-9 sm:w-10 sm:h-10 rounded-full object-cover shrink-0 ring-2 ring-slate-100"/>
                <div class="w-full relative">
                <.form for={%{}} phx-change="updated_search" >
                  <input
                  type="text"
                  name="search_query"
                  value={@search_query}
                  placeholder="Que veut-tu partager aujourd'hui"
                  class="w-full bg-slate-50 hover:bg-slate-100/80 focus:bg-white border border-slate-200/80 rounded-xl sm:rounded-2xl  px-3.5 sm:px-4 py-2.5 text-xs placeholder-slate-400 focus:outline-none focusssss;ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all  "
                  />
                </.form>
                </div>
            </div>

            <%= if @search_query != "" do %>
              <div class="text-indigo-600 text-[11px] font-medium px-2 flex items-center  justify-between bg-indigo-50/50 py-1.5 rounded-lg" >
                <span> Recherche en cours pour : <strong> "{@search_query}"</strong></span>
                <button phx-click="updated_search"  phx-value-search_query=""   class="hover:underline text-slate-500 text-[10px]">Effacer</button>
              </div>
            <% end %>

            <div class="flex items-center justify-between pt-1 overflow-y-auto scrollbar-none gap-2 pb-1">
              <div class="flex items-center gap-1.5 sm:gap-2 shrink-0 "  >
                  <.action_pill icon="hero-question-mark-circle" label="Question" color="bg-emerald-50 text-indigo-600 hover:bg-indigo-100 "/>
                  <.action_pill icon="hero-book-open" label="Cours" color="bg-emerald-50 text-emerald-600 hover:bg-emerald-100 "   />
                  <.action_pill icon="hero-pencil-square" label="Exercice" color="bg-amber-50 text-amber-600 hover:bg-bg-amber-100" />
                  <.action_pill icon="hero-light-bulb" label="Quiz " color="bg-violet-50 text-violet-600 hover:bg-violet-100" />
                  <.action_pill icon="hero-video-camera" label="Video" color="bg-rose-50 text-rose-600 hover:bg-bg-rose-100"/>
                </div>
                <button class="text-slate-400 hover:text-slate-600 p-2 rounded-xl hover:bg-slate-50 transition-colors shrink-0 hidden sm:block"  >
                <.icon name="hero-ellipsis-horizontal" class="w-5 h-5" />
                </button>
            </div>
          </div>

              <div class="flex gap-4 sm:gap-6 border-b border-slate-200/85 px-2 overflow-y-auto scrollbar-none">
                <.tab_btn label="Pour toi" id="Pour_toi" active={@active_tab == "Pour_toi"}  />
                <.tab_btn label="Abonnements" id="abonnements" active={@active_tab == "abonnements"}/>
                <.tab_btn label="Communautes" id="communautes" active={@active_tab == "communautes"}  />
                <.tab_btn label="Tendances" id="tendances" active={@active_tab == "tendances"}/>
                </div>

                <div class="space-y-4 sm:space-y-6" >
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                    <article  class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-6 shadow-xs space-y-3 sm:space-y-4 "  >
                      <.post_header  name="M. FRANCK T" role="Repetiteur de mathematiques" time="2h" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" badge="hero-check-badge" />
                       <div class="space-y-2" >
                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-bold px-2.5  py-1 rounded-full inline-block" >Epreuves</span>
                        <h4 class="text-xs font-bold text-slate-900 " > Epreuves de Types Mathematiques Analyse-Algebres</h4>
                        <p class="text-xs text-slate-600 leading-relaxed">Voici un sujet Complet d'evaluation de mathematiques avec les exercices sur les fonctions et suites. Essayez de le résoudre avant la correction ! 👇 </p>
                      </div>
                      <div class="bg-slate-900/5 rounded-xl sm:rounded-2xl overflow-hidden border border-slate-200/80 p-2 flex justify-center" >
                        <img src="https://tse4.mm.bing.net/th/id/OIP.FQyVPKSAJU8Dr1EBnS0RJgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" class="w-full h-auto max-h-[300px] sm:max-h-[500px] object-contain rounded-lg sm:rounded-xl"/>
                      </div>
                      <.post_footer likes="1.2k" comments="86" shares="153" />
                    </article>
                </div>
          </div>
          <aside class="hidden lg:block  space-y-4 sm:space-y-6 lg:sticky lg:top-20 self-start max-h-[calc(100vh-6rem)] overflow-y-auto scrollbar-none " >
            <div class="bg-white border border-slate-200/85 rounded-2xl sm:rounded-3xl p-4 sm:p-5 shadow-xs space-y-4 " >
              <div class="flex items-center justify-between" >
                <h4 class="font-bold text-xs text-slate-900" >Repetiteurs Recommandes pour toi</h4>
                <a href={~p"/repetiteurs"} class="text-[11px] font-semibold text-indigo-600 ">Voir Tout</a>
              </div>
              <div class="space-y-4" >
                  <.tutor_row name="M. David N" subject="Mathematiques" rating="4.9(128 avis)" mode="A domicile & En ligne" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" />
                  <.tutor_row name="M. David N" subject="Mathematiques" rating="4.9(128 avis)" mode="A domicile & En ligne" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" />
                  <.tutor_row name="M. David N" subject="Mathematiques" rating="4.9(128 avis)" mode="A domicile & En ligne" avatar="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100" />
              </div>
            </div>
          </aside>
        </div>
         <%end %>
      </div>

  </Layouts.app>
  """
end
    attr :icon, :string , required: true
    attr :label, :string , required: true
    attr :color , :string , required: true

    def action_pill(assigns) do
     ~H"""
      <button class= {["flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs font-semibold shrink-0 transition-colors cursor-pointer",@color]}>
        <.icon name={@icon} class="w-4 h-4" />
        <span> {@label} </span>
      </button>
    """
    end

    attr :id ,:string , required: true
    attr :label ,:string , required: true
    attr :active , :boolean , default: false


    def tab_btn(assigns) do
      ~H"""
      <button phx-click="set_tab" phx-value-tab={@id} class={["pb-3 text-xs font-bold transition-colors border-b-2 shrink-0 curosr-pointer whitespace-nowrap",@active && "border-indigo-600 text-indigo-600",!@active && "border-transparent text-slate-400 hover:text-slate-600"]}>
      {@label}
      </button>
      """
    end

    attr :name, :string, required: true
    attr :role, :string, required: true
    attr :time, :string, required: true
    attr :avatar, :string, required: true
    attr :badge, :string , required: true

    def post_header(assigns) do
      ~H"""
      <div class="flex items-center justify-between gap-2" >
        <div class="flex items-center gap-2.5 sm:gap-3 min-w-0" >
          <img src={@avatar}  class="w-9 h-9 sm:w-10 sm:h-10 rounded-full object-cover ring-2 ring-slate-100 shrink-0"/>
          <div class="min-h-0" >
          <div class="flex items-center gap-1.5"  >
            <h5 class="text-xs font-bold text-slate-900 truncate" >{@name}</h5>
            <%= if @badge do %>
              <.icon name={@badge} class="w-4 h-4 text-indigo-600 fill-indigo-50 shrink-0"  />
            <% end %>
          </div>
          <p  class="text-[10px] text-slate-400 truncate" > {@role} * <span class="text-slate-600 font-medium" >{@time}</span> </p>
          </div>
        </div>
        <div class="flex items-center gap-1.5 sm:gap-2 shrink-0 "  >
          <button class="bg-indigo-50 hover:bg-indigo-100 text-indigo-600 font-semibold px-3 py-1.5 rounded-xl text-xs transition-colors ">Suivre</button>
          <button  class="text-slate-400 hover:text-slate-600 p-1.5 rounded-xl hover:bg-slate-50 transition-colors hidden sm:block " >
            <.icon name="hero-ellipsis-horizontal"  class="w-5 h-5" />
          </button>
        </div>
      </div>
      """
    end


    attr :likes, :string , required: true
    attr :comments, :string,required: true
    attr :shares, :string , required: true

  def post_footer(assigns)do
    ~H"""
      <div class="flex items-center justify-between pt-3 border-t border-slate-100 text-slate-500 text-xs font-semibold "  >
        <button class="flex items-center gap-1.5 hover:text-rose-600 transition-colors " >
          <.icon name="hero-heart-solid" class="w-4 h-4 text-rose-500" /> <span> {@likes} </span>
        </button>
        <button class="flex items-center gap-1.5 hover:text-indigo-600 transition-colors"  >
          <.icon name="hero-chat-bubble-left"  class="w-4 h-4"/>  <span> {@comments} </span>
        </button>
        <button  class="flex items-center gap-1.5 hover:text-indigo-600 transition-colors" >
          <.icon name="hero-share"  class="w-4 h-4" />
        </button>
        <button class="text-slate-400 hover:text-slate-600 hidden:sm-block" >
          <.icon name="hero-bookmark"  class="w-4 h-4" />
        </button>
      </div>
    """
  end
  attr :name, :string, required: true
  attr :subject , :string, required: true
  attr :rating , :string, required: true
  attr :mode , :string , required: true
  attr :avatar, :string , required: true

  def tutor_row(assigns)do
    ~H"""
    <div class="flex items-center justify-between gap-3" >
        <div class="flex items-center gap-3 overflow-hidden min-w-0" >
          <img src={@avatar} class="w-9 h-9 rounded-full object-cover shrink-0 ring-1 ring-slate-100"/>
          <div class="truncate min-w-0" >
            <h5 class="text-xs font-bold text-slate-900 truncate" >{@name}</h5>
            <p  class="text-[10px] text-slate-500 truncate">{@subject}</p>
            <p class="text-[10px] text-amber-500 font-semibold flex items-center gap-1 truncate " >⭐ {@rating}  <span class="text-slate-400 font-normal truncate" >*{@mode}</span> </p>
          </div>
        </div>
    </div>
    """
  end


end
