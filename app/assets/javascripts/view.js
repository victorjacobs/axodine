//= require chart.min
//= require plot

(function() {
    $(document).ready(function() {
        var user = window.location.pathname.split('/view/')[1];

        $.get("/data/" + user +  "/playsperday", function (data) {
            Plot.barPerDay("#chart-per-day", data);
        });

        $.get("/data/" + user +  "/playspermonth", function (data) {
            Plot.linePerMonth("#chart-per-month", data);
        });

        $("#artist").focus(function() {
            $("#artist").val("");
        });

        $("#artist").keydown(function (ev) {
            if (ev.which != 13) return;
            ev.preventDefault();

            var artist = $("#artist").val();
            $("#artist").blur();

            // Plot data
            $.get("/data/" + user +  "/artist/" + artist + "/playspermonth", function (data) {
                $("#chart-artist").show();
                Plot.linePerMonth("#chart-artist", data);
            });
        });
    });

})();