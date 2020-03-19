(function() {
  var element = document.querySelectorAll('span.icon')[0];
  var parent = element.parentElement;
  var body = document.body;

  var nav = document.createElement('nav');
  nav.innerHTML =
    '<a href="/"><img src="/assets/logo.png"><h1>Lunchtime Labs</h1></a>';

  parent.appendChild(nav);
})();
