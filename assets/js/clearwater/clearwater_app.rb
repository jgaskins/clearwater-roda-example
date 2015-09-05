require 'opal'
require 'clearwater'

require 'components/layout'
require 'components/sign_in'
require 'components/user_registration'

require 'components/routing_example'

router = Clearwater::Router.new do
  route 'sign_in' => SignIn.new
  route 'register' => UserRegistration.new
  route 'obnoxiously_huge_page' => ObnoxiouslyHugePage.new

  # This route has routes nested inside it. You can call `outlet` from
  # within the Foo component to get the component referenced by the URL
  # path.
  route 'foo' => Foo.new do
    route 'bar' => Bar.new
    route 'baz' => Baz.new do

      # This route uses a dynamic segment (denoted with a colon). This
      # type of route allows you to reference the named param via the
      # `params` hash inside any routed component. This one would be
      # `params[:quux]`.
      route ':quux' => Quux.new
    end
  end
end

app = Clearwater::Application.new(
  # This is your application's root component. I usually call it Layout,
  # since it essentially functions similarly to a Rails view layout.
  # This is the only required parameter.
  component: Layout.new,

  # Specifying a router is how you tell the application what routes to
  # use. You don't need to specify your router if you don't have multiple
  # routes.
  router: router,

  # This is the element into which your application will render. It must
  # exist on the page by the time this is executed or it will use the body
  # element. If you're using the `body` element anyway, you can omit this
  # parameter.
  element: $document['#clearwater-app'],
)

# If app.debug? is truthy, it will show debugging info, which right now
# is just the time to render to the virtual DOM and the time to patch to
# the actual DOM.
# def app.debug?
#   true
# end

# This will wire up the outlets for the current URL and render the
# application. The application will not be rendered until this is called.
app.call
