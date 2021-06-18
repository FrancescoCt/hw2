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
				->with('csrf_token', csrf_token());
		}
	}
	
	public function checkLogin(){
		
		$user = Cliente::where("cf", request('cf_utente'))->where("userPswd", md5(request('pswd_utente')))->first();
		if(isset($user)){
			
			Session::put('utente', $user->cf);
			return redirect('home');
			
		
		}
		else{
	
			return redirect('login');
		}
	}
	
	public function logout(){
		
		Session::flush();
		return redirect('login');
	}
}
