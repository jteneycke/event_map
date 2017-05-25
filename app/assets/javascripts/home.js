$(document).ready(function(){
  $(".navbar-form select").addClass("form-control")

    //var styles = [{"featureType":"all","elementType":"all","stylers":[{"saturation":-100},{"gamma":0.5}]}]

    // Extract this json to own module
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

  var categories = ["business", "comedy", "crafts", "fashion", "film", "food-drink", "galleries-museums", "music", "performing-arts", "social", "sports", "tech", "other", "", "today", "friday", "saturday", "this-weekend", "next-weekend", "this-week", "next-week", "", "business", "comedy", "crafts", "fashion", "film", "food-drink", "galleries-museums", "music", "performing-arts", "social", "sports", "tech", "other",  "today", "friday", "saturday", "this-weekend", "next-weekend", "this-week", "next-week"]

  // Let's use proper scoping and not put stuff on window.
  window.my_map = map

  // http://www.blogto.com/api/v2/events/?bundle_type=medium&date=2017-05-19&limit=9999&offset=0&ordering=-start_date_time
  var my_date = $(".my_date").data("date")
  //$.getJSON('/events.json?date='+ my_date, function(data) {
  $.getJSON("https://discover.universe.com/api/v2/discover_events?after=1495832400&before=1496030399&latitude=43.6383&limit=400&longitude=-79.4301", function(data) {
    $.each( data.discover_events, function(i, value) {

      value["description"] = value["description"].replace("\n", "<br><br>")

      var template = $('#template').html();
      var rendered = Mustache.render(template, value)

      map.addMarker({
        lat: value.latitude,
        lng: value.longitude,
        title: value.title,
        icon: "/" + _.sample(["yoga", "war", "wetlands", "windturbine"]) + ".png",
        click: function(e) {
          $("#event_details").html(rendered)
          $("#event_details a").attr('target', '_blank')
          $("#event_details").scrollTop(0)
        }
      });
    });

    // TODO: this is a hack. (componentDidMount much?)
    // trigger one that it doesn't look all blank to start
    var random_marker = _.sample(window.my_map.markers)
    google.maps.event.trigger(random_marker, 'click')
  })

})
