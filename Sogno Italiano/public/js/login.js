
function validazione(event){
		
	const nome = event.currentTarget.cf_utente.value;
	const pswd = event.currentTarget.pswd_utente.value;
	
	if(/[A-Za-z]+/.test(pswd) && /[0-9]+/.test(pswd) && /[^a-z0-9]+/i.test(pswd)){
				console.log("La password è alfanumerica con caratteri speciali");
				
	}else{
		const errore = document.querySelector('.hidden');
		console.log(errore);
		errore.classList.remove('hidden');
		event.preventDefault();
	}
	if(flag == false){
		event.preventDefault();
	}
}
function checkCodFisc(){
	const cf = event.currentTarget.value;
	console.log(cf);
	if(cf == ''){
			const errore = document.querySelector('.hidden');
			console.log(errore);
			errore.classList.remove('hidden');
			
	}else{
		fetch("signup/check/cf_utente/" +encodeURI(cf)).then(onResponsecodFisc).then(onJsoncodFisc);
	}
}

function onResponsecodFisc(response){
	return response.json();
}
function onJsoncodFisc(json){
	console.log(json);
	if(json == 'Cf presente'){
		flag = true;
	}else {flag = false;
	const errore = document.querySelector('.hidden');
			console.log(errore);
			errore.classList.remove('hidden');}
}

let flag = false;
const form = document.querySelector('form');
form.addEventListener('submit', validazione);
const codFisc=document.querySelector("#codFisc");
codFisc.addEventListener("blur", checkCodFisc);
 