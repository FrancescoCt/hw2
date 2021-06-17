function raccogli(event){
	//console.log('Attivato');
	const tasto = event.currentTarget;
	const formData = new FormData(formElement);
	
	const codici = document.querySelectorAll('.elemento span');
	
	let N = 10;						
	let arrayCodici = [];
	for(let i=0; i < N; i++){
		if(codici[i]){
			arrayCodici.push(codici[i].innerText);
		//	console.log(codici[i].innerText);
		}else break;
		
	}

	//console.log(arrayCodici);
	formData.append('codici_prodotto', JSON.stringify(arrayCodici));
	console.log(formData);
	
	
	fetch("galleria/carrello/"+encodeURI(arrayCodici)).then(onResponse).then(onJson);
}

function onResponse(response){
	//console.log(response);
	return response.json();
}
function onJson(json){
	//console.log(json);
}

const form = document.querySelector('form');
//console.log(form);
form.addEventListener('submit', raccogli);