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

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "task modified")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:info, "nothing changed")
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    IO.inspect(changeset, label: "Inspecting.................")

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "created task")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
