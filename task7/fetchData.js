const API_key = 'ee46b1578821c7ae200ff68668dcee0f';

fetch("https://api.openweathermap.org/data/2.5/forecast?lat=17.48&lon=78.39&units=metric&appid=" + API_key)
    .then((data) => data.json())
    .then((jsonData) => {
        console.log(jsonData);

        // Assuming the first item in the list represents the current forecast
        const currentForecast = jsonData.list[0];

        document.getElementById("text_location").innerHTML = jsonData.city.name;
        document.getElementById("text_location_country").innerHTML = jsonData.city.country;

        document.getElementById("text_temp").innerHTML = Math.round(currentForecast.main.temp);
        document.getElementById("text_feels_like").innerHTML = Math.round(currentForecast.main.feels_like);

        document.getElementById("text_desc").innerHTML = currentForecast.weather[0].description;

        const weatherIcon = currentForecast.weather[0].icon;
        const iconUrl = `https://openweathermap.org/img/wn/${weatherIcon}.png`;
        document.getElementById("images").src = iconUrl;
    })
    .catch((error) => {
        console.error("Error fetching weather data:", error);
    });

