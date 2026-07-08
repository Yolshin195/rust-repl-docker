FROM rust:1.96-slim-bookworm

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Создаем пользователя
RUN useradd -m rustuser

# Даем права пользователю на стандартные директории Rust, 
# чтобы он мог устанавливать пакеты в общесистемные пути
RUN chown -R rustuser:rustuser /usr/local/cargo /usr/local/rustup

# Переключаемся на пользователя
USER rustuser
WORKDIR /home/rustuser

# Установка (теперь работает с системным rustup)
RUN cargo install evcxr_repl

# Запуск
ENTRYPOINT ["evcxr"]
