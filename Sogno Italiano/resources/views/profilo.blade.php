<!DOCTYPE.html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sogno Italiano - Profilo</title>
		<link rel="stylesheet" href= '{{ url("css/profilo.css")}}'/>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src='{{ url("js/Profilo.js")}}'defer> </script>
	</head>
	
	<body>
		<header>
			<h1>Profilo utente</h1>
		</header>
		
		<nav>
				<div id="hormenu">
					<ul> 
					<li>
						<a href="#"><img src= '{{ url("immagini/home.png")}}'/></a> 
					<ul> 
						<li><a href="#carrello">I miei acquisti</a></li>
						<li><a href="#modifiche">Credenziali</a></li>
						<li><a href="#elimina">Cancella account</a></li>
					</ul> 
					</li> 
					</div>
				
				
			<a href='{{ url("home")}}'>Home</a>
			<a href='{{ url("logout")}}'>Logout</a>
		</nav>
		
		<div id = "profile">
		<a href='{{ url("home")}}'><img src= '{{ url("immagini/account.jfif")}}'/></a>
		<p>Benvenuto {{$nome}} !</p>
		<p>{{$data}}</p>
		</div>
		
		<section class = "hidden">
			<h1>I miei acquisti</h1>
			<div id= "carrello">
				
			</div>
		</section>
		<div id= "modifiche">
			<h2>Ciao utente, i dati inseriti sono corretti?</h2>
			<p>
				<label>Nome: <span></span></label>
				<label>Cognome: <span></span></label>
				<label>Codice Fiscale: <span></span></label>
				<label>Telefono: <span></span></label>
				<label>Data di nascita: <span></span></label>
				<label>Abbonamento: <span></span></label>
				
			</p>
			
			<h2>Modifica dati utente</h2>
			<form method='post' action = '{{url("profilo/verificaPassword")}}'>
			<input type = 'hidden' name='_token' value='{{ $csrf_token }}'>
				<p>
					Se i dati non sono corretti inserisci la password per la rimozione account
					
				
				</p>
				<label><input id= "password1" type='password' name='pswd' value='Password'></label>
				<label><input type='submit' name='invio' value='Cancella' ></label>
			</form>
		</div>
		
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src='{{ url("immagini/logoUNICT.jpg")}}'/></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src='{{ url("immagini/Github-Mark-32px.png")}}'/></a>
		</footer>
	</body>
</html>