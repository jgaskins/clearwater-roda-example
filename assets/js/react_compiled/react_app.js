var Route = ReactRouter.Route;
var DefaultRoute = ReactRouter.DefaultRoute;
var Link = ReactRouter.Link;
var RouteHandler = ReactRouter.RouteHandler;

var Layout = React.createClass({displayName: "Layout",
  render: function() {
    return (
      React.createElement("div", null, 
        React.createElement("nav", null, 
          React.createElement(Link, {style: { padding: '5px 10px'}, to: "home"}, "Home"), 
          React.createElement(Link, {style: { padding: '5px 10px'}, to: "sign_in"}, "Sign in"), 
          React.createElement(Link, {style: { padding: '5px 10px'}, to: "register"}, "Register"), 
          React.createElement(Link, {style: { padding: '5px 10px'}, to: "obnoxiously_huge_page"}, "Obnoxiously Huge Page"), 
          React.createElement("a", {href: "/"}, "Clearwater App")
        ), 
        React.createElement(RouteHandler, null)
      )
    );
  },
});

var SignIn = React.createClass({displayName: "SignIn",
  render: function() {
    return (
      React.createElement("h1", null, "Sign in")
    );
  },
});

var UserRegistration = React.createClass({displayName: "UserRegistration",
  render: function() {
    return (
      React.createElement("h1", null, "Register")
    );
  },
});

var HomePage = React.createClass({displayName: "HomePage",
  render: function() {
    return (
      React.createElement("div", null, 
        React.createElement("h1", null, "Howdy!"), 
        React.createElement("p", null, "This is my website!")
      )
    );
  },
});

var ObnoxiouslyHugePage = React.createClass({displayName: "ObnoxiouslyHugePage",
  render: function() {
    return (
      React.createElement("ul", null, 
        this.listItems()
      )
    );
  },

  shouldComponentUpdate: function() {
    return false;
  },

  listItems: function() {
    var items = [];

    for(var i = 0; i < 10000; i++) {
      items.push(
        React.createElement("li", {key: i}, 
          React.createElement("a", {href: "/" + i}, 
            'Item #' + i
          )
        )
      );
    }

    return items;
  },
});

var routes = (
  React.createElement(Route, {handler: Layout}, 
    React.createElement(DefaultRoute, {name: "home", handler: HomePage}), 
    React.createElement(Route, {name: "sign_in", path: "sign_in", handler: SignIn}), 
    React.createElement(Route, {name: "register", path: "register", handler: UserRegistration}), 
    React.createElement(Route, {name: "obnoxiously_huge_page", path: "obnoxiously_huge_page", handler: ObnoxiouslyHugePage})
  )
);

var appContainer = document.getElementById('react-app');
ReactRouter.run(routes, function (Handler) {
  React.render(React.createElement(Handler, null), appContainer);
});
