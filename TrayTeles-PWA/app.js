
(function() {
  'use strict';

  var app = {
    isLoading: true,
    visibleCards: {},
    selectedCities: [],
    cardTemplate: document.querySelector('.cardTemplate'),
    container: document.querySelector('.main'),
  };

  document.getElementById('butRefresh').addEventListener('click', function() {
     app.updateForecastCard({});
  });

  // Updates a weather card with the latest weather forecast. If the card
  // doesn't already exist, it's cloned from the template.
  app.updateForecastCard = function(data) {
    var card = app.visibleCards[data.key];
    if (!card) {
	    var date = new Date();
	    var dia = date.getDate();
	    var hora = date.getHours();
      var segundos = date.getSeconds();
      card = app.cardTemplate.cloneNode(true);
      card.classList.remove('cardTemplate');
      card.querySelector('.location').textContent =  dia * hora;
      console.log(dia*hora);
      card.removeAttribute('hidden');
      app.container.appendChild(card);
      app.visibleCards[data.key] = card;
    }
    else {
      window.location.reload();
    }
    if (app.isLoading) {
      app.container.removeAttribute('hidden');
      app.isLoading = false;
    }
  };

  app.getForecast = function(key, label) {
        app.updateForecastCard({});
  };

  // TODO add startup code here
  app.selectedCities = localStorage.selectedCities;
  if (app.selectedCities) {
    app.selectedCities = JSON.parse(app.selectedCities);
    app.selectedCities.forEach(function(city) {
      app.getForecast(city.key, city.label);
    });
  } else {
    /* The user is using the app for the first time, or the user has not
     * saved any cities, so show the user some fake data. A real app in this
     * scenario could guess the user's location via IP lookup and then inject
     * that data into the page.
     */
    app.updateForecastCard({});
    //app.selectedCities = [{key: initialWeatherForecast.key, label: initialWeatherForecast.label}];
    //app.saveSelectedCities();
  }

  // TODO add service worker code here
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker
             .register('service-worker.js')
             .then(function() { console.log('Service Worker Registered'); });
  }
})();
