// Asynchronously sends requests to /scrape/go to scrape profile
(function() {
    // Wait for DOM to settle
    $(document).ready(function() {
        if (window.location.pathname !== "/scrape")
            return;

        var user = $.getUrlVar('user');

        if (user === "")
            return;

        var URL = "/scrape/go?user=" + user;
        //var URL = "/scrape/sl?user=vikking";
        var step = 1;

        var callback = function (data) {
            if (parseInt(data) >= 100) {
                alert("done");
                return;
            }

            $("#scrape-progress").css("width", data + "%");
            $("#indicator").html(data + "%");

            $.get(URL + "&step=" + step , callback);

            step++;
        };

        $.get(URL + "&step=" + step, callback);
    })
})();