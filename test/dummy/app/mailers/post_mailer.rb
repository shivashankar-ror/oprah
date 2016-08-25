class PostMailer < ApplicationMailer
  default from: 'bar@baz', to: 'foo@bar'

  def notification(post)
    @post = present(post)
    mail(subject: 'Foobar')
  end
end
