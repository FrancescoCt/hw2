
<html>

	<head>
		<title>Sogno Italiano - Home page</title>
		<link rel = 'stylesheet' href = '{{ url("css/home.css")}}'>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&family=Roboto:wght@300&display=swap" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src='{{ url("js/scriptHome.js")}}' defer> </script>
		<script src='{{ url("js/contenutiHome.js")}}' defer> </script>
		
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
						<label><a href="#"><img src= '{{ url("immagini/home.png")}}' /></a></label>
					<ul> 
						<li><a href="#barra">Idee regalo</a></li>
						<li><a href="#annuncio">Offerte</a></li>
						<li><a href="#main">Chi siamo</a></li>
						<li><a href="#recapiti">Info e recapiti</a></li>
						<li><a href="#barraDatabase">I nostri fornitori</a></li>
					</ul> 
					</li> 
					
					</div>
				
				<a href="{{ url('concept')}}">Concept</a>
				<a href="{{ url('logout')}}">Login</a>
				<a href="{{ url('logout')}}">Logout</a>
			</nav>
			
		</header>
		<div id = "profile">
		<a href='{{ url("profilo")}}'><img src= '{{ url("immagini/account.jfif")}}' /></a>
		<p>Benvenuto {{$nome}} !</p>
		<p>{{$data}}</p>
		</div>
		
		
		<div id="preferiti">
				<h1 class = "hidden">I tuoi preferiti</h1>
				<div class = "wrapper"></div>
		</div>
		
		<div id="barra">
			<h1>Cerchi una idea regalo?</h1>
			Cerca prodotto o reparto in pagina : <input type="text" placeholder = 'Cerca'/>
		</div>
		
		<section>
			 <a class= "button" href='{{ url("galleria")}}'>Galleria</a>
			
			<div class="divisore">
				<div class='overlay'></div>
			</div>
		
			<div class="riga" >
				<div id="annuncio">
					<h2>Occasioni!</h2>
					<img src= '{{ url("immagini/fumettoDonna.jpg")}}' />
					<h3>I 5 prodotti più richiesti della settimana!</h3>
					<p>
						<ol>
							<li><a href='{{ url("galleria")}}'>T-shirt rosso ragazzo</a></li>
							<li><a href='{{ url("galleria")}}'>Felpa verde col cappuccio</a></li>
							<li><a href='{{ url("galleria")}}'>Pigiama bambino</a></li>
							<li><a href='{{ url("galleria")}}'>Camicia uomo a quadri</a></li>
							<li><a href='{{ url("galleria")}}'>Giubbotto da neve</a></li>
						</ol>
					</p>
					
				</div>
				
				<div id="main">
					<h1>Chi siamo </h1>
					<p>
						Nata nel 1998, <em>Sogno Italiano</em> è divenuta nel tempo un solido punto di riferimento del <em>fashion retail</em>. 
						L'approccio estremamente dinamico al business e il design innovativo 
						hanno permesso di conquistare la <strong>fiducia</strong> dei consumatori, ottenendo sviluppi importanti 
						sia a livello di fatturato, sia in termini di store aperti.
						Grazie a questa formula <em>Sogno Italiano</em> ha incrementato la sua presenza 
						sul territorio nazionale, sia diretto sia tramite franchising, per poi estendere lo sviluppo 
						anche ai mercati internazionali.
						La <a href="{{ url('concept')}}">mission aziendale</a> si fonda sull'<strong>affermazione dello stile italiano</strong> 
						e su di una nuova interpretazione dello shopping incentrata sul rinnovo costante, 
						puntando su collezioni di qualità a prezzi competitivi. 
						Per saperne di più sulle nostre <strong>scontistiche</strong> clicca sul link:
						<a href="{{ url('concept')}}">leggi di più</a>.
					</p>
					<img src= '{{ url("immagini/design.jpg")}}' />
				</div>
				
				<div id= "recapiti">
					<img src= '{{ url("immagini/cataniaPanoramica.jfif")}}'/>
					<h2>Dove trovarci </h2>
					<ul>
						<li><a href="https://www.google.com/maps/d/viewer?mid=1OlTya0Ua_PwYoaKAVLXY8GK4V2s&ie=UTF8&hl=it&msa=0&z=12&ll=45.4724327890074%2C9.227562282485987">Milano</a>: CAP 90459</li>
						<li><a href="https://www.google.com/maps/place/Catania+CT/@37.5154183,15.075472,13.35z/data=!4m5!3m4!1s0x1313e2dd761525b5:0x58fe876151c83cf0!8m2!3d37.5078772!4d15.0830304">Firenze</a>: CAP 27384</li>
						<li><a href="https://www.google.com/maps/d/viewer?mid=1OlTya0Ua_PwYoaKAVLXY8GK4V2s&ie=UTF8&hl=it&msa=0&z=12&ll=45.4724327890074%2C9.227562282485987">Roma</a>: CAP 61479</li>
						<li><a href="https://www.google.com/maps/place/Catania+CT/@37.5154183,15.075472,13.35z/data=!4m5!3m4!1s0x1313e2dd761525b5:0x58fe876151c83cf0!8m2!3d37.5078772!4d15.0830304">Catania</a>: CAP 91748</li>
					</ul>
					
					<h2>Come Contattarci </h2>
					<ul>
						<li>Sede Milano: 244534554</li>
						<li>Sede Roma: 327469993</li>
						<li>Sede Firenze: 277734554</li>
						<li>Sede Catania: 367466556</li>
					</ul>
					
					<h2>Seguici sui social </h2>
					<ul>
						<li><a href="https://www.instagram.com/">Instagram </a> </li>
						<li><a href="https://it-it.facebook.com/">Facebook</a> </li>
					</ul>
					
				</div>
				
			</div>
			<a class= "button" href='{{ url("reparti")}}'>Vai ai reparti</a>
			<div class="divisore">
				<div class='overlay'></div>
				
			</div>
			
			
			<div class="riga">
				<div class="lista">
					<img src= '{{ url("immagini/grucce1.jfif")}}'/>
					<h3>I nostri reparti </h3>
					<ul>
						<li>Uomo</li>
						<li>Donna</li>
						<li>Bambino</li>
						<li>Ragazzi</li>
						<li><a href='{{ url("reparti")}}'>Vedi di più</a></li>
					</ul>
					
				</div>
				
				<div class="lista">
					<img src= '{{ url("immagini/shopping.jpg")}}' />
					<h3>I nostri prodotti </h3>
					<ul>
						<li>Maglietta</li>
						<li>Felpa</li>
						<li>Pigiama</li>
						<li>Giubotto</li>
						<li><a href='{{ url("galleria")}}'>Vedi di più</a></li>
					</ul>
					
				</div>
				
				<div class="lista">
					<img src='{{ url("immagini/grucce.jpg")}}'/>
					<h3>Le nostre marche </h3>
					<ul>
						<li>Vero Style s.r.l</li>
						<li>Double A</li>
						<li>Tech by Tex</li>
						<li><a href='{{ url("galleria")}}'>Vedi di più</a></li>
					</ul>
					
				</div>
			</div>
			
		</section>
		
		<div id="barraDatabase">
			<h1>Cerchi una marca particolare?</h1>
			<form method = 'post'>
				
				<label>Dai un'occhiata ad alcuni dei nostri fornitori:  <input type="text" placeholder = 'Cerca' name = 'stringa'/></label>
				
			</form>
			
		</div>
			
			
		
		
		<footer>
			<a href= "http://www.dieei.unict.it/corsi/l-8-inf"><img src= '{{ url("immagini/logoUNICT.jpg")}}'/></a>
			<p>Francesco Catania O46002194, Corso di Web Programming, Ingegneria Informatica</p>
			
				<a href= "https://github.com/FrancescoCt"><img id='accountGithub' src= '{{ url("immagini/Github-Mark-32px.png")}}'/></a>
		</footer>
	</body>
</html>