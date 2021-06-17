<?php 
//namespace App\Models;
use Illuminate\Database\Eloquent\Model;


class Cliente extends Model{
	protected $table = 'cliente';	
	protected $primaryKey = 'cf';	
	protected $autoIncrement = false;	
	protected $keyType = "string";
	protected $hidden = ['userPswd'];
	
	//Parte con relazione
	public function preferiti(){
		return $this->belongsToMany("Pezzi","Preferiti");
	
	}
}

?>