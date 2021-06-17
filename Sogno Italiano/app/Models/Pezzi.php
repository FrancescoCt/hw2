<?php 
//namespace App\Models;
use Illuminate\Database\Eloquent\Model;


class Pezzi extends Model{
	protected $table = 'pezzi';		
	//Parte con relazione
	public function preferiti(){
		return $this->belongsToMany("Cliente", "Preferiti"); //Metto in relazione il cliente con Pezzi nella tabella preferiti
	}
}

?>