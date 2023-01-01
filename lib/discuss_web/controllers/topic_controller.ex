defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topic
  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Discuss.Topic.changeset(struct, params)
    render conn, "new.html", changeset: changeset
  end
end
