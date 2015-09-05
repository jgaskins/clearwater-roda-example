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
    router = Clearwater::Router.new(location: { pathname: request.path }) do
      route 'sign_in' => SignIn.new
      route 'register' => UserRegistration.new
    end
    app = Clearwater::Application.new(
      component: Layout.new,
      router: router,
    )
    html = app.render
    finish = Time.now
    puts "Prerendered in #{(finish - start) * 1000}ms\n"
    html
  end
end
