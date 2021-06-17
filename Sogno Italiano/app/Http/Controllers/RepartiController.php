<?php

use Illuminate\Routing\Controller as BaseController;

class RepartiController extends BaseController
{
	public function reparti(){
		$user = Cliente::find(session('utente'));
		if(isset($user)){
			return view('reparti')->with('nome', $user->nome)
									->with('data', date("d-m-Y"));
		}
		else {
			return redirect('login');
		} 
	}
	public function fetchReparti(){
	
		$result =DB::select(
					'select f.citta as Citta, f.via as Via, r.nome as Nome, r.immagine as Immagine
					from filiale f, reparto r
					where f.codice = r.filiale;');
		
		$newJson = array();
		for($i=0; $i<count($result);$i++){
			//Sistemo l'indirizzo dell'immagine
			$source= explode("/",$result[$i]->Immagine);
			$immagine = "http://localhost/Sogno%20Italiano/public/immagini/".$source[count($source)-1];
			
			$newJson[] = array(
					'Citta' => $result[$i]->Citta,
					'Via' => $result[$i]->Via,
					'Nome' => $result[$i]->Nome,
					'Codice' => $i+1,
					'Immagine' => $immagine
			);
		}
		return json_encode($newJson);
	}
	
	
}
