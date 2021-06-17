let N = 20;

function dettagli(event){
	const articles = document.querySelectorAll('.oggetto article');
	const image = event.currentTarget;
	const images = document.querySelectorAll('.oggetto img');
	 
	for(let i = 0; i<N; i++){
		if(image == images[i]){ 											
			articles[i].classList.remove('hidden');							
			break;
		} 
	}
}


function aggiungi(event){
	const tasto = event.currentTarget;
	const tasti = document.querySelectorAll('.bottone');
	const titoli = document.querySelectorAll('.oggetto h2');
	const articles = document.querySelectorAll('.oggetto article');
	const codici = document.querySelectorAll('.oggetto h3');
	const images = document.querySelectorAll('.oggetto img');
	tasto.removeEventListener('click', aggiungi);
	
	const titoloPreferiti = document.querySelector('#preferiti h1');
	titoloPreferiti.classList.remove('hidden');							
	
	const preferiti = document.querySelector('#separatore');
	const preferenze = document.querySelectorAll('.oggetto div');

		
	for(let i = 0; i<N; i++){
		
		if(tasto == tasti[i]){ 
				
			preferenze[i].classList.remove('hidden');
			const oggetto = document.createElement('div'); 
			
			oggetto.classList.add('elemento');
			preferiti.appendChild(oggetto);
			
			const titolo = document.createElement('h2');
			titolo.innerText = titoli[i].innerText;
			oggetto.appendChild(titolo);
			
			const immagine=document.createElement('img');
			immagine.src = images[i].src;
			oggetto.appendChild(immagine);
				
			const codice=document.createElement('h3');
			codice.textContent = codici[i].textContent;
			oggetto.appendChild(codice);
		
			const didascalia = document.createElement('article');
			
			let stringa = '';
			
			if(event.currentTarget.parentNode.childNodes[4].childNodes[2] != undefined){
				for(let i = 0; i<2;i++){
					stringa = stringa+ " "+event.currentTarget.parentNode.childNodes[4].childNodes[i].textContent;
				}
				
			}
			didascalia.textContent = stringa;
			
			oggetto.appendChild(didascalia);
	
			const rimuovi = document.createElement('button');
			rimuovi.textContent = 'Rimuovi dai preferiti';
			rimuovi.addEventListener('click', rimozione);
			oggetto.appendChild(rimuovi);
			
			
			
			let source = (immagine.src).split("/");
			//console.log(source[source.length-1]);

			fetch("http://localhost/laravel/public/img/" +source[source.length-1]).then(onInvio).then(onConferma);
			//Fine parte nuova
			break;
			
			} 
		}
}

function onInvio(response){
	return response.text();
}
function onConferma(json){
	//console.log(json);
}
///

function riduciDescrizione(event){
	const tasto = event.currentTarget;
	const articles = document.querySelectorAll('.oggetto article');
	const riduci = document.querySelectorAll('article button');
	
													
	for(let i = 0; i<N; i++){						
		if(tasto == riduci[i]){
			articles[i].classList.add('hidden');
		}
	}
}


function rimozione(event){
	
	const titoloPreferiti = document.querySelector('#preferiti h1');
	
	const immaginiDiv = document.querySelectorAll('.oggetto img');
	console.log(event.currentTarget.parentNode.childNodes[1].src);//immagine elemento
	console.log(event.currentTarget.parentNode); //elemento
	console.log(event.currentTarget.parentNode.childNodes[2]);
	
	const elemento = event.currentTarget.parentNode;
	const imgSrc = event.currentTarget.parentNode.childNodes[1].src;

	for(let i = 0; i<N; i++){
		if(immaginiDiv[i] != undefined && immaginiDiv[i].src == imgSrc){
			//console.log("entrato nell'if");
			immaginiDiv[i].parentNode.childNodes[0].classList.add('hidden');
			//console.log(immaginiDiv[i].parentNode.childNodes[0]);
			
			immaginiDiv[i].parentNode.childNodes[5].addEventListener('click', aggiungi);
			//console.log(immaginiDiv[i].parentNode.childNodes[5]);
			elemento.remove();
			let source = (imgSrc).split("/");
			//console.log(source[source.length-1]);

			fetch("http://localhost/Sogno%20Italiano/public/img/rimuovi/" +source[source.length-1]).then(onRimuovi).then(onConferma1);
		}else {
			//console.log("entrato nell'else");
			elemento.remove();
			let source = (imgSrc).split("/");
			//console.log(source[source.length-1]);

			fetch("http://localhost/Sogno%20Italiano/public/img/rimuovi/" +source[source.length-1]).then(onRimuovi).then(onConferma1);
		}
	}
	
	const verificaElementi = document.querySelectorAll('.elemento');
	let contaElementi = 0;
	for(let item of verificaElementi){
		contaElementi++;
	}
	if(contaElementi == 0){
		titoloPreferiti.classList.add('hidden');
	}
}

