defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topic
  alias Discuss.Repo

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Discuss.Topic.changeset(struct, params)
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "task modified")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    IO.inspect(changeset, label: "Inspecting.................")

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "created task")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
