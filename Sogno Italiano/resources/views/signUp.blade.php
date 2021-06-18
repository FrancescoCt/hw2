<html>
	<head>
		<meta charset="UTF-8">
		<title>Sogno Italiano - Sign Up</title>
		<link rel="stylesheet" href= '{{ url("css/login.css")}}' />
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src='{{ url("js/picsum.js")}}' defer> </script>
		<script src='{{ url("js/validationSignup.js")}}' defer> </script>
	</head>
	<body>
		<header>
			<h1>Sign Up</h1>
		</header>
		
		<nav>
			<a href="{{ url('home')}}">Home</a>
			<a href="{{ url('login')}}">Login</a>			
		</nav>
		
			<div id='credenziali'>
			<form method='post'>
				<input type = 'hidden' name='_token' value='{{ $csrf_token }}'>
				<label>Nome<input type='text' placeholder = 'Nome' name='nome_utente' ></label>
				<label>Cognome<input type='text' placeholder = 'Cognome' name='cognome_utente' ></label>
				<label>Codice fiscale <input id= "codFisc" type='text' placeholder = 'Codice Fiscale' name='cf_utente' ></label>
				<label>Telefono <input type='text' placeholder = '095 913215' name='tel_utente'  ></label>
				<label>Data di nascita <input type='text' placeholder = '1980-01-01' name='nascita_utente' ></label>
				<label>Password<input type='password' name='pswd_utente'></label>
			
				<label>Abbonamento<select name='abbonamento_utente'>
						<option value='settimanale'>Settimanale</option>
						<option value='mensile'>Mensile</option>
						<option value='annuale'>Annuale</option>
					</select></label>
			<label><input type='submit' name='invio' value='SignUp' ></label>
			
			</form>
			
		</div>
		
		<div id= 'errore' class = "hidden">
			<p>Errore: codice fiscale già presente o regola non rispettata</p>
		</div>
			
		<h2>Regole per la registrazione</h2>
		<p>
			<li>Tutti i campi devono essere riempiti affinchè il form sia compilato correttamente</li>
			<li>La password deve prevedere almeno 6 caratteri perchè il form sia compilato</li>
			<li>La password deve essere alfanumerica e contenere almeno un carattere speciale</li>
			<li>Se non ci sono errori verrai riportato alla pagina di login</li>
		</p>
		<p>Sei già registrato? <a href="{{ url('login')}}">Clicca qui</a> per accedere.</p>
		
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src='{{ url("immagini/logoUNICT.jpg")}}'/></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src= '{{ url("immagini/Github-Mark-32px.png")}}'/></a>
		</footer>
	</body>
</html>