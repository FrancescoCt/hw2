<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'HomeController@home');

Route::get('login', 'LoginController@login');
Route::post('login', 'LoginController@checkLogin');
Route::get('logout','LoginController@logout' );


Route::get('home', 'HomeController@home');
Route::get('home/vetrina', 'HomeController@vetrina');
Route::get('home/caricaPreferiti', 'HomeController@caricaPreferiti' );
Route::get('home/queryFornitori/{q}', 'HomeController@filtraDatabase' );


Route::get('/img/{q}', 'HomeController@addPreferiti');
Route::get('/img/rimuovi/{q}', 'HomeController@removePreferiti');


Route::get('signUp', 'SignUpController@signup');
Route::post('signUp', 'SignUpController@save');
Route::get ('signup/check/cf_utente/{q}', 'SignUpController@checkcf');

Route::get('concept', 'ConceptController@concept');
Route::get('concept/prendiCitazione', 'ConceptController@prendiCitazione');
Route::get('concept/prendiIp', 'ConceptController@prendiIp');

Route::get('reparti', 'RepartiController@reparti');
Route::get('reparti/fetchReparti', 'RepartiController@fetchReparti');
Route::get('reparti/caricaPreferiti', 'HomeController@caricaPreferiti');

Route::get('galleria', 'GalleriaController@galleria');
Route::get('galleria/fetchProdotti', 'GalleriaController@fetchProdotti');
Route::get('galleria/carrello/{q}', 'GalleriaController@carrello');

Route::get('profilo', 'ProfiloController@profilo');
Route::get('profilo/fetchAcquisti', 'ProfiloController@fetchAcquisti');
Route::get('profilo/fetchCredenziali', 'ProfiloController@fetchCredenziali');
Route::post('profilo/verificaPassword', 'ProfiloController@verificaPassword');
Route::get('profilo/check/password/{q}', 'ProfiloController@checkPassword');