function onRimuovi(response){
	return response.text();
}
function onConferma1(json){
	//console.log(json);
}

function caricaPreferiti(){

		fetch("reparti/caricaPreferiti").then(onLoadPref).then(onConferma2);	
}

function onLoadPref(response){
	return response.json();
}
function onConferma2(json){
	console.log(json);
	for(let item of json){
		const preferiti = document.querySelector('#preferiti');
		const oggetto = document.createElement('div'); 
				
		oggetto.classList.add('elemento');
		preferiti.appendChild(oggetto);
		
		const titoloPreferiti = document.querySelector('#preferiti h1');
		titoloPreferiti.classList.remove('hidden');
		

		const titolo = document.createElement('h2');
		const immagine = document.createElement('img');
		const didascalia = document.createElement('article');
		const rimuovi = document.createElement('button');
			

		immagine.src = item['immagine'];
		
		sourcePreferito = (immagine.src.split("/"));	
		nomePreferito = (sourcePreferito[(sourcePreferito.length) - 1]).split(".");
		//////
		
		titolo.textContent = nomePreferito[0];	
		didascalia.textContent = item['giorno']+', '+item['ora'];
		rimuovi.textContent = 'Rimuovi dai preferiti';
		rimuovi.addEventListener('click', rimozione);

		oggetto.appendChild(titolo);
		oggetto.appendChild(immagine);
		oggetto.appendChild(didascalia);
		oggetto.appendChild(rimuovi);
		
		const imgDiv = document.querySelectorAll('.oggetto img');
		
		
		for(let i = 0; i<N; i++){
			if(imgDiv[i] != undefined && imgDiv[i].src == immagine.src){
				imgDiv[i].parentNode.childNodes[0].classList.remove('hidden');
				imgDiv[i].parentNode.childNodes[5].removeEventListener('click', aggiungi);
			}
		}
	}
}

caricaPreferiti();

function filtra(event){
	const oggetti = document.querySelectorAll('.oggetto');
	
	const searchString=event.currentTarget.value.toLowerCase();
	const trovati = document.querySelectorAll('.cercato');
	const corpo = document.querySelector('body');
	const primaSezione = document.querySelector('section');
	
	const sezFiltrati = document.createElement('div');
	sezFiltrati.classList.add('filtrati');
	corpo.insertBefore(sezFiltrati, primaSezione);
    	
		for(let obj of oggetti){
			
			if(obj.childNodes[4].innerText.toLowerCase().includes(searchString)){

				
				const oggetto1 = document.createElement('div'); 
				oggetto1.classList.add('cercato');
				sezFiltrati.appendChild(oggetto1);
				
				const titolo = document.createElement('h2'); 
				titolo.innerText = obj.childNodes[1].innerText;
				oggetto1.appendChild(titolo);
			
				const immagine1 = document.createElement('img');
				immagine1.src = obj.childNodes[2].src;
				oggetto1.appendChild(immagine1);
				
				const codice1 = document.createElement('h3');
				codice1.textContent = obj.childNodes[3].textContent;
				oggetto1.appendChild(codice1);
		
				const didascalia1 = document.createElement('article');
				
				didascalia1.textContent = obj.childNodes[4].textContent;
				oggetto1.appendChild(didascalia1);
				
				
				const filtraggio = document.querySelectorAll('.filtrati');	
				console.log(filtraggio);
				let conta = 0;												
				for(let item of filtraggio){								
					conta++;
					//console.log(conta);
				}
				if(conta > 1){												
					for(let item of filtraggio){
						item.remove();
						conta--;
						break;
					}
				}
			}

		}
		if(searchString == ''){
			const filtraggio = document.querySelectorAll('.filtrati');
			//console.log('Stringa vuota');
			for(let item of filtraggio){
				
						item.remove();
			}
		}
}

const search=document.querySelector('input');
search.addEventListener('keyup', filtra);