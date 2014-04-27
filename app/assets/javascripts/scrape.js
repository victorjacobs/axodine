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

        var callback = function (data) {
            if (isNaN(data)) {
                $("#bar").remove();
                $("#message").html('<div class="alert alert-error">' + data + '</div>');
                return;
            }

            $("#scrape-progress").css("width", data + "%");
            $("#indicator").html(data + "%");

            if (parseInt(data) >= 100) {
                $("#message").html('<div class="alert alert-success">Scrape succesful</div>');
                return;
            }

            $.get(URL , callback);
        };

        $.get(URL, callback);
    })
})();