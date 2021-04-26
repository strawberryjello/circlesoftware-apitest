const app = document.getElementById("root");

const container = document.createElement("div");
container.setAttribute("class", "container");

app.appendChild(container);

var request = new XMLHttpRequest();
request.open("GET", "/monthly_sales_reports", true);

request.onload = function() {
    var data = JSON.parse(this.response);
    if (request.status >= 200 && request.status < 400) {
        data.forEach((year) => {
            const header = document.createElement("h2");
            header.textContent = year[0];
            container.appendChild(header);

            const table = document.createElement("table");
            const thead = document.createElement("thead");
            const thRow = document.createElement("tr");

            const thMonth = document.createElement("th");
            thMonth.textContent = "Month";
            thRow.appendChild(thMonth);

            const thExSales = document.createElement("th");
            thExSales.textContent = "Total Ex Sales";
            thRow.appendChild(thExSales);

            const thProfit = document.createElement("th");
            thProfit.textContent = "Profit";
            thRow.appendChild(thProfit);

            thead.appendChild(thRow);
            table.appendChild(thead);

            const tbody = document.createElement("tbody");

            year[1].forEach((monthlyReport) => {
                const row = document.createElement("tr");

                const month = document.createElement("td");
                month.textContent = monthlyReport.month;
                row.appendChild(month);

                const totalExSales = document.createElement("td");
                totalExSales.textContent = monthlyReport.total_ex_sales;
                row.appendChild(totalExSales);

                const grossProfit = document.createElement("td");
                grossProfit.textContent = monthlyReport.gross_profit;
                row.appendChild(grossProfit);

                tbody.appendChild(row);
            });

            table.appendChild(tbody);
            container.appendChild(table);
        });

    } else {
        const errorMessage = document.createElement("div");
        errorMessage.textContent = request.status;
        app.appendChild(errorMessage);
    }
};

request.send();
