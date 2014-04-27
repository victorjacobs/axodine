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

        var callback = function (data) {
            if (isNaN(data)) {
                $("#bar").remove();
                $("#message").html('<div class="alert alert-error">' + data + '</div>');
                return;
            }

            if (parseInt(data) >= 100) {
                alert("done");
                return;
            }

            $("#scrape-progress").css("width", data + "%");
            $("#indicator").html(data + "%");

            $.get(URL , callback);
        };

        $.get(URL, callback);
    })
})();