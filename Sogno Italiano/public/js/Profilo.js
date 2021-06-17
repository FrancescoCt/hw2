
const header = document.querySelector('header');

fetch("https://picsum.photos/2000/400").then(onResponse1, onError1);

function onResponse1(response){
 //   console.log(response);
    header.style.backgroundImage = "url("+response.url+")";
}
function onError1(error){
    console.log(error);
    header.style.backgroundImage = "url(img.jpg)";
	header.style.backgroundSize = "cover";
}

fetch("profilo/fetchAcquisti").then(onResponse).then(onJson);

function onResponse(response){
	//console.log(response);
	return response.json();
}
function onJson(json){
    //console.log(json);
	const sezione = document.querySelector('#carrello');	
	
	for(let item of json){
		
        const oggetto=document.createElement('div');
        oggetto.classList.add('oggetto');
		sezione.appendChild(oggetto);
		
		const titolo = document.createElement('h2');
		titolo.innerText = item.Oggetto;
		oggetto.appendChild(titolo);
		
		const immagine = document.createElement('img');
		immagine.src = item.Immagine;
		oggetto.appendChild(immagine);
		
        const codice=document.createElement('h3')
        codice.innerText = item.Codice;
        oggetto.appendChild(codice);
		
        const didascalia = document.createElement('article');
		oggetto.appendChild(didascalia);
		
		const nome = document.createElement('span');
		nome.innerText = item.Nome+": ";
		didascalia.appendChild(nome);
		
		const tipo = document.createElement('span');
		tipo.innerText = item.Oggetto;
		didascalia.appendChild(tipo);
													
		const prezzo = document.createElement('span');
		prezzo.innerText = item.Prezzo+"€";
		didascalia.appendChild(prezzo);
		
		const giorno = document.createElement('span');
		giorno.innerText = item.Giorno;
		didascalia.appendChild(giorno);
		
		const ora = document.createElement('span');
		ora.innerText = item.Ora;
		didascalia.appendChild(ora);

    }
}
//RECUPERO CREDENZIALI UTENTE DAL DATABASE

fetch("profilo/fetchCredenziali").then(onResponseCr).then(onJsonCr);
function onResponseCr(response){
	//console.log(response);
	return response.json();
}
function onJsonCr(json){
//console.log(json);
const credenziali = document.querySelectorAll('#modifiche span');
//console.log(credenziali);
credenziali[0].innerText = json['nome'];
credenziali[1].innerText = json['cognome'];
credenziali[2].innerText = json['cf'];
credenziali[3].innerText = json['telefono'];
credenziali[4].innerText = json['nascita'];
credenziali[5].innerText = json['abbonamento'];
}



function modifica(event){
	const pulsante = event.currentTarget;

	console.log(flag);
	if(flag == false){
		event.preventDefault();
	}
}
function checkPassword(){
	const password1 = event.currentTarget.value;
	console.log(password1);
	if(password1 == ''){
			
	}else{
		fetch("profilo/check/password/" +encodeURI(password1)).then(onResponsepassword1).then(onJsonpassword1);
	}
}
function onResponsepassword1(response){
	return response.json();
}
function onJsonpassword1(json){
	console.log(json);
	if(json == 'Password valida'){
		flag = true;
	}else {flag = false;}
}

let flag = false;

const form = document.querySelector('form');
form.addEventListener('submit', modifica);
const password0=document.querySelector("#password1");
password0.addEventListener("blur", checkPassword);