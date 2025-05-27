
# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# Install the project into `/app`
WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Copy from the cache instead of linking since it's a mounted volume
ENV UV_LINK_MODE=copy

# Install the project's dependencies using the lockfile and settings
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=./contrib/block_generator/uv.lock,target=uv.lock \
    --mount=type=bind,source=./contrib/block_generator/pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev

ADD ./contrib/block_generator/block_generator.py block_generator.py
