	let lista = [];
	
	
function validazioneSignUp(event){
	
	const nome = event.currentTarget.nome_utente.value;
	const cognome = event.currentTarget.cognome_utente.value;
	const cf = event.currentTarget.cf_utente.value;
	const abbonamento = event.currentTarget.abbonamento_utente.value;
	const tel = event.currentTarget.tel_utente.value;
	const nascita = event.currentTarget.nascita_utente.value;
	const pswd = event.currentTarget.pswd_utente.value;
	
	lista.push(nome);
	lista.push(cognome);
	lista.push(cf);
	lista.push(abbonamento);
	lista.push(tel);
	lista.push(nascita);
	
	
	const condizione1= /[A-Za-z]+/.test(pswd);
	const condizione2= /[0-9]+/.test(pswd);
	const condizione3= /[^a-z0-9]+/i.test(pswd);
	
	if( condizione1 && condizione2 && condizione3){
				console.log("La password è alfanumerica con caratteri speciali");
				
	}else{
			const errore = document.querySelector('.hidden');
			console.log(errore);
			event.preventDefault();
			errore.classList.remove('hidden');
			lista = [];
	}
	
	
	for(let i = 0; i<lista.length; i++){
			if(!lista[i]){
			console.log('Errore '+lista[i]);
			const errore = document.querySelector('.hidden');
			event.preventDefault();
			errore.classList.remove('hidden');
			lista = [];
			break;
		}
	}
	console.log(flag);
	if(flag == false){
		event.preventDefault();
	}
	
}

function onResponse(response){
	return response.json();
}
function onJson(json){
	console.log(json);
	console.log(lista);
	if(json == 'Cf presente'){
		lista = [];
		flag = false;
		const errore = document.querySelector('.hidden');
		errore.classList.remove('hidden');
	}else {flag = true;
	const errore1 = document.querySelector('#errore');
		errore1.classList.add('hidden');
	}
}

function checkCodFisc(){
	const cf = event.currentTarget.value;
	console.log(cf);
	if(cf == ''){
			const errore = document.querySelector('.hidden');
			console.log(errore);
			errore.classList.remove('hidden');
			lista = [];
			
	}else{
		fetch("signup/check/cf_utente/" +encodeURI(cf)).then(onResponse).then(onJson);
	}
}

let flag = false;
const form = document.querySelector('form');
form.addEventListener('submit', validazioneSignUp);

const codFisc=document.querySelector("#codFisc");
codFisc.addEventListener("blur", checkCodFisc);