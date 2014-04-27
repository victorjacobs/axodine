//= require d3

// Bar chart for the things
(function() {
    $(document).ready(function() {
        //var user = $.getUrlVar('user');

        $.get("/data/playsperday?user=vikking", function(data) {
            for (var key in data) {
                $("#chart").append(intToDay(key) + ": " + data[key] + " <br />");
            }
        });
    });

    var intToDay = function(num) {
        switch(parseInt(num)) {
            case 0: return "Sunday";
            case 1: return "Monday";
            case 2: return "Tuesday";
            case 3: return "Wednesday";
            case 4: return "Thursday";
            case 5: return "Friday";
            case 6: return "Saturday";
        }
    }
})();