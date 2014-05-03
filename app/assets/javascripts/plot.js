var Plot = (function() {
    var cls = function() {

    };

    cls.linePerMonth = function(target, data) {
        var ctx = $(target).get(0).getContext("2d");

        var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

        var labels = [];
        var dataSet = [];

        var ticker = 0;
        data.data.forEach(function (el) {
            var date = new Date(el.month);
            var label = (ticker % 2 == 0) ? monthNames[date.getMonth()] + " " + date.getFullYear() : "";

            labels.push(label);
            dataSet.push(el.count);

            ticker++;
        });

        var plotData = {
            labels: labels,
            datasets: [{data: dataSet}]
        };

        new Chart(ctx).Line(plotData, { datasetFill: false });
    };

    cls.barPerDay = function(target, data) {
        var ctx = $(target).get(0).getContext("2d");

        var labels = [];
        var dataSet = [];

        data.data.forEach(function (el) {
            labels.push(intToDay(el.day));
            dataSet.push(el.count);
        });

        var plotData = {
            labels: labels,
            datasets: [{data: dataSet}]
        };

        new Chart(ctx).Bar(plotData, { datasetFill: false });
    };

    // Helper things
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
    };

    return cls;
})();