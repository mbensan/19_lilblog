require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
  def setup
    @one = posts(:first_post)
    @two = posts(:second_post)
    @three = posts(:third_post)
  end

  test "post index" do
    visit posts_path
    assert_content page, "Posts"
    assert_content page, @one.title
    assert_content page, @two.title
    assert_content page, @three.title
    # assert_content page, "Noticia inexistente"
  end

  test "post show" do
    # visitamos la pantalla inicial
    visit posts_path
    # seleccionamos la noticia que queremos ver
    click_link "Show #{@one.title}"
    # verificamos que la pantalla de detalle muestra la información correcta
    assert_content page, @one.title
    assert_content page, @one.description
  end

  test "new post" do
    # visitamos la pantalla inicial
    visit posts_path
    # seleccionamos el botón para crear una nueva noticia
    click_link "New post"
    # ingresamos los datos necesarios
    fill_in "post_title", with: "Nueva Noticia"
    fill_in "post_description", with: "Nueva descripción"
    # seleccionamos el botón para crear la noticia
    click_button "Create Post"
    # verificamos que la pantalla de inicio se vuelve a mostrar
    assert_content page, "Post was successfully created."
  end

  test "custom user flow" do
    # ingresamos a la ruta principal
    visit root_path
    # accedemos al post 3, y verificamos que existan sus atributos
    click_link "Show #{@three.title}"
    assert_content page, @three.title
    assert_content page, @three.description
    # verificamos que el botón de eliminar está presente
    assert_content page, "Destroy this post"
    # eliminamos el post 3
    click_button "Destroy this post"
    # verificamos que la pantalla de inicio se vuelve a mostrar
    assert_content page, "Posts"
    # verificamos que los otros post's siguen en la lista
    assert_content page, @one.title
    assert_content page, @two.title
    # ahora ingresamos al post 2
    click_link "Show #{@two.title}"
    # verificamos que el contenido esté presente
    assert_content page, @two.title
    assert_content page, @two.description
    # regresamos a la pantalla principal
    click_link "Back to posts"
    # ingresamos al post 1
    click_link "Show #{@two.title}"
  end

end