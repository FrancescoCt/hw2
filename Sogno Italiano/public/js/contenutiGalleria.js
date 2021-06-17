
fetch("galleria/fetchProdotti").then(onResponse).then(onJson);

function onResponse(response){
	//console.log(response);
	return response.json();
}
function onJson(json){
    //console.log(json);
	const sezione = document.querySelector('section');	
	
	for(let item of json){
		
        const oggetto=document.createElement('div');
        oggetto.classList.add('oggetto');
		sezione.appendChild(oggetto);
		
		const stella = document.createElement('div');
		stella.classList.add('hidden');
		oggetto.appendChild(stella);
		
		const titolo = document.createElement('h2');
		titolo.innerText = item.Reparto;
		oggetto.appendChild(titolo);
		
		const immagine = document.createElement('img');
		immagine.src = item.Immagine;
		immagine.addEventListener('click', dettagli);
		oggetto.appendChild(immagine);
		
		
		//Modifica rispetto a prima
		const posizione = document.createElement('h3');
		posizione.innerText = item.Posizione;
		oggetto.appendChild(posizione);
		
        const didascalia = document.createElement('article');
		didascalia.classList.add('hidden');
		didascalia.innerText = "Codice prodotto: ";
		oggetto.appendChild(didascalia);
		
		const codice=document.createElement('span');
        codice.innerText = item.Codice;
        didascalia.appendChild(codice);
		
		const nome = document.createElement('span');
		nome.innerText = item.Nome;
		didascalia.appendChild(nome);
		
		const genere = document.createElement('span');
		genere.innerText = item.Sezione;
		didascalia.appendChild(genere);
		
		const tipo = document.createElement('span');
		tipo.innerText = item.Reparto;
		didascalia.appendChild(tipo);
			
		const prezzo = document.createElement('span');
		prezzo.innerText = item.Prezzo+" € ";
		didascalia.appendChild(prezzo);
		
		const bottoneDettagli = document.createElement('button');
		bottoneDettagli.innerText = ' (-)'; //Meno dettagli
		bottoneDettagli.addEventListener('click', riduciDescrizione);
		didascalia.appendChild(bottoneDettagli);
		
		const bottonePreferiti = document.createElement('button');
		bottonePreferiti.innerText = 'Aggiungi al carrello';
		bottonePreferiti.classList.add('bottone');
		bottonePreferiti.addEventListener('click', aggiungi);
		oggetto.appendChild(bottonePreferiti);
		
    }
}


