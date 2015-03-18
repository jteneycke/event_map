$(document).ready(function(){

  var mapOptions = {
    center: new google.maps.LatLng(43.6529083,-79.3981501),
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP
    };

  var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

  $.getJSON('/events.json', function(data) { 
    $.each( data.events, function(i, value) {

      var myLatlng = new google.maps.LatLng(value.latitude, value.longitude);
      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: value.title
      });

      var template = $('#template').html();
      var details = {
        title:   value.title,
        venue:   value.venue,
        address: value.address,
        time:    value.time,
        content: value.body
      }

      var rendered = Mustache.render(template, details)
  
      google.maps.event.addListener(marker, 'click', function() {
        $("#event_details").html(rendered)
      });

    });
  });

})
