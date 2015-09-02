require 'clearwater/component'

class Foo
  include Clearwater::Component

  def render
    div [
      'Foo',
      p(<<-EOP),
        This route shows some examples with nested routes. Refer to the
        Foo, Bar, Baz, and Quux components in shared/components/routing_example.rb.
      EOP
      nav([
        Link.new({ href: '/foo/bar', style: { padding: '5px 10px' } },
                 'Bar'),
        Link.new({ href: '/foo/baz', style: { padding: '5px 10px' } },
                 'Baz'),
      ]),
      outlet,
    ]
  end
end

class Bar
  include Clearwater::Component

  def render
    div [
      'Bar',
      p('This component is a terminal route. It has no outlet.'),
    ]
  end
end

class Baz
  include Clearwater::Component

  def render
    div [
      'Baz',
      div(input(onkeyup: method(:set_quux))),
      p(<<-EOP),
        The Baz component has an outlet, but notice it's a dynamic path
        segment ":quux" because it begins with a colon. Notice the URL
        changes as you type into the box.
      EOP
      outlet,
    ]
  end

  def set_quux event
    router.navigate_to "/foo/baz/#{event.target.value}"
  end
end

class Quux
  include Clearwater::Component

  def render
    div [
      h1(params[:quux].gsub(/\%(\w{2})/) { $1.to_i(16).chr }),
    ]
  end
end
