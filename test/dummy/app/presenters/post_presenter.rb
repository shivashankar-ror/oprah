class PostPresenter < Oprah::Presenter
  def paragraph(&block)
    h.content_tag(:p, &block)
  end
end
