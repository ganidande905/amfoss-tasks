const API_key = 'c4834432744cab38d9628642a9309889';
const searchButton = document.getElementById("search");

searchButton.onclick = function () {
    const location = document.getElementById("city").value;

    
    fetch(`https://api.openweathermap.org/data/2.5/weather?q=${location}&units=metric&appid=${API_key}`)
        .then((response) => response.json())
        .then((jsonData) => {
            const currentWeather = jsonData.main;

            document.getElementById("text_location").innerHTML = jsonData.name;
            document.getElementById("text_location_country").innerHTML = jsonData.sys.country;

            document.getElementById("text_temp").innerHTML = Math.round(currentWeather.temp);
            document.getElementById("text_feels_like").innerHTML = Math.round(currentWeather.feels_like);

            document.getElementById("text_desc").innerHTML = jsonData.weather[0].description;

            const weatherIcon = jsonData.weather[0].icon;
            const iconUrl = `https://openweathermap.org/img/wn/${weatherIcon}.png`;
            document.getElementById("images").src = iconUrl;
        })
        .catch((error) => {
            console.error("Error fetching weather data:", error);
            document.getElementById("text_temp").innerHTML =``;
            document.getElementById("text_feels_like").innerHTML = `` ;
        });
};
