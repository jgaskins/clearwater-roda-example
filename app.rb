require 'bundler/setup'
Bundler.require
require 'roda'
require 'clearwater'
require 'slim'

$:.unshift 'shared'
Opal.append_paths 'shared'
require 'components/layout'

class App < Roda
  plugin :render, engine: 'slim'
  plugin :assets, js: {
    clearwater: 'clearwater_app.rb',
    react_compiled: 'react_app.js',
  }, js_opts: {
    builder: Opal::Builder.new
  }

  route do |r|
    r.assets

    r.on 'react' do
      @framework = 'React'
      view 'react'
    end

    @framework = 'Clearwater'
    view 'index'
  end

  # Server rendering
  def prerender
    start = Time.now
    store = store()
    router = Clearwater::Router.new(location: { pathname: request.path }) do
      route 'sign_in' => SignIn.new(store)
      route 'register' => UserRegistration.new(store)
    end
    app = Clearwater::Application.new(
      component: Layout.new(store),
      router: router,
    )
    html = app.render
    finish = Time.now
    puts "Prerendered in #{(finish - start) * 1000}ms\n"
    html
  end

  def store
    @store ||= Store.new(
      session: {
        current_user: nil,
      },
    )
  end

  Store = Struct.new(:state)
end
