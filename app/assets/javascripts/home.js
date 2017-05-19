$(document).ready(function(){
  $(".navbar-form select").addClass("form-control")

    //var styles = [{"featureType":"all","elementType":"all","stylers":[{"saturation":-100},{"gamma":0.5}]}]

    var styles = [{
      "featureType": "landscape.man_made",
      "elementType": "geometry",
      "stylers": [{
        "color": "#f7f1df"
      }]
    },{
      "featureType": "landscape.natural",
      "elementType": "geometry",
      "stylers": [{
        "color": "#d0e3b4"
      }]
    },{
      "featureType": "landscape.natural.terrain",
      "elementType": "geometry",
      "stylers": [{
        "visibility": "off"
      }]
    },{
      "featureType": "poi",
      "elementType": "labels",
      "stylers": [{
        "visibility": "off"
      }]
    },{
      "featureType": "poi.business",
      "elementType": "all",
      "stylers": [{
        "visibility": "off"
      }]
    },{
      "featureType": "poi.medical",
      "elementType": "geometry",
      "stylers": [{
        "color": "#fbd3da"
      }]
    },{
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{
        "color": "#bde6ab"
      }]
    },{
      "featureType": "road",
      "elementType": "geometry.stroke",
      "stylers": [{
        "visibility": "off"
      }]
    },{
      "featureType": "road",
      "elementType": "labels",
      "stylers": [{
        "visibility": "off"
      }]
    },{
      "featureType": "road.highway",
      "elementType": "geometry.fill",
      "stylers": [{
        "color": "#ffe15f"
      }]
    },{
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [{
        "color": "#efd151"
      }]
    },{
      "featureType": "road.arterial",
      "elementType": "geometry.fill",
      "stylers": [{
        "color": "#ffffff"
      }]
    },{
      "featureType": "road.local",
      "elementType": "geometry.fill",
      "stylers": [{
        "color": "black"
      }]
    },{
      "featureType": "transit.station.airport",
      "elementType": "geometry.fill",
      "stylers": [{
        "color": "#cfb2db"
      }]
    },{
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{
        "color": "#a2daf2"
      }]
    }]


  var map = new GMaps({
    el: '#map_canvas',
    lat: 43.6529083,
    lng: -79.3981501,
    zoom: 14,
    styles: styles
  });

  window.my_map = map

  var my_date = $(".my_date").data("date")
  $.getJSON('/events.json?date='+ my_date, function(data) {

    window.event_listings = data.events

    $.each( data.events, function(i, value) {

      var template = $('#template').html();
      var rendered = Mustache.render(template, value)

      map.addMarker({
        lat: value.latitude,
        lng: value.longitude,
        title: value.title,
        //icon: "/" + _.sample(["yoga", "war", "wetlands", "windturbine"]) + ".png",
        click: function(e) {
          $("#event_details").html(rendered)
          $("#event_details a").attr('target', '_blank')
          $("#event_details").scrollTop(0)
        }
      });

    });

    // trigger one that it doesn't look all blank to start
    var random_marker = _.sample(window.my_map.markers)
    google.maps.event.trigger(random_marker, 'click')
  })

})
