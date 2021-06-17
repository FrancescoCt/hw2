<!DOCTYPE.html>
<html>
	<head>
		<title>Sogno Italiano - Galleria</title>
		<link rel="stylesheet" href='{{ url("css/galleria.css")}}'/>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src='{{ url("js/contenutiGalleria.js")}}' defer> </script>
		<script src='{{ url("js/Galleria.js")}}' defer> </script>
		<script src='{{ url("js/Carrello.js")}}' defer> </script>
		
	</head>
	<body>
		<header>
			<div class='overlay'>
				<div id="titolo">Sogno Italiano</div>
			</div>
			
			<nav>
				
				<div id="hormenu">
					<ul> 
					<li>
						<a href="#"><img src= '{{ url("immagini/shop.png")}}' /></a> 
					<ul>
						<li><a href="#barra">Idee regalo</a></li>
						<li><a href="#preferiti">Il tuo carrello</a></li>
						<li><a href="#formElement">Procedi all'acquisto</a></li>
						
					</ul>
					</li> 
					
					</div>
				
				<a href='{{ url("home")}}'>Home</a>
				<a href='{{ url("login")}}'>Login</a>
				<a href='{{ url("logout")}}'>Logout</a>
			</nav>
		</header>

			<p>Ciao {{$nome}}, ti presentiamo la nostra collezione!</p>
			<p>{{$data}}</p>
		
			<div id="preferiti">
				<h1 class = "hidden">Il tuo carrello</h1>
				<div id = "separatore"></div>
			</div>
			
			<div id="barra">
			<h1>Cerchi una idea regalo?</h1>
			Cerca prodotto in galleria : <input type="text" placeholder = 'Cerca'/>
			</div>
		
		
		
		<section>
			
		</section>	
		
		<h1>Procedere all'acquisto?</h1>
				<form id='formElement' action='{{url("profilo")}}' method = 'get' >
				<label>Confermo le scelte fatte, procedi con l'acquisto</label>
				<label><input type='submit' name='invio' value='Vai' ></label>
				</form>
		
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src='{{ url("immagini/logoUNICT.jpg")}}'/></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			
				<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src='{{ url("immagini/Github-Mark-32px.png")}}'/></a>
			
		</footer>
		
	</body>
</html>