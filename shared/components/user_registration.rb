class UserRegistration
  include Clearwater::Component

  attr_reader :email, :password

  def render
    div [
      h1('Register'),
      form({ onsubmit: SubmitUserRegistration.new(self) }, [
        div(
          input(
            type: :email,
            placeholder: 'email',
            onkeyup: method(:set_email),
            onblur: method(:has_entered_email!),
            style: {
              border_color: @valid_email ? 'green' : 'red',
            }
          )
        ),
        if @has_entered_email && !@valid_email
          div({ style: { color: 'red' } }, "Must provide a valid email")
        end,
        div(
          input(
            type: :password,
            placeholder: 'password',
            onkeyup: method(:set_password),
            onblur: method(:has_entered_password!),
            style: {
              border_color: @valid_password ? 'green' : 'red',
            },
          )
        ),
        if @has_entered_password && !@valid_password
          div({ style: { color: 'red' } }, "Password must be >= 8 characters")
        end,
        div(input(type: 'submit', value: 'Register!', disabled: !valid?)),
      ]),
    ]
  end

  def set_email event
    @email = event.target.value
    @valid_email = !!(@email =~ /[\w\.\+_]+@\w+\.\w+/)
    call # Component#call re-renders the app
  end

  def has_entered_email!
    @has_entered_email = true
  end

  def set_password event
    @password = event.target.value
    @valid_password = @password.to_s.length >= 8
    call
  end

  def has_entered_password!
    @has_entered_password = true
  end

  def valid?
    @valid_email && @valid_password
  end
end

class SubmitUserRegistration
  def initialize form
    @form = form
  end

  def call event
    event.prevent

    puts "Form submitted"
    p data
  end

  def data
    {
      email: @form.email,
      password: @form.password,
    }
  end
end
