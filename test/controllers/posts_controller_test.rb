require 'helper'
require 'dummy/init'

class PostsControllerTest < ActionController::TestCase
  def test_show
    get :show, params: { id: 1 }

    expected = "<p>\n  Hello!\n</p>"
    assert_equal expected, response.body
  end
end
