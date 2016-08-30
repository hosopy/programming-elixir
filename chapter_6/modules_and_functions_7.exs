# Convert float to string
IO.puts :erlang.float_to_list(3.14)

# Get environment variable
IO.puts System.get_env("PATH")

# Extract file extension
IO.puts Path.extname("test.exs")

# Get current working directory
IO.puts System.cwd

# Convert JSON string to Elixir type
# https://github.com/devinus/poison
# Poison.decode!(~s({"name": "Devin Torres", "age": 27}), as: %Person{})
#  => %Person{name: "Devin Torres", age: 27}

# Execute command on current shell
IO.inspect System.cmd("echo", ["hello"])
