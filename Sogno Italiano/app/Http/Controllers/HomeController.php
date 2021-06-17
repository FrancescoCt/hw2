<?php

use Illuminate\Routing\Controller as BaseController;

class HomeController extends BaseController
{
	public function home(){
		$user = Cliente::find(session('utente'));
		if(isset($user)){
			return view('home')->with('nome', $user->nome)
								->with('data', date("d-m-Y"));
		}
		else {
			return redirect('login');
		} 
	}
	
	public function vetrina(){
			$vetrinaArray = array(
		array(
			
			'titolo' => ' Casual',
			'codice' => '1',
			'immagine' => "immagini/magliettaRagazzo.jfif",
			'nome' => 'Maglietta',
			'genere' => ' ragazzo',
			'taglia' => ' L ',
			'prezzo' => '20€'
			
		),
		array(
			
			'titolo' => ' Estivo',
			'codice' => '2',
			'immagine' => "immagini/magliettaRagazzo1.jfif",
			'nome' => 'Maglietta',
			'genere' => ' ragazzo',
			'taglia' => ' S ',
			'prezzo' => '15€'
			
		),
		array(
			
			'titolo' => ' Street',
			'codice' => '3',
			'immagine' => "immagini/felpa.jfif",
			'nome' => 'Felpa',
			'genere' => ' ragazzo',
			'taglia' => ' L ',
			'prezzo' => '25€'
			
		),
		array(
			
			'titolo' => ' Casual',
			'codice' => '4',
			'immagine' => "immagini/magliettaRagazza.jfif",
			'nome' => 'Maglietta',
			'genere' => ' ragazza',
			'taglia' => ' M ',
			'prezzo' => '18€'
			
		),
		array(
			
			'titolo' => ' Classico',
			'codice' => '5',
			'immagine' => "immagini/repartoUomo.jpeg",
			'nome' => 'Reparto',
			'genere' => ' Uomo',
			'indirizzo' => ' Via Filo 48- Catania'
		),
		array(
			
			'titolo' => ' Casual',
			'codice' => '6',
			'immagine' => "immagini/repartoDonna.jpg",
			'nome' => 'Reparto',
			'genere' => ' Donna',
			'indirizzo' => ' Via Filo 48 - Catania'
		),
		array(
			'titolo' => ' Classico',
			'codice' => '7',
			'immagine' => "immagini/repartoRagazzo.jpg",
			'nome' => 'Reparto',
			'genere' => ' Ragazzo',
			'indirizzo' => ' Via Neri 17-Milano'
		)
		
	)
	///////////////////////////////////////////////
	;
	$json = json_encode($vetrinaArray);
		return $json;
	}
	
	public function addPreferiti($query){
		$nomeImg  = "".$query;
	$img = "http://localhost/laravel/public/immagini/".$query;

	if(substr($nomeImg, 0, 7) == 'reparto' || substr($nomeImg, 0, 6) == 'grucce'){
		$codice =DB::select(
					"select codice 
					from reparto
					where immagine = '".$nomeImg."' group by codice;");
		$codice1 = json_encode($codice[0]->codice);
				$user = Cliente::find(session('utente'))->preferiti()->attach($codice1, ['immagine' => $img, 'giorno' => date("Y-m-d"), 'ora'=>date("H:i:s")]);
		
	return json_encode($codice[0]->codice);
	}else{
		$codice =DB::select(
					"select codice 
					from prodotto
					where immagine = '".$nomeImg."' group by codice;");
		
		$codice1 = json_encode($codice[0]->codice);
		$user = Cliente::find(session('utente'))->preferiti()->attach($codice1, ['immagine' => $img, 'giorno' => date("Y-m-d"), 'ora'=>date("H:i:s")]);
		return json_encode($codice[0]->codice);
		}
	}
	
	public function removePreferiti($query){
		$nomeImg  = "".$query;
		$img = "http://localhost/laravel/public/immagini/".$query;
		
		if(substr($nomeImg, 0, 7) == 'reparto' || substr($nomeImg, 0, 6) == 'grucce'){
			$codice =DB::select(
					"select codice 
					from reparto
					where immagine = '".$nomeImg."' group by codice;");
			$codice1 = json_encode($codice[0]->codice);
					$user = Cliente::find(session('utente'))->preferiti()->detach($codice1);
					
		}else{
			$codice =DB::select(
					"select codice 
					from prodotto
					where immagine = '".$nomeImg."' group by codice;");
			$codice1 = json_encode($codice[0]->codice);
					$user = Cliente::find(session('utente'))->preferiti()->detach($codice1);
		}
		
		
	}
	public function caricaPreferiti(){
		$user = Cliente::find(session('utente'));
		$cf = $user->cf;
		//Uso della relazione
		$preferiti = $user->preferiti()->get(["immagine", "giorno", "ora"]);
		return $preferiti;
	}
	
	public function filtraDatabase($query){
		$fornitori = Fornitore::where("nome",'like', '%'.$query.'%','or')->where("sede",'like', '%'.$query.'%', 'or')->where("via",'like', '%'.$query.'%')->get();
		$newJson = array();
		for($i=0; $i<count($fornitori);$i++){
			$source= explode("/",$fornitori[$i]['immagine'] );
			$immagine = "http://localhost/laravel/public/immagini/Database/".$source[count($source)-1];
			
			$newJson[] = array(
					'codice' => $fornitori[$i]['codice'],
					'nome' => $fornitori[$i]['nome'],
					'sede' => $fornitori[$i]['sede'],
					'via' => $fornitori[$i]['via'],
					'immagine' => $immagine
			);
		}
				
		return json_encode($newJson);
	}
}
