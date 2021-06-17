<?php

use Illuminate\Routing\Controller as BaseController;

class SignUpController extends BaseController
{
	public function signup(){
		$old_nome = Request::old('nome_utente');
			$old_cognome = Request::old('cognome_utente');
			$old_cf = Request::old('cf_utente');
			$old_telefono = Request::old('tel_utente');
			$old_nascita = Request::old('nascita_utente');
		return view('signUp')
				->with('csrf_token', csrf_token())
				->with('old_nome', $old_nome)
				->with('old_cognome', $old_cognome)
				->with('old_cf', $old_cf)
				->with('old_telefono', $old_telefono)
				->with('old_nascita', $old_nascita);
		
	}
	
	public function save(){
		
			$user= new Cliente;								
			$user->nome = request('nome_utente');							
			$user->cognome = request('cognome_utente');
			$user->cf = request('cf_utente');
			$user->telefono = request('tel_utente');
			$user->nascita = request('nascita_utente');
			$user->eta = ((strtotime(date("Y-m-d")) - strtotime(request('nascita_utente'))) / (31536000));
			$user->userPswd = md5(request('pswd_utente'));
			$user->abbonamento = request('abbonamento_utente');
			
			$user->save();
			return redirect('login');
			
	}
	
	public function checkcf($query){
		$check = Cliente::where("cf", $query)->first();
		
		if(isset($check)){
				return json_encode("Cf presente");
		}else{
				return json_encode("Cf valido");
		}
	}
}
