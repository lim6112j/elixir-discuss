defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topic
  alias Discuss.Repo

  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Discuss.Topic.changeset(struct, params)
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def create(_conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    IO.inspect(changeset, label: "Inspecting.................")

    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post, label: "POST ..............")
      {:error, changeset} -> IO.inspect(changeset, label: "Changeset ...........")
    end
  end
end
