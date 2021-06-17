let N = 8;	//Numero abbastanza grande ma che fa funzionare molti for...
function dettagli(event){
	//console.log("Toccato!")
	const articles = document.querySelectorAll('.oggetto article');
	const images = document.querySelectorAll('.oggetto img');
	
	const image = event.currentTarget;
	 //console.log(image);
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
	tasto.removeEventListener('click', aggiungi);
	
	const titoloPreferiti = document.querySelector('#preferiti h1');
	titoloPreferiti.classList.remove('hidden');							
	
	const preferenze = document.querySelectorAll('.oggetto div');
	const codiciDiv = document.querySelectorAll('.oggetto h3');
	const immagini = document.querySelectorAll('.oggetto img');
	const articles = document.querySelectorAll('.oggetto article');
	
	const preferiti = document.querySelector('#preferiti');	
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
			immagine.src = immagini[i].src;	
			oggetto.appendChild(immagine);
				
			const codice=document.createElement('h3');
			codice.textContent = codiciDiv[i].textContent;
			oggetto.appendChild(codice);
		
			const didascalia = document.createElement('article');
			
			let stringa = '';
			
			if(event.currentTarget.parentNode.childNodes[4].childNodes[5] != undefined){//Caso del primo div
				for(let i = 0; i<5;i++){
					stringa = stringa + event.currentTarget.parentNode.childNodes[4].childNodes[i].textContent;
				}
				
			}else{
				for(let i = 0; i<4;i++){	//Caso del secondo div
					stringa = stringa + " "+event.currentTarget.parentNode.childNodes[4].childNodes[i].textContent;
				}
			}
			didascalia.textContent = stringa;
			
			oggetto.appendChild(didascalia);
	
			const rimuovi = document.createElement('button');
			rimuovi.textContent = 'Rimuovi dai preferiti';
			rimuovi.addEventListener('click', rimozione);
			oggetto.appendChild(rimuovi);
			
			let source = (immagine.src).split("/");
		//	console.log(source[source.length-1]);

			fetch("http://localhost/Sogno%20Italiano/public/img/" +source[source.length-1]).then(onInvio).then(onConferma);
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
	
	const elemento = event.currentTarget.parentNode;
	const imgSrc = event.currentTarget.parentNode.childNodes[1].src;

	for(let i = 0; i<N; i++){
		if(immaginiDiv[i] != undefined && immaginiDiv[i].src == imgSrc){
			immaginiDiv[i].parentNode.childNodes[0].classList.add('hidden');
			
			immaginiDiv[i].parentNode.childNodes[5].addEventListener('click', aggiungi);
			elemento.remove();
			
			let source = (imgSrc).split("/");
	//		console.log(source[source.length-1]);

			fetch("http://localhost/Sogno%20Italiano/public/img/rimuovi/" +source[source.length-1]).then(onInvio).then(onConferma);
		}
		else {
			elemento.remove();
			
			let source = (imgSrc).split("/");
	//		console.log(source[source.length-1]);

			fetch("http://localhost/Sogno%20Italiano/public/img/rimuovi/" +source[source.length-1]).then(onInvio).then(onConferma);
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
}
//////////////////////////////////////////////////////////////////

function caricaPreferiti(){
	fetch("home/caricaPreferiti").then(onLoadPref).then(onConferma2);
			
}

function onLoadPref(response){
	return response.json();
}
function onConferma2(json){
//	console.log(json);
	for(let item of json){
		const preferiti = document.querySelector('#preferiti');
		const oggetto = document.createElement('div'); 
				
		oggetto.classList.add('elemento');
		preferiti.appendChild(oggetto);
		
		const titoloPreferiti = document.querySelector('#preferiti h1');
		titoloPreferiti.classList.remove('hidden');
		
		//Dichiarazione variabili
		const titolo = document.createElement('h2');
		const immagine = document.createElement('img');
		const didascalia = document.createElement('article');
		const rimuovi = document.createElement('button');
			
			
			
		
		//Contenuti
		immagine.src = item['immagine'];
		sourcePreferito = (immagine.src.split("/"));	
		nomePreferito = (sourcePreferito[(sourcePreferito.length) - 1]).split(".");
		
		titolo.textContent = nomePreferito[0];
		didascalia.textContent = item['giorno']+', '+item['ora'];
		rimuovi.textContent = 'Rimuovi dai preferiti';
		rimuovi.addEventListener('click', rimozione);
		//Append
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
//////////////////////////////////////////////////////////////////


//FUNZIONE BARRA DI RICERCA
function filtra(event){
	
	const searchString=event.currentTarget.value.toLowerCase();
	const trovati = document.querySelectorAll('.cercato');
	const corpo = document.querySelector('body');
	const primaSezione = document.querySelector('section');
	const oggetti = document.querySelectorAll('.oggetto');
	
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
//				console.log(filtraggio);
				let conta = 0;												
				for(let item of filtraggio){								
					conta++;
//					console.log(conta);
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
//			console.log('Stringa vuota');
			for(let item of filtraggio){
				
						item.remove();
			}
		}
}

function filtraDatabase(event){
	const searchString=event.currentTarget.value.toLowerCase();
	
		if(searchString == ''){
			
			const filtraggio = document.querySelectorAll('.filtrati1');
//			console.log('Stringa vuota');
			for(let item of filtraggio){
				item.remove();
			}
		}else{
			fetch("home/queryFornitori/"+encodeURI(searchString)).then(onResponse1).then(onJson1);
			
		}
	
		
	
	
}
function onResponse1(response){
	return response.json();
}
function onJson1(json){
//	console.log(json);
	const corpo = document.querySelector('body');
	const footer = document.querySelector('footer');
	const sezFiltrati = document.createElement('div');
	
	sezFiltrati.classList.add('filtrati1');
	corpo.insertBefore(sezFiltrati, footer);

	for(let item in json){
		
		const oggetto1 = document.createElement('div'); 
				oggetto1.classList.add('cercato');
				if(sezFiltrati){
					sezFiltrati.appendChild(oggetto1);
				
				const titolo = document.createElement('h2'); 
				titolo.innerText = json[item].nome;
				oggetto1.appendChild(titolo);
				
				const immagine1 = document.createElement('img');
				immagine1.src = json[item].immagine;
				oggetto1.appendChild(immagine1);
				
				const codice1 = document.createElement('h3');
				codice1.textContent = json[item].codice;
				oggetto1.appendChild(codice1);
		
				const didascalia1 = document.createElement('article');
				
				didascalia1.textContent = json[item].nome+", "+json[item].sede+", "+json[item].via;
				oggetto1.appendChild(didascalia1);
				}
				const filtraggio = document.querySelectorAll('.filtrati1');	//seleziono tutti i div filtrati
//				console.log(filtraggio);
				let conta = 0;												//con questa variabile conto il numero di elmenti
				for(let item of filtraggio){								
					conta++;
//					console.log(conta);
				}
				if(conta > 1){												//se la conta è maggiore di uno elmina il primo elemento della nodelist, in questo modo sembrerà un aggiornamento istantaneo (il for fa il break appena arriva al primo termine infatti)
					for(let item of filtraggio){
						item.remove();
						conta--;
						break;
					}
				}
	}
}

const search=document.querySelectorAll('input');
search[0].addEventListener('keyup', filtra);
search[1].addEventListener('keyup', filtraDatabase);

const form = document.querySelector('form');