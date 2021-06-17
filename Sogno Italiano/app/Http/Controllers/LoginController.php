<?php

use Illuminate\Routing\Controller as BaseController;

class LoginController extends BaseController
{
	public function login(){
		
		if(session('utente') != null){
			return redirect('home');
		
		}else{
		
			$old_cf = Request::old('cf_utente');
			return view('login')
				->with('csrf_token', csrf_token())
				->with('old_cf', $old_cf);
		}
	}
	
	public function checkLogin(){
		
	
		//$result = DB::select('SELECT * FROM cliente where cf = ? AND userPswd = ?', [request('cf_utente'), request('pswd_utente')]);
		//$result = DB::table('cliente')->where('cf', request('cf_utente'))->where('userPswd', request('pswd_utente'))->get(); //Al posto di get() posso usare first() per farmi restituire anzichè la collection solo un elemento della collection
	
		$user = Cliente::where("cf", request('cf_utente'))->where("userPswd", md5(request('pswd_utente')))->first();	//Da sistemare perchè si richiama alla tabella "clientes" che non esiste e non "cliente"
		if(isset($user)){
			
			Session::put('utente', $user->cf);
			return redirect('home');
			
		
		}
		else{
	
			return redirect('login')->withInput(); //senza questo non funziona {{$old_cf}} perchè non viene ritornato l'input alla pagina altrimenti
		}
	}
	
	public function logout(){
		
		Session::flush();
		return redirect('login');
	}
}
