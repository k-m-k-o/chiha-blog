require 'rouge/plugins/redcarpet'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

module MarkdownHelper
  def markdown(text)
    options = {
      hard_wrap:       true,
      space_after_headers: true,
    }

    extensions = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
    }

    unless @markdown
      # Redcarpet::Render::HTML => HTML に変更
      renderer = HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end
end