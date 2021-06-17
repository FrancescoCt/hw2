<!DOCTYPE.html>
<html>
	<head>
		<title>Sogno Italiano - Reparti</title>
		<link rel="stylesheet" href= '{{ url("css/galleria.css")}}'/>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src='{{ url("js/contenutiReparti.js")}}' defer></script>
		<script src='{{ url("js/Reparti.js")}}' defer> </script>
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
						<a href="#"><img src= '{{ url("immagini/white_heart.png")}}'/></a>
					<ul> 
						<li><a href="#barra">Cerca reparti</a></li>
						<li><a href="#preferiti">I preferiti</a></li>
					</ul> 
					</li> 
					
					</div>
				
				<a href='{{ url("home")}}'>Home</a>
				<a href='{{ url("login")}}'>Login</a>
				<a href='{{ url("logout")}}'>Logout</a>
			</nav>
		</header>

			<p>Ciao {{$nome}}, ti presentiamo i nostri reparti!</p>
			<p>{{$data}}</p>
		
			<div id="preferiti">
				<h1 class = "hidden">I tuoi preferiti</h1>
				<div id = "separatore"></div>
				
			</div>
			
			<div id="barra">
			<h1>Cerchi un reparto?</h1>
			Trova reparto in galleria : <input type="text" placeholder = 'Cerca'/>
			</div>
		
		
		<section>
		</section>	
		
		
		
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src='{{ url("immagini/logoUNICT.jpg")}}' /></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			
				<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src='{{ url("immagini/Github-Mark-32px.png")}}'/></a>
			
		</footer>
		
	</body>
</html>