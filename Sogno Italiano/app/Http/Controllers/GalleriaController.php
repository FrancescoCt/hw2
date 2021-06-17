<?php

use Illuminate\Routing\Controller as BaseController;

class GalleriaController extends BaseController
{
	public function galleria(){
		$user = Cliente::find(session('utente'));
		if(isset($user)){
			return view('galleria')->with('nome', $user->nome)
									->with('data', date("d-m-Y"));
		}
		else {
			return redirect('login');
		} 
	}
	public function fetchProdotti(){
			$result =DB::select(
					"select p.codice as Codice, p.nome as Nome, d.sezione as Cod_Sezione, s.nome as Sezione,r.nome as Reparto, u.prezzo as Prezzo, p.immagine as Immagine 
					from prodotto p,  deposito d , sezione s, pezzi u, reparto r
					where 	p.codice = d.prodotto 
							and d.filiale= s.filiale 
							and d.reparto=s.reparto 
							and d.sezione = s.codice
							and u.id1 = d.id_prodotto
							and u.codice_prodotto = p.codice
							and r.codice = d.reparto
							GROUP BY p.codice
							");
		
		$newJson = array();
		
		for($i=0; $i<count($result);$i++){
			
			$source= explode("/",$result[$i]->Immagine);
			$immagine = "http://localhost/Sogno%20Italiano/public/immagini/Database/".$source[count($source)-1];
			
			$newJson[] = array(
								'Posizione' =>$i+1, 
								'Codice' => $result[$i]->Codice,
								'Nome' => $result[$i]->Nome,
								'Cod_sezione' => $result[$i]->Cod_Sezione,
								'Sezione' => $result[$i]->Sezione,
								'Reparto' => $result[$i]->Reparto,
								'Prezzo' => $result[$i]->Prezzo,
								'Immagine' => $immagine
			);
		}
		return json_encode($newJson);
	}	
	public function carrello($query){
		$user = Cliente::find(session('utente'));
		$array = $query;
	
		$result =DB::select(
					"select p.codice as Codice, d.id_prodotto as ID_Copia, p.nome as Nome, d.sezione as Cod_Sezione, s.nome as Sezione,r.nome as Reparto, u.prezzo as Prezzo, p.immagine as Immagine 
			from prodotto p,  deposito d , sezione s, pezzi u, reparto r
			where p.codice = d.prodotto and d.filiale= s.filiale 
							and d.reparto=s.reparto 
							and d.sezione = s.codice 
							and u.id1 = d.id_prodotto 
							and u.codice_prodotto = p.codice
							and p.codice in (".$array.")
							and r.codice = d.reparto group by p.codice;");/**/
		for($i=0; $i<count($result);$i++){
			$query1 = DB::statement("call acquisto('".$result[$i]->Codice."', '".$result[$i]->ID_Copia."', '".$user->cf."');");
			
		}
		return json_encode($result);
	}
}
