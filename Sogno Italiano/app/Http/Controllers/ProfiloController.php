<?php

use Illuminate\Routing\Controller as BaseController;

class ProfiloController extends BaseController
{
	public function profilo(){
		$user = Cliente::find(session('utente'));
		if(isset($user)){
			return view('profilo')
			->with('nome', $user->nome)
			->with('csrf_token', csrf_token())
			->with('data', date("d-m-Y"));
		}
		else {
			return redirect('login');
		} 
	}
	
	public function fetchAcquisti(){
		$user = Cliente::find(session('utente'));
		$result =DB::select(
					'select a.codice_prodotto as Codice, p.nome as Nome, a.id_prodotto as ID_Prodotto, a.ricavo as Prezzo, p.immagine as Immagine, a.giorno as Giorno, a.ora as Ora
					from prodotto p, acquisto a , pezzi u
					where 	p.codice = a.codice_prodotto 
							and a.id_prodotto = u.id1
							and u.codice_prodotto = p.codice
							and a.cliente = "'.$user->cf.'";');
		
		$newJson = array();
		
		for($i=0; $i<count($result);$i++){
			
			$source= explode("/",$result[$i]->Immagine);
			$immagine = "http://localhost/Sogno%20Italiano/public/immagini/Database/".$source[count($source)-1];
			$oggetto = explode(".", $source[count($source)-1]);
			
			$newJson[] = array(
								'Codice' => $result[$i]->Codice,
								'Nome' => $result[$i]->Nome,
								'ID_Prodotto' => $result[$i]->ID_Prodotto,
								'Oggetto' => $oggetto[0],
								'Prezzo' => $result[$i]->Prezzo,
								'Immagine' => $immagine,
								'Giorno' => $result[$i]->Giorno,
								'Ora' => $result[$i]->Ora
			);
		}
		return json_encode($newJson);
	}
	
	public function fetchCredenziali(){
		$result = Cliente::find(session('utente'));
		$newJson = array();
		
			
			$newJson[] = array(
								'Nome' => $result->nome,
								'Cognome' => $result->cognome,
								'Codice_Fiscale' => $result->cf,
								'Telefono' => $result->telefono,
								'Nascita' => $result->nascita,
								'Abbonamento' => $result->abbonamento
								
			);
		return json_encode($result);
	}

	public function verificaPassword(){
		
		$cliente = Cliente::find(session('utente'));
		$user = Cliente::where("cf", $cliente->cf)->where("userPswd", md5(request('pswd')))->first();
		if($user!= null){
			
			$user->delete();
			
			Session::flush();
		
			
			return redirect('login');
		}else return redirect('profilo');
		
	}
	
	public function checkPassword($query){
		$user = Cliente::find(session('utente'));
		if($user->userPswd == md5($query))
		{
				return json_encode("Password valida");
		}else{
				return json_encode("Password non valida");
		}
	}
}
