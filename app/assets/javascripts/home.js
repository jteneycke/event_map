$(document).ready(function(){

  var mapOptions = {
    center: new google.maps.LatLng(43.6529083,-79.3981501),
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP
    };

  var infoWindow = new google.maps.InfoWindow();
  var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

  $.getJSON('/events.json', function(data) { 
    $.each( data.events, function(i, value) {

      var myLatlng = new google.maps.LatLng(value.latitude, value.longitude);
      var infowindow = new google.maps.InfoWindow({
        content: value.body
      }); 

      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: value.title
      });

      google.maps.event.addListener(marker, 'click', function() {
        $("#event_details").html(value.body)
        console.log(value.body)
      });

    });
  });

})
