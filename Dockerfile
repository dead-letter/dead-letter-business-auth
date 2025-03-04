# Stage 1: Build stage
FROM elixir:1.18.0-alpine AS build

# Install system dependencies
RUN apk add --no-cache build-base git openssh-client

# Set the working directory
WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && mix local.rebar --force

# Cache Elixir dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Compile dependencies
RUN mix deps.compile

# Copy the rest of the application code
COPY . .

# Compile the application
RUN mix compile

# Release the application
RUN mix release --path /release

# Stage 2: Runtime stage
FROM alpine:3.18 AS runtime

# Install runtime dependencies
RUN apk add --no-cache bash openssl ncurses

# Set the working directory
WORKDIR /app

# Copy compiled release from the build stage
COPY --from=build /release .

# Expose port
EXPOSE 4000

# Start the application
CMD ["bin/auth_service", "start"]

