# Use an official Elixir runtime as a parent image
FROM elixir:1.11.2

# Adicionando pacotes básicos
RUN apt-get update
RUN apt-get install -y postgresql-client ncurses-dev imagemagick libc-dev openssh-server git gcc inotify-tools

# Adicionando NodeJS
ENV NODE_VERSION=15.3.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Create code directory and copy the Elixir projects into it
RUN mkdir /code
COPY . /code
WORKDIR /code

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.7 --force

# Compile the project
RUN cd /code/assets
RUN npm i
RUN cd /code


RUN mix deps.get
RUN mix deps.compile
RUN mix do compile

CMD ["/code/entrypoint.sh"]
