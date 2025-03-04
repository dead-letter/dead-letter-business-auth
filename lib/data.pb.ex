defmodule Data.User do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:id, 1, type: :string)
  field(:created_at, 2, type: Google.Protobuf.Timestamp, json_name: "createdAt")
  field(:email, 3, type: :string)
end

defmodule Data.UserResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:user, 1, type: Data.User)
end

defmodule Data.CreateUserRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:email, 1, type: :string)
  field(:password, 2, type: :string)
end

defmodule Data.GetUserByEmailRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:email, 1, type: :string)
end

defmodule Data.AuthenticateUserRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:email, 1, type: :string)
  field(:password, 2, type: :string)
end

defmodule Data.UpdateUserRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:id, 1, type: :string)
  field(:email, 2, type: :string)
  field(:password_hash, 3, type: :string, json_name: "passwordHash")
  field(:version, 4, type: :int32)
end

defmodule Data.DeleteUserRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field(:id, 1, type: :string)
end
