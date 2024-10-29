require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
def setup
  @post = Post.create(title: "Another Post", description: "Another Post Description")
end

  test "should get index" do
    get posts_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
    assert_equal Post.count, 4
  end

  test "should get show" do
    get post_url(posts(:first_post))
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get show with setup" do
    get post_url(@post)
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get new" do
    get new_post_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

test "should get edit" do
  get edit_post_url(posts(:first_post))
  assert_response :success
  assert_equal 200, response.status
  assert_equal "text/html", response.media_type
  assert_equal "utf-8", response.charset
end

  test "should create a post" do
    assert_difference "Post.count", 1 do
      post posts_url, params:
      { post:{
        title: "Another Post",
        description: "Another Post Description"
        }}
    end
    assert_redirected_to post_url(Post.last)
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

test "should update a post" do
  patch post_url(posts(:first_post)), params:
  { post:{
    title: "Updated Post",
    description: "Updated Post Description"
    }}

  posts(:first_post).reload
  assert_redirected_to post_url(posts(:first_post))
  assert_response :found
  assert_equal "Updated Post", posts(:first_post).title
  assert_equal "Updated Post Description", posts(:first_post).description
  assert_equal 302, response.status
  assert_equal "text/html", response.media_type
  assert_equal "utf-8", response.charset
end

  test "should destroy a post" do
    assert_difference "Post.count", -1 do
      delete post_url(posts(:first_post))
    end
    assert_redirected_to posts_url
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end
end
