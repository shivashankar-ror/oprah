class PostMailerTest < ActionMailer::TestCase
  def test_invite
    post = Post.new
    email = PostMailer.notification(Post.new)

    assert_emails 1 do
      email.deliver_now
    end

    expected = "<p>\n  Hello!\n</p>"
    assert_equal expected, email.body.to_s
  end
end
