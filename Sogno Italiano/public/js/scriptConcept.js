
const header = document.querySelector('header');

fetch("https://picsum.photos/2000/400").then(onResponse, onError);

function onResponse(response){
    header.style.backgroundImage = "url("+response.url+")";
}
function onError(error){
    console.log(error);
    header.style.backgroundImage = "url(img.jpg)";
	header.style.backgroundSize = "cover";
}

const sections = document.querySelectorAll('section');

function ackImg(response){
	for(let i= 0; i<sections.length; i++){
		if(sections[i].style.backgroundImage == ''){
			sections[i].style.backgroundImage = "url("+response.url+")";
			sections[i].style.backgroundSize = "cover";
			break;
		}
	}
}
function nackImg(error){
	 console.log(error);
}

for(let i = 0; i< sections.length; i++){
	fetch("https://picsum.photos/800/400").then(ackImg, nackImg);
 }

//Citazioni per gli articles: Personality -> Quotable Quotes
const quotes = document.querySelectorAll("blockquote p");
const cites = document.querySelectorAll("blockquote h3");


function ackQuote(response){
	return response.json();
}
function onQuote(json){
//	console.log(json.content);
	 for(let i= 0; i<quotes.length; i++){
		if(quotes[i].textContent == ''){
			quotes[i].textContent = json.content;
			cites[i].textContent = json.author;
			break;
		}
	}
}

for(let i = 0; i< quotes.length; i++){
	fetch("concept/prendiCitazione").then(ackQuote).then(onQuote);
 }

const profilo = document.querySelector('#profilo');
const nome = document.querySelector('#profilo h2');
const logo = document.createElement('img');
logo.src = "immagini/logo.png";
profilo.insertBefore(logo, nome);


// Geocoding-> Abstract IP Geolocation

fetch("concept/prendiIp").then(ackIp).then(onJson);
function ackIp(response){
	return response.json();
}
function onJson(json){
	/*console.log(json);*/
	const ip = json.ip_address;
	const country= json.country;
	const region = json.region;
	const city = json.city;
	const access = json.timezone.current_time;
	console.log("Utente connesso! IP: "+ip+", Paese: "+country+", Regione: "+region+", Città: "+city+", Accesso: "+access);
	if(city == 'Catania' || city == 'Milano' || city == 'Roma' || city == 'Firenze'){
		const saluti = document.querySelector('#saluti');
		const titolo = document.querySelector('#saluti h2');
		const augurio = document.createElement('p');
		augurio.innerText = "Vieni a trovarci nella sede di "+city+", ti aspettiamo!";
		saluti.insertBefore(augurio, titolo);
	}
}