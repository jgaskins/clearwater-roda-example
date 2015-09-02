require 'clearwater/component'
require 'clearwater/cached_render'

class Layout
  include Clearwater::Component

  def render
    div [
      nav([
        # Intra-app navigation uses Link components.
        Link.new({ href: '/', style: link_style }, 'Home'),
        Link.new({ href: '/sign_in', style: link_style }, 'Sign in'),
        Link.new({ href: '/register', style: link_style }, 'Register'),
        Link.new({ href: '/obnoxiously_huge_page', style: link_style },
                 'Obnoxiously Huge Page'),

        # Links to outside the Clearwater app use regular `a` tags
        a({ href: '/react' }, 'React App'),
      ]),
      outlet || home_page,
    ]
  end

  def home_page
    # Memoize the homepage so we can cache it
    @home_page ||= HomePage.new
  end

  def link_style
    {
      padding: '5px 10px',
    }
  end
end

class HomePage
  include Clearwater::Component

  # CachedRender stores virtual-DOM representation for efficient storage
  include Clearwater::CachedRender

  def render
    div [
      h1('Howdy!'),
      p('This is my website'),

      section(Link.new({ href: '/foo' }, 'Foo')),
    ]
  end
end

class ObnoxiouslyHugePage
  include Clearwater::Component

  def render
    # Intentionally render a 10k-element list to test performance.
    # When visiting the home page, notice it takes the browser a lot
    # longer to render the page than the console reports. This is the
    # browser recalculating styles. Clearwater renders faster than the
    # browser can keep up with. This is especially noticeable when you
    # use render caching with the Clearwater::CachedRender mixin.
    ul(Array.new(10_000) { |i|
      li(Link.new({ href: "/#{i}" }, "Item ##{i}"))
    })
  end
end
