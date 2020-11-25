# Use an official Elixir runtime as a parent image
FROM elixir:1.11.2

RUN apt-get update
RUN apt-get install -y postgresql-client ncurses-dev imagemagick libc-dev openssh-server git gcc

# Create code directory and copy the Elixir projects into it
RUN mkdir /code
COPY . /code
WORKDIR /code

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.7 --force

# Compile the project
RUN mix deps.get
RUN mix deps.compile
RUN mix do compile

CMD ["/code/entrypoint.sh"]
