defmodule SloowWeb.FileUploadLive do
  alias Module.Types.Descr
  use SloowWeb, :live_view

  alias Sloow.Uploads

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1>Upload a File</h1>

    <form phx-submit="save" phx-change="validate">
      <label for="description">Description:</label>
      <input type="text" name="name" value={@description} />
      <.live_file_input live_file_input upload={@uploads.file} />
      <button type="submit">Upload</button>
    </form>

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
     |> assign(:description, "")
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
  def handle_event("save", _params, socket) do
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
            :description => socket.assigns.description
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

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end
end
