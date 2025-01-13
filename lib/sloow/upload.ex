defmodule Sloow.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    field :name, :string
    field :description, :string
    field :file, :string
    field :size, :integer
    field :status, :string
    field :uploaded_at, :utc_datetime
    belongs_to :user, Sloow.Accounts.User
  end

  # def changeset(upload, params) do
  #   upload
  #   |> cast(params, [:file])
  #   |> validate_required([:file])
  # end

  def create_upload_changeset(upload, params) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    upload
    |> cast(params, [:name, :description, :file, :user_id])
    |> validate_required([:name, :file, :user_id])
    |> put_change(:uploaded_at, now)
  end

  @spec create_upload(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_upload(params) do
    %Sloow.Upload{}
    |> Sloow.Upload.create_upload_changeset(params)
    |> Sloow.Repo.insert()
  end

  def update_description_changeset(upload, params) do
    upload
    |> cast(params, [:description])
    |> validate_required([:description])
  end

  def update_description(upload, params) do
    upload
    |> Sloow.Upload.update_description_changeset(params)
    |> Sloow.Repo.update()
  end
end
