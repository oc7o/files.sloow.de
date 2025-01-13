defmodule SloowWeb.FileUploadLive do
  alias Module.Types.Descr
  use SloowWeb, :live_view

  alias Sloow.Uploads

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1>Upload a file</h1>

    <div class="w-full max-w-xs">
      <form
        class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
        phx-submit="save"
        phx-change="validate"
      >
        <div class="mb-4">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="description">
            Description
          </label>
          <input
            name="description"
            id="description"
            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
            type="text"
            placeholder="Description"
            phx-update="ignore"
          />
        </div>
        <div class="mb-6">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="upload_field">
            File
          </label>
          <.live_file_input
            live_file_input
            upload={@uploads.file}
            name="upload_field"
            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          />
        </div>
        <div class="flex items-center justify-between">
          <button
            class="bg-zinc-800 px-2 py-1 hover:bg-zinc-700/80 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
            type="submit"
          >
            Upload
          </button>

          <a
            class="inline-block align-baseline font-bold text-sm bg-zinc-200 px-2 py-1 rounded hover:bg-zinc-300/80"
            href="/"
          >
            Cancel
          </a>
        </div>
      </form>
      <p class="text-center text-gray-500 text-xs">
        Please only upload files you have the rights on.
      </p>
    </div>

    <%= for entry <- @uploads.file.entries do %>
      <div>
        <p>Uploading: <%= entry.client_name %></p>
      </div>
    <% end %>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:file,
       accept: ~w(.jpg .jpeg .png .pdf .zip),
       max_entries: 1,
       max_file_size: 10_000_000
     )}
  end

  # def handle_event("save", %{"file" => upload}, socket) do
  #   consume_uploaded_entries(socket, :file, fn %{path: path}, _entry ->
  #     # Process or move the file to your desired storage location
  #     destination_path = "uploads/#{Path.basename(path)}"
  #     File.cp(path, destination_path)
  #   end)

  #   {:noreply, socket}
  # end

  @impl Phoenix.LiveView
  def handle_event("save", params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :file, fn %{path: path}, entry ->
        dest =
          Path.join(
            Application.app_dir(:sloow, "priv/static/uploads"),
            Path.basename(path) <> Path.extname(entry.client_name)
          )

        created_upload =
          Sloow.Upload.create_upload(%{
            :name => Path.basename(entry.client_name),
            :file => "/uploads/" <> Path.basename(path) <> Path.extname(entry.client_name),
            :user_id => socket.assigns.current_user.id,
            :description => params["description"]
          })

        case created_upload do
          {:ok, _upload} ->
            # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
            File.cp!(path, dest)

            {:ok, ~p"/uploads/#{Path.basename(dest)}"}

          {:error, _changeset} ->
            {:error, :failed_to_upload}
        end
      end)

    {:noreply,
     socket |> update(:uploaded_files, &(&1 ++ uploaded_files)) |> push_navigate(to: "/")}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end
end
