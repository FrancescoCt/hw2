<?php

use Illuminate\Routing\Controller as BaseController;

class ConceptController extends BaseController
{
	public function concept(){
		$user = Cliente::find(session('utente'));
		if(isset($user)){
			return view('concept')->with('nome', $user->nome);
		}
		else {
			return redirect('login');
		} 
	}
	
	public function prendiCitazione(){
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL,"https://api.quotable.io/random");
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		$result = curl_exec($curl);
		curl_close($curl);
		echo $result;
	}
	
	public function prendiIp(){
			
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, 'https://ipgeolocation.abstractapi.com/v1/?api_key=78d4bbc71c5f41a59f345c81684f8203');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
			$data = curl_exec($ch);
			curl_close($ch);
			echo $data;
	}
	
}
