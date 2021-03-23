<template>
    <card type="plain" title="Google Maps">
      <div id="map" class="map">
      </div>
    <div class="modal-footer">
      <base-button style="overflow: visible" type="primary" class="ml-auto" @click="saveLocation();">
        Save Location
      </base-button>
    </div>
    </card>
</template>
<script>
import Api from '../api';

export default {
  mounted() {
    this.myLatlng = new window.google.maps.LatLng(40.748817, -73.985428);
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          this.myLatlng = new window.google.maps.LatLng(pos.lat, pos.lng);
          map.center = new window.google.maps.LatLng(pos.lat, pos.lng);
        },
        () => {
          handleLocationError(true, infoWindow, map.getCenter());
        }
      );
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    }
    let mapOptions = {
      zoom: 13,
      center: this.myLatlng,
      scrollwheel: false, //we disable de scroll over the map, it is a really annoing when you scroll through page
      styles: [{
        "elementType": "geometry",
        "stylers": [{
          "color": "#1d2c4d"
        }]
      },
        {
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#8ec3b9"
          }]
        },
        {
          "elementType": "labels.text.stroke",
          "stylers": [{
            "color": "#1a3646"
          }]
        },
        {
          "featureType": "administrative.country",
          "elementType": "geometry.stroke",
          "stylers": [{
            "color": "#4b6878"
          }]
        },
        {
          "featureType": "administrative.land_parcel",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#64779e"
          }]
        },
        {
          "featureType": "administrative.province",
          "elementType": "geometry.stroke",
          "stylers": [{
            "color": "#4b6878"
          }]
        },
        {
          "featureType": "landscape.man_made",
          "elementType": "geometry.stroke",
          "stylers": [{
            "color": "#334e87"
          }]
        },
        {
          "featureType": "landscape.natural",
          "elementType": "geometry",
          "stylers": [{
            "color": "#023e58"
          }]
        },
        {
          "featureType": "poi",
          "elementType": "geometry",
          "stylers": [{
            "color": "#283d6a"
          }]
        },
        {
          "featureType": "poi",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#6f9ba5"
          }]
        },
        {
          "featureType": "poi",
          "elementType": "labels.text.stroke",
          "stylers": [{
            "color": "#1d2c4d"
          }]
        },
        {
          "featureType": "poi.park",
          "elementType": "geometry.fill",
          "stylers": [{
            "color": "#023e58"
          }]
        },
        {
          "featureType": "poi.park",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#3C7680"
          }]
        },
        {
          "featureType": "road",
          "elementType": "geometry",
          "stylers": [{
            "color": "#304a7d"
          }]
        },
        {
          "featureType": "road",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#98a5be"
          }]
        },
        {
          "featureType": "road",
          "elementType": "labels.text.stroke",
          "stylers": [{
            "color": "#1d2c4d"
          }]
        },
        {
          "featureType": "road.highway",
          "elementType": "geometry",
          "stylers": [{
            "color": "#2c6675"
          }]
        },
        {
          "featureType": "road.highway",
          "elementType": "geometry.fill",
          "stylers": [{
            "color": "#9d2a80"
          }]
        },
        {
          "featureType": "road.highway",
          "elementType": "geometry.stroke",
          "stylers": [{
            "color": "#9d2a80"
          }]
        },
        {
          "featureType": "road.highway",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#b0d5ce"
          }]
        },
        {
          "featureType": "road.highway",
          "elementType": "labels.text.stroke",
          "stylers": [{
            "color": "#023e58"
          }]
        },
        {
          "featureType": "transit",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#98a5be"
          }]
        },
        {
          "featureType": "transit",
          "elementType": "labels.text.stroke",
          "stylers": [{
            "color": "#1d2c4d"
          }]
        },
        {
          "featureType": "transit.line",
          "elementType": "geometry.fill",
          "stylers": [{
            "color": "#283d6a"
          }]
        },
        {
          "featureType": "transit.station",
          "elementType": "geometry",
          "stylers": [{
            "color": "#3a4762"
          }]
        },
        {
          "featureType": "water",
          "elementType": "geometry",
          "stylers": [{
            "color": "#0e1626"
          }]
        },
        {
          "featureType": "water",
          "elementType": "labels.text.fill",
          "stylers": [{
            "color": "#4e6d70"
          }]
        }
      ]
    };
    this.map = new window.google.maps.Map(
      document.getElementById("map"),
      mapOptions
    );
    this.map.addListener("click", (e) => {
      this.placeMarkerAndPanTo(e.latLng);
    });
  

    this.marker = new window.google.maps.Marker({
        position: this.myLatlng,
        title: "Hello World!"
      });
    // To add the marker to the map, call setMap();
    this.marker.setMap(this.map);
  },
  data () {
    return {
      mostRecentMarker: '',
      marker: Object,
      myLatlng: Object,
      map: Object,
      showSuccess: false
    }
  },
  methods: {
    placeMarkerAndPanTo(latLng) {
      this.marker.setMap(null)
      this.marker = new google.maps.Marker({
        position: latLng,
        map: this.map,
      });
      this.myLatlng = latLng
      // this.map.panTo(latLng);
      this.mostRecentMarker = latLng;
  },
    saveLocation() {
      const geocoder = new google.maps.Geocoder();

      geocoder.geocode({ location: this.mostRecentMarker }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
           let formattedAddress = {
             address: results[0].formatted_address,
             lat: this.mostRecentMarker.lat(),
             long: this.mostRecentMarker.lng(),
             website: '',
             isopenaccess: true
           }
          //  console.log(formattedAddress)
            Api.createLocation(formattedAddress)
                .then(resp => {
                 if (resp.status === 201) {
                   this.$notify({type: 'success', horizontalAlign: 'center', message: `Successfully saved \"${formattedAddress.address}\" as a location!`})
                 } else {
                    this.$notify({type: 'danger', horizontalAlign: 'center', message: `Unable to save location`})
                 }
                })
          } else {
            window.alert("No results found");
          }
        } else {
          window.alert("Geocoder failed due to: " + status);
        }
      });
    }
  },
  watch: {
    myLatlng: function () {
      this.map.panTo(this.myLatlng);
    }
  }
};
</script>
<style>
</style>
