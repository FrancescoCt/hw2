<!DOCTYPE.html>

<html>
	<head>
		<title>Sogno Italiano - Login</title>
		<link rel = 'stylesheet' href = '{{ url("css/login.css")}}'>
		<link rel="stylesheet" href= '{{ url("css/login.css")}}' />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src = '{{ url("js/login.js")}}' defer></script>
		<script src = '{{ url("js/picsum.js")}}' defer></script>
		
	</head>
	<body>
		<header>
			<h1>Login</h1>
		</header>
		
		<nav>
			<a href='{{ url("home")}}' >Home</a>
			<a href='{{ url("signUp")}}'>Sign Up</a>			
		</nav>
		<div id = 'credenziali'>
		
		
		<form method='post'>
			<input type = 'hidden' name='_token' value='{{ $csrf_token }}'>
			<label>Codice Fiscale   <input id= 'codFisc' type='text' placeholder = 'Codice Fiscale' name='cf_utente'></label>
			<label>Password   <input type='password' name='pswd_utente' ></label>
			<label><input type='submit' name='invio' value='Login' ></label>
			
		</form>
		
		
		</div>
		
			<div id='errore' class = 'hidden'>
				<p>Errore: utente non registrato o password non corretta</p>
			</div>
		
		
		<p>Non sei registrato? <a href='{{ url("signUp")}}'>Clicca qui</a> per iscriverti!</p>
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src='{{ url("immagini/logoUNICT.jpg")}}' /></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src='{{ url("immagini/Github-Mark-32px.png")}}'/></a>
		</footer>
	</body>
</html>