class ArticleImportsJob < ApplicationJob
  queue_as :default

  def perform(file_path, author)
    content = File.read(file_path).strip
    articles = content.split("//")

    articles.each do |article|
      lines = article.strip.split("\n")
      next if lines.empty?

      title = lines[0]
      body = lines[1..].join("\n")
      Article.create!(title: title, rich_body: body, author: author)
    end
  rescue => e
    Rails.logger.error "Erro ao importar artigos: #{e.message}"
    raise e
  end
end
