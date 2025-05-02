defmodule OnboardnewWeb.WelcomeLive do
  use OnboardnewWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       active_section: "overview",
       page_loaded: true
     )}
  end

  def handle_event("show_section", %{"section" => section}, socket) do
    {:noreply, assign(socket, active_section: section)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-b from-blue-50 to-white">
      <div class={[
        "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12",
        if(@page_loaded, do: "animate-fade-in", else: "opacity-0")
      ]}>
        <!-- Hero Section -->
        <div class="text-center mb-16 space-y-8">
          <h1 class="text-5xl font-bold text-gray-900 mb-4 animate-slide-down">
            Welcome to Cosmofoil
          </h1>
          <p class="text-xl text-gray-600 max-w-3xl mx-auto animate-fade-in">
            Revolutionizing Airline Management with Next-Generation Solutions
          </p>
        </div>

        <!-- Navigation Tabs -->
        <div class="flex justify-center space-x-4 mb-12">
          <%= for {section, label} <- [
            {"overview", "Overview"},
            {"features", "Features"},
            {"benefits", "Benefits"}
          ] do %>
            <button
              phx-click="show_section"
              phx-value-section={section}
              class={[
                "px-6 py-2 rounded-full transition-all duration-300",
                @active_section == section && "bg-blue-600 text-white shadow-lg",
                @active_section != section && "bg-white text-gray-600 hover:bg-blue-50"
              ]}
            >
              <%= label %>
            </button>
          <% end %>
        </div>

        <!-- Content Sections -->
        <div class="max-w-4xl mx-auto">
          <div :if={@active_section == "overview"} class="animate-fade-in space-y-6">
            <div class="bg-white rounded-xl shadow-lg p-8 transform hover:scale-105 transition-transform duration-300">
              <h2 class="text-2xl font-semibold text-gray-800 mb-4">About Cosmofoil</h2>
              <p class="text-gray-600 leading-relaxed">
                Cosmofoil is a cutting-edge airline management platform designed to streamline operations,
                enhance passenger experience, and optimize resource utilization. Our platform combines
                advanced analytics, real-time monitoring, and intelligent automation to revolutionize
                how airlines operate in the modern era.
              </p>
            </div>
          </div>

          <div :if={@active_section == "features"} class="animate-fade-in space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <%= for {icon, title, description} <- [
                {"✈️", "Smart Scheduling", "AI-powered flight scheduling and optimization"},
                {"📊", "Real-time Analytics", "Live performance metrics and insights"},
                {"🔄", "Automated Operations", "Streamlined workflow automation"},
                {"👥", "Team Collaboration", "Enhanced communication tools"}
              ] do %>
                <div class="bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow duration-300">
                  <div class="text-3xl mb-2"><%= icon %></div>
                  <h3 class="text-xl font-semibold mb-2"><%= title %></h3>
                  <p class="text-gray-600"><%= description %></p>
                </div>
              <% end %>
            </div>
          </div>

          <div :if={@active_section == "benefits"} class="animate-fade-in">
            <div class="bg-white rounded-xl shadow-lg p-8">
              <h2 class="text-2xl font-semibold text-gray-800 mb-6">Why Choose Cosmofoil?</h2>
              <ul class="space-y-4">
                <%= for {benefit, description} <- [
                  {"Increased Efficiency", "Reduce operational costs by up to 30% through smart automation"},
                  {"Better Decision Making", "Make data-driven decisions with real-time insights"},
                  {"Enhanced Safety", "Implement robust safety protocols and monitoring"},
                  {"Improved Customer Experience", "Deliver exceptional service at every touchpoint"}
                ] do %>
                  <li class="flex items-start space-x-3">
                    <svg class="h-6 w-6 text-green-500 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <div>
                      <h3 class="font-semibold text-gray-800"><%= benefit %></h3>
                      <p class="text-gray-600"><%= description %></p>
                    </div>
                  </li>
                <% end %>
              </ul>
            </div>
          </div>
        </div>

        <!-- Footer -->
        <div class="mt-16 text-center text-gray-600">
          <p>Ready to transform your airline operations?</p>
          <button class="mt-4 px-8 py-3 bg-blue-600 text-white rounded-full hover:bg-blue-700 transition-colors duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
            Get Started
          </button>
        </div>
      </div>
    </div>
    """
  end
end
