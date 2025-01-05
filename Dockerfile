# syntax=docker/dockerfile:1
# check=error=true

# Esta imagem Docker é projetada para produção, não para desenvolvimento.
# Use com Kamal ou construa e execute manualmente:
# docker build -t blog_maino .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<valor de config/master.key> --name blog_maino blog_maino

# Para um ambiente de desenvolvimento em contêiner, consulte Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Certifique-se de que RUBY_VERSION corresponda à versão do Ruby em .ruby-version
ARG RUBY_VERSION=3.2
FROM ruby:$RUBY_VERSION-bookworm AS base

# O aplicativo Rails reside aqui
WORKDIR /rails

# Instalar pacotes base
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Definir ambiente de produção
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Estágio de construção para reduzir o tamanho da imagem final
FROM base AS build

# Instalar pacotes necessários para construir gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copiar código do aplicativo
COPY . .

# Pré-compilar código do bootsnap para tempos de inicialização mais rápidos
RUN bundle exec bootsnap precompile app/ lib/

# Pré-compilar assets para produção sem exigir a chave secreta RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Estágio final para a imagem do aplicativo
FROM base

# Copiar artefatos construídos: gems, aplicativo
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Executar e possuir apenas os arquivos de tempo de execução como um usuário não-root para segurança
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# O ponto de entrada prepara o banco de dados.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Iniciar o servidor via Thruster por padrão, isso pode ser sobrescrito em tempo de execução
EXPOSE 3000
CMD ["./bin/thrust", "./bin/rails", "server"]
