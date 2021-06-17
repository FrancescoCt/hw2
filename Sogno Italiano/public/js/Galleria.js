
function dettagli(event){
	const articles = document.querySelectorAll('.oggetto article');
	const images = document.querySelectorAll('.oggetto img')
	const image = event.currentTarget;
	
	
	let N = 0;
	for(let item in images){
		N++;
	}
	
	for(let i = 0; i<N; i++){
		if(image == images[i]){ 											
			//console.log(articles[i]);
			articles[i].classList.remove('hidden');							
			break;
		} 
	}
}

function aggiungi(event){
	const tasto = event.currentTarget;
	const tasti = document.querySelectorAll('.bottone');
	const titoli = document.querySelectorAll('.oggetto h2');
	const immagini = document.querySelectorAll('.oggetto img');
	const codiciProd = document.querySelectorAll('.oggetto h3');
	const articles = document.querySelectorAll('.oggetto article');
	
	tasto.removeEventListener('click', aggiungi);
	
	const titoloPreferiti = document.querySelector('#preferiti h1');
	titoloPreferiti.classList.remove('hidden');							//Rendo visibile il titolo della sezione preferiti
	
	const preferiti = document.querySelector('#separatore');
	const preferenze = document.querySelectorAll('.oggetto div');
	

	let N = 0;
	for(let item in immagini){
		N++;
	}
	
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
			codice.textContent = codiciProd[i].textContent;
			oggetto.appendChild(codice);
		
			const didascalia = document.createElement('article');
			
			let stringa = '';
			
			if(event.currentTarget.parentNode.childNodes[4].childNodes[6] != undefined){
				for(let i = 2; i<6;i++){
					stringa = stringa+ " "+event.currentTarget.parentNode.childNodes[4].childNodes[i].textContent;
				}
				
			}
			didascalia.textContent = stringa+" Codice prodotto: ";

			const posizione = document.createElement('span');
				posizione.innerText=event.currentTarget.parentNode.childNodes[4].childNodes[1].innerText;
			didascalia.appendChild(posizione);

			
			oggetto.appendChild(didascalia);
	
			const rimuovi = document.createElement('button');
			rimuovi.textContent = 'Rimuovi dal carrello';
			rimuovi.addEventListener('click', rimozione);
			oggetto.appendChild(rimuovi);
			break;
			
			} 
		}
}
function riduciDescrizione(event){
	//console.log("Toccato1");
	const tasto = event.currentTarget;
	const articles = document.querySelectorAll('.oggetto article');
	const riduci = document.querySelectorAll('article button');
	//console.log(riduci);
	
	//conta
	let N = 0;
	for(let item in riduci){
		N++;
	}
	//fine conta
													
	for(let i = 0; i<N; i++){						
		if(tasto == riduci[i]){
			articles[i].classList.add('hidden');	
		}
	}
}
function rimozione(event){
	
	const tasto = event.currentTarget;
	const tasti = document.querySelectorAll('.elemento button');
	const elementi = document.querySelectorAll('.elemento');
	const titoloPreferiti = document.querySelector('#preferiti h1');
	const preferenze = document.querySelectorAll('.oggetto div');
	
	const pulsante = document.querySelectorAll('.bottone');
	
	
	const codPref = document.querySelectorAll('.elemento h3');
	
	let cod = 0;
	
	//conta
	let N = 0;
	for(let item in tasti){
		N++;
	}
	//fine conta
	
	for(let i =0; i<N; i++){
		if(tasto == tasti[i]){							
	//		console.log('codPref[i] ',codPref[i]);		

			elementi[i].remove();						
			cod = codPref[i].textContent;				
			preferenze[cod-1].classList.add('hidden');	
			pulsante[cod-1].addEventListener('click', aggiungi);
			
			break;
		}
	}
	//Controllo sezione non vuota
	const verificaElementi = document.querySelectorAll('.elemento');
	let contaElementi = 0;
	for(let item of verificaElementi){
		contaElementi++;
	}
	if(contaElementi == 0){
		titoloPreferiti.classList.add('hidden');
	}
}

//FUNZIONE BARRA DI RICERCA
function filtra(event){
	const oggetti = document.querySelectorAll('.oggetto');
	
	const searchString=event.currentTarget.value.toLowerCase();
	const trovati = document.querySelectorAll('.cercato');
	const corpo = document.querySelector('body');
	const primaSezione = document.querySelector('section');
	
	//Creazione dinamica
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
				
				for(let i = 0; i<(obj.childNodes[4].childElementCount); i++){
					didascalia1.textContent = didascalia1.textContent+" "+obj.childNodes[4].childNodes[i].textContent;
				}
				//console.log(obj.childNodes[4].childNodes[0]);
				oggetto1.appendChild(didascalia1);
				
				const filtraggio = document.querySelectorAll('.filtrati');	
				
				let conta = 0;												
				for(let item of filtraggio){								
					conta++;
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
	//		console.log('Stringa vuota');
			for(let item of filtraggio){
					item.remove();
			}
		}
}


//BARRA DI RICERCA
const oggetti = document.querySelectorAll('.oggetto');
const search=document.querySelector('input');
search.addEventListener('keyup', filtra);
