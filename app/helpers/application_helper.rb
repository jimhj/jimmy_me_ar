# coding: utf-8
module ApplicationHelper

  def markdown(text)
    options = {   
      :autolink => true, 
      :space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(HTMLwithAlbino, options)
    markdown.render(h(text)).html_safe
  end

  class HTMLwithAlbino < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language, :formatter => 'html', :options => {:encoding => 'utf-8'})
    end
  end  

end
