const apiKey = 'a38447fc4acdf9bd9b3c5605b2fc5df9';
const serchButton =  document.getElementById("search");
const wish =  document.getElementById("wishes");

serchButton.onclick = function(){
    const locations =  document.getElementById("city").value;
    fetch(`https://api.openweathermap.org/data/2.5/weather?q=${locations}&appid=${apiKey}`)
    .then((data)=>data.json())
    .then((jsonData) => {
        document.getElementById("location").innerHTML = `<b> ${jsonData.name}</b>`;
        document.getElementById("temperature").innerHTML =`<b> ${(Math.round(jsonData.main.temp-273.15))}&#8451</b>`;
        document.getElementById("weatherData").innerHTML = `<b> ${jsonData.weather[0].description}</b>` ;
    })
    .catch((error)=>{
        const notFoundImage = "url('notFound.jpg')"
        document.getElementById("location").innerHTML = "City name not found";
        document.body.style.backgroundImage = notFoundImage;
        document.getElementById("temperature").innerHTML =``;
        document.getElementById("weatherData").innerHTML = `` ;
    })
}

window.onload = function(){
    var day = new Date();
    const hr = day.getHours();
     if (hr >= 0 && hr < 12) {
         document.getElementById("wishes").innerHTML = "Good Morning";
     } else if (hr == 12) {
         document.getElementById("wishes").innerHTML = "Good Noon";
     } else if (hr >= 12 && hr <= 17) {
         document.getElementById("wishes").innerHTML = "Good Afternoon";
     } else {
         document.getElementById("wishes").innerHTML = "Good Evening";
     }
}

