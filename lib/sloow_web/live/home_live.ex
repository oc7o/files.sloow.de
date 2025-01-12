defmodule SloowWeb.HomeLive do
  use SloowWeb, :live_view

  alias Sloow.Upload

  def render(assigns) do
    # <%= for Sloow.Upload |> Sloow.Repo.all do %>
    # <% end %>
    ~H"""
    <div class="h-56 grid grid-cols-3 gap-4 content-start">
      <%= for upload <- @sloow_uploads do %>
        <div class="max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
          <%= case Path.extname(upload.name) do %>
            <% ext when ext in [".jpeg", ".jpg", ".png"] -> %>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="w-7 h-7 text-gray-500 dark:text-gray-400 mb-3"
                viewBox="0 0 16 16"
              >
                <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0" />
                <path d="M1.5 2A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2zm13 1a.5.5 0 0 1 .5.5v6l-3.775-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12v.54L1 12.5v-9a.5.5 0 0 1 .5-.5z" />
              </svg>
            <% ".pdf" -> %>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="w-7 h-7 text-gray-500 dark:text-gray-400 mb-3"
                viewBox="0 0 16 16"
              >
                <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z" />
                <path d="M4.603 14.087a.8.8 0 0 1-.438-.42c-.195-.388-.13-.776.08-1.102.198-.307.526-.568.897-.787a7.7 7.7 0 0 1 1.482-.645 20 20 0 0 0 1.062-2.227 7.3 7.3 0 0 1-.43-1.295c-.086-.4-.119-.796-.046-1.136.075-.354.274-.672.65-.823.192-.077.4-.12.602-.077a.7.7 0 0 1 .477.365c.088.164.12.356.127.538.007.188-.012.396-.047.614-.084.51-.27 1.134-.52 1.794a11 11 0 0 0 .98 1.686 5.8 5.8 0 0 1 1.334.05c.364.066.734.195.96.465.12.144.193.32.2.518.007.192-.047.382-.138.563a1.04 1.04 0 0 1-.354.416.86.86 0 0 1-.51.138c-.331-.014-.654-.196-.933-.417a5.7 5.7 0 0 1-.911-.95 11.7 11.7 0 0 0-1.997.406 11.3 11.3 0 0 1-1.02 1.51c-.292.35-.609.656-.927.787a.8.8 0 0 1-.58.029m1.379-1.901q-.25.115-.459.238c-.328.194-.541.383-.647.547-.094.145-.096.25-.04.361q.016.032.026.044l.035-.012c.137-.056.355-.235.635-.572a8 8 0 0 0 .45-.606m1.64-1.33a13 13 0 0 1 1.01-.193 12 12 0 0 1-.51-.858 21 21 0 0 1-.5 1.05zm2.446.45q.226.245.435.41c.24.19.407.253.498.256a.1.1 0 0 0 .07-.015.3.3 0 0 0 .094-.125.44.44 0 0 0 .059-.2.1.1 0 0 0-.026-.063c-.052-.062-.2-.152-.518-.209a4 4 0 0 0-.612-.053zM8.078 7.8a7 7 0 0 0 .2-.828q.046-.282.038-.465a.6.6 0 0 0-.032-.198.5.5 0 0 0-.145.04c-.087.035-.158.106-.196.283-.04.192-.03.469.046.822q.036.167.09.346z" />
              </svg>
            <% ".zip" -> %>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="w-7 h-7 text-gray-500 dark:text-gray-400 mb-3"
                viewBox="0 0 16 16"
              >
                <path d="M5 7.5a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1v.938l.4 1.599a1 1 0 0 1-.416 1.074l-.93.62a1 1 0 0 1-1.11 0l-.929-.62a1 1 0 0 1-.415-1.074L5 8.438zm2 0H6v.938a1 1 0 0 1-.03.243l-.4 1.598.93.62.929-.62-.4-1.598A1 1 0 0 1 7 8.438z" />
                <path d="M14 4.5V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5zm-3 0A1.5 1.5 0 0 1 9.5 3V1h-2v1h-1v1h1v1h-1v1h1v1H6V5H5V4h1V3H5V2h1V1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5z" />
              </svg>
            <% _ -> %>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="w-7 h-7 text-gray-500 dark:text-gray-400 mb-3"
                viewBox="0 0 16 16"
              >
                <path d="M14 4.5V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5zm-3 0A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5z" />
              </svg>
          <% end %>
          <a href="#">
            <h5 class="mb-2 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white">
              <%= upload.name %>
            </h5>
          </a>
          <p :if={upload.description} class="mb-3 font-normal text-gray-500 dark:text-gray-400">
            <%= upload.description %>
          </p>
          <a
            href={upload.file}
            class="inline-flex font-medium items-center text-gray-500 dark:text-gray-400"
            download
          >
            Download
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              fill="currentColor"
              class="ms-1.5"
              viewBox="0 0 16 16"
            >
              <path d="M4.406 1.342A5.53 5.53 0 0 1 8 0c2.69 0 4.923 2 5.166 4.579C14.758 4.804 16 6.137 16 7.773 16 9.569 14.502 11 12.687 11H10a.5.5 0 0 1 0-1h2.688C13.979 10 15 8.988 15 7.773c0-1.216-1.02-2.228-2.313-2.228h-.5v-.5C12.188 2.825 10.328 1 8 1a4.53 4.53 0 0 0-2.941 1.1c-.757.652-1.153 1.438-1.153 2.055v.448l-.445.049C2.064 4.805 1 5.952 1 7.318 1 8.785 2.23 10 3.781 10H6a.5.5 0 0 1 0 1H3.781C1.708 11 0 9.366 0 7.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383" />
              <path d="M7.646 15.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 14.293V5.5a.5.5 0 0 0-1 0v8.793l-2.146-2.147a.5.5 0 0 0-.708.708z" />
            </svg>
          </a>
          <button
            :if={@current_user == upload.user}
            type="button"
            phx-click="delete_upload"
            phx-value-action={upload.id}
          >
            Delete
          </button>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    uploads =
      if connected?(socket),
        do: Sloow.Upload |> Sloow.Repo.all() |> Sloow.Repo.preload(:user),
        else: []

    socket = socket |> assign(:sloow_uploads, uploads)

    {:ok, socket}
  end

  def handle_event("delete_upload", params, socket) do
    upload = Sloow.Upload |> Sloow.Repo.get(params["action"])

    if socket.assigns.current_user == nil do
      {:reply, %{result: "You must be logged in to delete an upload."}, socket}
    else
      if socket.assigns.current_user.id == upload.user_id do
        try do
          File.rm!(
            Path.join(
              Application.app_dir(:sloow, "priv/static/"),
              upload.file
            )
          )
        rescue
          e ->
            nil
        end

        # TODO: delte file
        Sloow.Repo.delete!(upload)

        uploads = Sloow.Upload |> Sloow.Repo.all()

        socket = socket |> assign(:sloow_uploads, uploads)

        {:noreply, socket}
      else
        {:reply, %{result: "You must be the owner of an upload to delete it."}, socket}
      end
    end
  end
end
