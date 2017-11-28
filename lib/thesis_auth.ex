defmodule Ziptail.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """

  @behaviour Thesis.Auth

  def page_is_editable?(conn) do
    user = Plug.Conn.get_session(conn, :user_id)
    cond do
      user == nil ->
        false
      true ->
        true
    end
  end
end
