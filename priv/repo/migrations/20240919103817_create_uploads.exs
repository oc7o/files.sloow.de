defmodule Sloow.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :name, :string
      add :description, :string
      add :file, :string
      add :size, :integer
      add :status, :string
      add :uploaded_at, :utc_datetime
      add :user_id, references(:users), on_delete: :nullify
    end
  end
end
