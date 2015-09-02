var Route = ReactRouter.Route;
var DefaultRoute = ReactRouter.DefaultRoute;
var Link = ReactRouter.Link;
var RouteHandler = ReactRouter.RouteHandler;

var Layout = React.createClass({
  render: function() {
    return (
      <div>
        <nav>
          <Link style={{ padding: '5px 10px' }} to='home'>Home</Link>
          <Link style={{ padding: '5px 10px' }} to='sign_in'>Sign in</Link>
          <Link style={{ padding: '5px 10px' }} to='register'>Register</Link>
          <Link style={{ padding: '5px 10px' }} to='obnoxiously_huge_page'>Obnoxiously Huge Page</Link>
          <a href='/'>Clearwater App</a>
        </nav>
        <RouteHandler />
      </div>
    );
  },
});

var SignIn = React.createClass({
  render: function() {
    return (
      <h1>Sign in</h1>
    );
  },
});

var UserRegistration = React.createClass({
  render: function() {
    return (
      <h1>Register</h1>
    );
  },
});

var HomePage = React.createClass({
  render: function() {
    return (
      <div>
        <h1>Howdy!</h1>
        <p>This is my website!</p>
      </div>
    );
  },
});

var ObnoxiouslyHugePage = React.createClass({
  render: function() {
    return (
      <ul>
        {this.listItems()}
      </ul>
    );
  },

  shouldComponentUpdate: function() {
    return false;
  },

  listItems: function() {
    var items = [];

    for(var i = 0; i < 10000; i++) {
      items.push(
        <li key={i}>
          <a href={"/" + i}>
            {'Item #' + i}
          </a>
        </li>
      );
    }

    return items;
  },
});

var routes = (
  <Route handler={Layout}>
    <DefaultRoute name='home' handler={HomePage} />
    <Route name='sign_in' path='sign_in' handler={SignIn} />
    <Route name='register' path='register' handler={UserRegistration} />
    <Route name='obnoxiously_huge_page' path='obnoxiously_huge_page' handler={ObnoxiouslyHugePage} />
  </Route>
);

var appContainer = document.getElementById('react-app');
ReactRouter.run(routes, function (Handler) {
  React.render(<Handler/>, appContainer);
});
