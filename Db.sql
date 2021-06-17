-- PROGETTO DATABASE GESTIONE CATENA MAGAZZINI 									FRANCESCO CATANIA O46002194 ING. INFORMATICA

-- ______________________________________________ CREATE TABLES ______________________________________________ 

--Disclaimer: tutte le tabelle sono già descritte ampiamente nella presentazione

/*Dopo aver eseguito i comandi in ordine:*/

mysql -u root  
create database magazzino_modificato;
use magazzino_modificato;




/*PRODOTTO */
	
create table prodotto(
codice integer primary key, 
nome varchar(20), 
marca varchar(20),
/*Parte nuova rispetto all'originale*/
immagine varchar(50)
/*Fine parte nuova rispetto all'originale*/
)engine = InnoDB;

/*PEZZI*/

create table pezzi(
id integer(10) not null auto_increment primary key,
codice_prodotto integer, 
id1 integer, 
prezzo float,
/*primary key(codice_prodotto, id),*/
foreign key (codice_prodotto) references prodotto(codice)
on update cascade on delete cascade,
index(codice_prodotto)
)engine = InnoDB;

/*CLIENTE */

create table cliente(
cf varchar(20) primary key, 
nome varchar(20),
cognome varchar(20),
telefono integer,
nascita date,
eta integer,
abbonamento varchar(20),
/*Parte nuova rispetto all'originale*/
userPswd varchar(32),
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW()
/*Fine parte nuova rispetto all'originale*/
)engine = InnoDB;

/*Nuova aggiunta: tabella preferiti*/
create table preferiti(
id integer(10) not null auto_increment primary key,
cliente_cf varchar(20) not null,
pezzi_id integer(10) not null,
/*cf varchar(20),*/ 
immagine varchar(100),
ora time,
giorno date,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW()

)engine = InnoDB;

/*IMPIEGATO*/
	
create table impiegato(
cf varchar(20) primary key, 
nome varchar(20),
cognome varchar(20),
telefono integer,
nascita date,

matricola integer,
ruolo varchar(20)
)engine = InnoDB;

/*FORNITORE*/

create table fornitore(
codice integer primary key, 
nome varchar(20),
sede varchar(20),
via varchar (20),
/*Parte nuova rispetto all'originale*/
immagine varchar(50)
/*Fine parte nuova rispetto all'originale*/
)engine = InnoDB;

/*FILIALE*/

create table filiale(
codice integer primary key, 
citta varchar(20),
via varchar (20)
)engine = InnoDB;

/*AFFERENZA_CORRENTE*/

create table afferenza_corrente(
impiegato varchar(20) primary key, 
filiale integer,
inizio date,
foreign key (impiegato) references impiegato(cf)
on update cascade on delete cascade,
foreign key (filiale) references filiale(codice)
on update cascade on delete cascade,
index (impiegato),
index(filiale)
)engine = InnoDB;

/*AFFERENZA_PASSATA*/
	
create table afferenza_passata(
impiegato varchar(20) , 
filiale integer,
inizio date,
fine date,
primary key(impiegato, filiale, inizio, fine),
foreign key (impiegato) references impiegato(cf)
on update cascade on delete cascade,
foreign key (filiale) references filiale(codice)
on update cascade on delete cascade,
index(impiegato),
index(filiale)
)engine = InnoDB;

/*REPARTO*/

create table reparto(
filiale integer , 
codice integer,
nome varchar(20),
/*Parte nuova rispetto all'originale*/
immagine varchar(50),
/*Parte nuova rispetto all'originale*/
primary key(filiale,codice),
foreign key (filiale) references filiale(codice)
on update cascade on delete cascade,
index(filiale)
)engine = InnoDB;
	
/*SEZIONE*/

create table sezione(
filiale integer ,
reparto integer, 
codice integer,
nome varchar(20),
disponibile integer,
primary key(filiale, reparto, codice),
foreign key (filiale, reparto) references reparto(filiale, codice)
on update cascade on delete cascade,
index(filiale, reparto)
)engine = InnoDB;

/*DEPOSITO*/

create table deposito(
filiale integer,
reparto integer,
sezione integer,
prodotto integer ,
id_prodotto integer, 
ora time,
giorno date,
mittente varchar(20),
primary key(prodotto, id_prodotto),

foreign key (filiale, reparto, sezione) references sezione(filiale, reparto, codice)
on update cascade on delete cascade,
/*foreign key (prodotto, id_prodotto) references pezzi(codice_prodotto, id)
on update cascade on delete cascade,*/
foreign key (id_prodotto) references pezzi(id)
on update cascade on delete cascade,
index(filiale, reparto, sezione)
/*index(prodotto, id_prodotto)*/
)engine = InnoDB;	
	
/*TIROCINIO*/

create table tirocinio(
magazziniere varchar(20),
caporeparto varchar(20),
inizio date,
fine date ,
primary key(magazziniere),
unique(caporeparto),
foreign key (magazziniere) references impiegato(cf)
on update cascade on delete cascade,
foreign key (caporeparto) references impiegato(cf)
on update cascade on delete cascade,
index (magazziniere),
index (caporeparto)
)engine = InnoDB;	

/*ORDINE*/

create table ordine(
gestore varchar(20),
fornitore integer,
prodotto integer,
quantita integer,
inizio date,
previsto date ,
primary key(gestore, fornitore, prodotto, inizio),

foreign key (gestore) references impiegato(cf)
on update cascade on delete cascade,
foreign key (fornitore) references fornitore(codice)
on update cascade on delete cascade,
foreign key (prodotto) references prodotto(codice)
on update cascade on delete cascade,

index (gestore),
index (fornitore),
index (prodotto)
)engine = InnoDB;	

/*ACQUISTO*/

create table acquisto(
codice_prodotto integer,
id_prodotto integer,
cliente varchar(20),
giorno date,
ora time ,
ricavo float,
/*primary key(codice_prodotto, id_prodotto),*/

foreign key (id_prodotto) references pezzi(id)
on update cascade on delete cascade,
foreign key (cliente) references cliente(cf)
on update cascade on delete cascade,

index (codice_prodotto, id_prodotto),
index (cliente)

)engine = InnoDB;	

/*GESTIONE*/

create table gestione(
magazziniere varchar(20),
filiale integer,
reparto integer,
sezione integer,

primary key(filiale, reparto, sezione),

foreign key (magazziniere) references impiegato(cf)
on update cascade on delete cascade,
foreign key (filiale, reparto, sezione) references sezione(filiale, reparto, codice)
on update cascade on delete cascade,

index (magazziniere),
index (filiale, reparto, sezione)

)engine = InnoDB;

/*CONTROLLO*/

create table controllo(
caporeparto varchar(20),
filiale integer,
codice integer,

primary key(caporeparto),
unique (filiale, codice),
foreign key (caporeparto) references impiegato(cf)
on update cascade on delete cascade,
foreign key (filiale, codice) references reparto(filiale, codice)
on update cascade on delete cascade,

index (caporeparto),
index (filiale, codice)

)engine = InnoDB;

--______________________________________________ TRIGGERS ______________________________________________


/* 1 Un impiegato controlla un solo reparto e solo se è caporeparto*/

delimiter //
create trigger caporeparto
before insert on controllo
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è caporeparto';
if(select ruolo from impiegato where cf = new.caporeparto ) != 'caporeparto'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

delimiter //
create trigger caporeparto1
before update on controllo
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è caporeparto';
if(select ruolo from impiegato where cf = new.caporeparto ) != 'caporeparto'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

/*2 L'impiegato può effettuare ordini solo se è gestore*/

delimiter //
create trigger gestore
before insert on ordine
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è gestore';
if(select ruolo from impiegato where cf = new.gestore ) != 'gestore'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

delimiter //
create trigger gestore1
before update on ordine
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è gestore';
if(select ruolo from impiegato where cf = new.gestore ) != 'gestore'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

/*3 Un impiegato gestisce una sezione solo se è magazziniere*/
delimiter //
create trigger magazziniere
before insert on gestione
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è magazziniere';
if(select ruolo from impiegato where cf = new.magazziniere ) != 'magazziniere'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

delimiter //
create trigger magazziniere1
before update on gestione
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è magazziniere';
if(select ruolo from impiegato where cf = new.magazziniere ) != 'magazziniere'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

/*4 Il tirocinio avviene solo tra impiegato con ruolo magazziniere e caporeparto*/

delimiter //
create trigger apprendistato
before insert on tirocinio
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è magazziniere';
if(select ruolo from impiegato where cf = new.magazziniere ) != 'magazziniere'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

set errorMessage = 'Questo impiegato non è caporeparto';
if(select ruolo from impiegato where cf = new.caporeparto ) != 'caporeparto'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

delimiter //
create trigger apprendistato1
before update on tirocinio
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Questo impiegato non è magazziniere';
if(select ruolo from impiegato where cf = new.magazziniere ) != 'magazziniere'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

set errorMessage = 'Questo impiegato non è caporeparto';
if(select ruolo from impiegato where cf = new.caporeparto ) != 'caporeparto'
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

end //
delimiter ;

/*5 L'abbonamento di cliente può essere "settimanale", "mensile", "annuale" e comporta una riduzione di prezzo
rispettivamente del 10%, 15%, 20%*/
--N.B: questo trigger implementa la business rule n.3

delimiter //
create trigger sconto
before insert on acquisto
for each row
begin

set new.ricavo= case 
	
	when (select abbonamento from cliente where cf = new.cliente ) = 'settimanale'
	then (select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto) - ((select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto)*0.10)

	when (select abbonamento from cliente where cf = new.cliente ) = 'mensile'
	then (select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto) - ((select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto)*0.15)
	
	when (select abbonamento from cliente where cf = new.cliente ) = 'annuale'
	then (select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto) - ((select prezzo from pezzi where codice_prodotto=new.codice_prodotto and id1 = new.id_prodotto)*0.20)

	else new.ricavo

end;
end //
delimiter ;

/*6 Ogni oggetto per ipotesi ha peso 1, al momento dell'inserimento in deposito bisogna implementare un trigger per insert e update*/
-- N.B: Questo trigger implementa la Business rule n.1

delimiter //
create trigger spazio
before insert on deposito
for each row
begin
declare errorMessage varchar(255);

set errorMessage = 'Spazio nella sezione terminato!';
if(select disponibile from sezione where filiale = new.filiale and reparto = new.reparto and codice = new.sezione ) = 0
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

update sezione set disponibile = (disponibile-1) where filiale = new.filiale and reparto = new.reparto and codice = new.sezione;

end //
delimiter ;

delimiter //
create trigger spazio1
before update on deposito
for each row
begin
declare errorMessage varchar(255);

set errorMessage = 'Spazio nella sezione terminato!';
if(select disponibile from sezione where filiale = new.filiale and reparto = new.reparto and codice = new.sezione ) = 0
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;

update sezione set disponibile = (disponibile+1) where filiale = old.filiale and reparto = old.reparto and codice = old.sezione;
update sezione set disponibile = (disponibile-1) where filiale = new.filiale and reparto = new.reparto and codice = new.sezione;

end //
delimiter ;

delimiter //
create trigger spazio2
after delete on deposito
for each row
begin
declare errorMessage varchar(255);

set errorMessage = 'Spazio nella sezione terminato!';

update sezione set disponibile = (disponibile+1) where filiale = old.filiale and reparto = old.reparto and codice = old.sezione;

end //
delimiter ;

/*7) Al momento dell'ordine vengono generati dei pezzi con prezzo null e codice prodotto uguale a quello dell'ordine*/

delimiter //
create trigger ordinativo
after insert on ordine
for each row
begin
DECLARE variabile INT;
Declare indice int; 
 SET variabile = 1; 
 set indice = (select max(id1) from pezzi where codice_prodotto = new.prodotto);
 WHILE variabile <= new.quantita DO 
  INSERT INTO pezzi VALUES (new.prodotto,  (variabile+indice ), null); 
  SET variabile = variabile + 1; 
 END WHILE;

end//

delimiter ;

/*8 Trasferire i dati di afferenza_corrente in afferenza_passata mettendo come fine la data corrente*/
delimiter //
create trigger trasferimento
after update on afferenza_corrente
for each row
begin
if(new.filiale != old.filiale)
then
insert into afferenza_passata values (new.impiegato,old.filiale, (select inizio from afferenza_corrente where impiegato = new.impiegato), current_date());
end if;

end//
delimiter ;

/*9a) Trigger su gestione per inserire in corrente tutti i magazzinieri con rispettiva filiale*/

delimiter //
create trigger aff_c1
after insert on gestione
for each row
begin

/*Controllo che il magazziniere non sia stato già registrato prima altrimenti lo inserisco*/
	if new.magazziniere not in (select impiegato from afferenza_corrente) 
	then
  INSERT INTO afferenza_corrente VALUES (new.magazziniere,  new.filiale, current_date());
	end if;
	
end//

delimiter ;

/*9b) Trigger su controllo per inserire in corrente tutti i caporeparto con rispettiva filiale*/

delimiter //
create trigger aff_c3
after insert on controllo
for each row
begin
	if new.caporeparto not in (select impiegato from afferenza_corrente)
	then
  INSERT INTO afferenza_corrente VALUES (new.caporeparto,  new.filiale, current_date());  
	end if;
end//

delimiter ;

/*10 Controllare che la data immessa in afferenza_passata sia minore di quella dell'afferenza_corrente*/

delimiter //
create trigger c1
before insert on afferenza_passata
for each row
begin
declare errorMessage varchar(255);
set errorMessage = 'Ci deve essere un errore di ritorno al futuro';
if datediff(new.fine,(select  max(inizio) from afferenza_corrente)) < 0 or datediff(new.inizio, new.fine) > 0
	then signal sqlstate '45000'
set MESSAGE_TEXT = errorMessage;
end if;
end//
delimiter ;

/*11 All'acquisto, il prodotto viene cancellato dal deposito*/
delimiter //
create trigger uscita
after insert on acquisto
for each row
begin
update sezione set disponibile = (disponibile+1) where

 (select d.filiale from deposito d 
  where d.prodotto = new.codice_prodotto and id_prodotto = new.id_prodotto) = filiale and
  
  (select d.reparto from deposito d 
  where d.prodotto = new.codice_prodotto and id_prodotto = new.id_prodotto) = reparto and
  
(select d.sezione from deposito d 
  where d.prodotto = new.codice_prodotto and id_prodotto = new.id_prodotto) = codice;

delete from deposito where prodotto=new.codice_prodotto and id_prodotto=new.id_prodotto;

end//
delimiter ;

--______________________________________________ PROCEDURE ______________________________________________

/*1) call cliente(codicefiscale) : visualizza tutti i dettagli di un singolo cliente nella tabella CLIENTE*/

delimiter //
create procedure cliente(in codicefiscale varchar(20))
begin
if codicefiscale in (select cf from impiegato)
then select c.nome, c.cognome, c.nascita, c.eta, c.telefono, c.abbonamento, i.matricola, i.ruolo 
	from cliente c 
	right join impiegato i on (c.cf = i.cf) 
	where c.cf = codicefiscale 
	group by c.cf;
else select * from cliente where cf = codicefiscale;
	

end if;
end //
delimiter ;

/*2) Operazione di lettura che mi consente di vedere le fasce di età dei miei clienti*/
delimiter //
create procedure fasce(in e integer)
begin
if e is null
then select eta, count(cf) as Numero_Clienti from cliente group by eta order by eta;
else select eta, count(cf) as Numero_Clienti from cliente where eta = e group by eta order by eta;
end if;
end //
delimiter ;

/*3) call acquisto(codicefiscale, codice_prodotto, id_prodotto) : 
se il cliente ha età tra i 12 e 18 anni ottiene uno sconto ulteriore del 0.08% su quello che acquista (più l'abbonamento)
se il cliente ha età tra i 18 e 28 anni ottiene uno sconto ulteriore del 0.10% su quello che acquista (più l'abbonamento)
se il cliente ha età maggiore di 18 anni ottiene uno sconto ulteriore del 0.12% su quello che acquista (più l'abbonamento)
Siccome il bonus derivato si aggiunge a quello già implementato col trigger dell'abbonamento, intervengo sul prezzo
del pezzo, non sul ricavo direttamente
*/

delimiter //
create procedure acquisto(in cod_prod integer, in id_prod integer, in codf varchar(20))
begin 
update pezzi set prezzo =	case

	when (select eta from cliente where cf = codf ) > 12 and (select eta from cliente where cf = codf ) < 18
	then 	(prezzo - prezzo*0.08)
	
			
	when (select eta from cliente where cf = codf ) >= 18 and (select eta from cliente where cf = codf ) < 28
	then 	(prezzo - prezzo*0.10)
			
	when (select eta from cliente where cf = codf ) >= 28
	then (prezzo - prezzo*0.12)

end
where codice_prodotto = cod_prod and id1 = id_prod;
insert into acquisto values (cod_prod, id_prod, codf, current_date(), current_time(), '1.1');
update pezzi set prezzo = (prezzo + prezzo*0.10) where codice_prodotto = cod_prod and id1 = id_prod;
end //
delimiter ;

/*4) call spazio(filiale) : vedo quanto spazio ho disponibile in ogni reparto di una filiale per accumulare pezzi in magazzino*/
delimiter //
create procedure spazio(in fil integer)
begin
 select s.reparto, r.nome ,sum(s.disponibile) as spazio 
 from sezione s join reparto r on(s.reparto = r.codice) 
 where s.filiale = fil 
 group by reparto;
end //
delimiter ;

/*5) Operazione di cambio*/
delimiter //
create procedure cambio(in cod_prod_nuovo integer, in id_prod_nuovo integer, in cod_prod_vecchio integer, in id_prod_vecchio integer, in cf varchar(20))

begin

  /*Mi assicuro che il pezzo da cambiare esista in deposito*/
  if (cod_prod_nuovo, id_prod_nuovo) in (select prodotto, id_prodotto from deposito)
  then
  
 /*Salvo la filiale dell'oggetto nuovo (è lì che metterò il cambio)*/
drop table if exists temp;
create temporary table temp(fil integer, rep integer, sez integer);
insert into temp values(
(select filiale from deposito where prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo),
(select reparto from deposito where prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo),
(select sezione from deposito where prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo));

/*modifico il prodotto acquistato, non uso l'update per vincoli di integrità legati all'update nelle figlie*/
insert into acquisto values(cod_prod_nuovo, id_prod_nuovo, cf, current_date(), current_time(), 1.1);
delete from acquisto where codice_prodotto = cod_prod_vecchio and id_prodotto = id_prod_vecchio;

/*segnalo che si è liberato spazio nella sezione del pezzo nuovo*/

update sezione set disponibile = (disponibile+1) where

 (select d.filiale from deposito d 
  where d.prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo) = filiale and
  
  (select d.reparto from deposito d 
  where d.prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo) = reparto and
  
(select d.sezione from deposito d 
  where d.prodotto = cod_prod_nuovo and id_prodotto = id_prod_nuovo) = codice;

/*segnalo che c'è meno spazio nella sezione del prodotto che ci stava prima*/
update sezione set disponibile = (disponibile-1) where

 (select d.filiale from deposito d 
  where d.prodotto = cod_prod_vecchio and id_prodotto = id_prod_vecchio) = filiale and
  
  (select d.reparto from deposito d 
  where d.prodotto = cod_prod_vecchio and id_prodotto = id_prod_vecchio) = reparto and
  
(select d.sezione from deposito d 
  where d.prodotto = cod_prod_vecchio and id_prodotto = id_prod_vecchio) = codice;
  
/*Cancello dal deposito l'altro oggetto*/
delete from deposito where prodotto=cod_prod_nuovo and id_prodotto=id_prod_nuovo;
/*Inserisco in deposito il pezzo scambiato, ricorrendo alla temporale di prima*/

insert into deposito values (
	(select fil from temp),
	(select rep from temp),
	(select sez from temp),
	cod_prod_vecchio, 
	id_prod_vecchio, 
	current_time(), 
	current_date(), 
	null);
/*Se non funziona rimettere qui la delete*/
end if;
end//
delimiter ;

--6) Bilancio complessivo

delimiter //
create procedure bilancio()
begin
declare abbonamenti float;
declare acquisti float;
declare spese_personale float;
declare spese_immobili float;

set abbonamenti = (select sum(entrata) from abbonamenti);
set acquisti = (select sum(ricavo) from acquisto);
set spese_personale = (select sum(retribuzione) from spese);
set spese_immobili = (select (100*count(codice)) from filiale);

select abbonamenti, acquisti, spese_personale, spese_immobili;

end //
delimiter ;

/*7) Operazione che mi permette di vedere mediamente gli acquisti da chi sono stati fatti e in che quantita*/

delimiter //
create procedure acquisti(in e integer)
begin
if e is null
then select eta, count(cf) as Numero_Clienti, avg(ricavo) as Spesa_media from cliente join acquisto on (cf=cliente) group by eta order by eta;
else select eta, count(cf) as Numero_Clienti, avg(ricavo) as Spesa_media from cliente join acquisto on (cf=cliente) where eta = e group by eta order by eta;
end if;
end //
delimiter ;

/*8) Procedura di trasferimento*/

delimiter //
create procedure trasferisci (in impieg varchar(20), in fil integer, fine_corrente date)
begin
update afferenza_corrente set filiale = fil where impiegato = impieg;
 
update afferenza_corrente set inizio=current_date() where impiegato = impieg;
end //
delimiter ;

/*9) call percorso(codicefiscale) : una join delle due tabelle di storicizzazione per vedere i mesi di un impiegato in una filiale
da sistemare alla luce della view*/
delimiter //
create procedure percorso(in codicefiscale varchar(20))
begin
if codicefiscale in (select cf from impiegato)
then 
	select c.impiegato, c.filiale as Corrente, p.filiale as Passata , sum(coalesce (datediff(p.fine,p.inizio), 0)+ datediff(current_date(), c.inizio)) as giorni_trascorsi
	from afferenza_corrente c 
	left join  afferenza_passata p 
	on (c.impiegato = p.impiegato) 
	where c.impiegato = codicefiscale ;
end if ;
end //
delimiter ;

-- Altre procedure non menzionate 

-- Vedo quanti prodotti non sono in magazzino e ne mostro i nomi
delimiter //
create procedure collocandi()
begin
select nome,marca,codice, id1, prezzo from pezzi join prodotto on (codice_prodotto= codice) where codice_prodotto not in (select prodotto from deposito);
end //
delimiter ;

-- Inserimento di inter blocchi di pezzi in una sezione in data e ora dell'inserimento
delimiter //
create procedure posa(fil integer, rep integer, sez integer, prod integer, mitt integer)
begin
insert into deposito 
select fil, rep, sez, prod, id1 , current_time(), current_date(), mitt 
from pezzi 
join prodotto 
on(codice_prodotto= codice) 
where codice = prod;
end//
delimiter ;

--Aggiornamento eta
delimiter //
create procedure eta()
begin
update cliente set eta = (datediff(current_date(), nascita)/365);
end// 
delimiter ;

-- ______________________________________________ VISTE ______________________________________________


--una visione del rendimento generale di un prodotto acquistato

create view media as
select nome, marca, count(cliente) as Acquistato, avg(ricavo) as Ricavo_medio 
from prodotto 
join acquisto on (codice = codice_prodotto)
group by codice_prodotto;

--una visione sulle spese totali

create view spese as
select c.impiegato, sum(coalesce (datediff(p.fine,p.inizio), 0)+datediff(current_date(), c.inizio)) as giorni_trascorsi, case 
	
	when(select ruolo from impiegato where cf = c.impiegato)= 'magazziniere'then  sum(coalesce (datediff(p.fine,p.inizio) , 0) + datediff(current_date(), c.inizio))*45
	when(select ruolo from impiegato where cf = c.impiegato) = 'caporeparto' then sum(coalesce (datediff(p.fine,p.inizio), 0)+ datediff(current_date(), c.inizio))*55
	when(select ruolo from impiegato where cf = c.impiegato) = 'gestore' then sum(coalesce (datediff(p.fine,p.inizio), 0)+ datediff(current_date(), c.inizio))*70
	end as retribuzione
	from afferenza_corrente c 
	left join  afferenza_passata p 
	on (c.impiegato = p.impiegato)  
	group by c.impiegato;
	
	
	
--implementare una vista che mi permette di vedere quanti pezzi di un prodotto ci sono complessivamente 
--(per vederlo nella singola filiale basta guardare deposito)
create view unita as 
select nome, marca, prodotto, count(prodotto) as n_pezzi
from deposito join prodotto 
on (codice = prodotto)
group by prodotto;

/*Es. sbagliato: select nome, count(prodotto) from deposito, prodotto group by prodotto;
Bisogna fare la join: select nome, marca, prodotto, count(prodotto) from deposito join prodotto on (codice = prodotto) group by prodotto;*/

--implementare una vista con il ricavo degli abbonamenti che i clienti hanno acquistato
create view abbonamenti as
select abbonamento, count(abbonamento) n_abbonamenti, case 
when abbonamento = 'settimanale' then (count(abbonamento)*25.00)
when abbonamento = 'mensile' then (count(abbonamento)*50.00)
when abbonamento = 'annuale' then (count(abbonamento)*60.00)
end as entrata
from cliente group by abbonamento;


--implementare una vista che mostri il valore totale di prodotti stipati in ogni filiale

create view potenziale as
select filiale, sum(prezzo) as Valore_potenziale
from deposito 
join pezzi on(codice_prodotto = prodotto and id1=id_prodotto)
join prodotto  on(prodotto = codice)
group by filiale;


--implementare una vista con i dettagli sui pezzi e rispettivo valore in magazzino

create view potenziale_prodotto
select nome, marca, prodotto, sum(prezzo) as Valore_potenziale
     from deposito
     join pezzi on(codice_prodotto = prodotto and id1=id_prodotto)
     join prodotto  on(prodotto = codice)
     group by prodotto;


-- ______________________________________________ CODICE TERMINATO ______________________________________________

--____________________________________________________________________________________________________________________________

-- ______________________________________________ QUALCHE INSERT ______________________________________________

/*Nuove insert per PREFERITI*/
/*cf varchar(20), 
immagine varchar(100),
ora time,
giorno date,*/
/*insert into preferiti(cf, immagine, ora, giorno) values ('CTFR55','http://localhost/Sogno_Italiano/Immagini/magliettaRagazzo.jfif',current_time(), current_date());*/
insert into preferiti(cliente_cf, pezzi_id, immagine, ora, giorno) values ('CTFR55','12', 'http://localhost/Sogno_Italiano/Immagini/magliettaRagazzo.jfif',current_time(), current_date());
insert into preferiti(cliente_cf, pezzi_id, immagine, ora, giorno) values ('CTFR55','14', 'http://localhost/Sogno_Italiano/Immagini/magliettaRagazza.jfif',current_time(), current_date());
insert into preferiti(cliente_cf, pezzi_id, immagine, ora, giorno) values ('CTFR56','14', 'http://localhost/Sogno_Italiano/Immagini/magliettaRagazza.jfif',current_time(), current_date());
/*PRODOTTO (CODICE, NOME, MARCA, IMMAGINE)*/

insert into prodotto values('1', 'Camicia', 'Navigare', 'CamiciaJeansUomo.jpg');
insert into prodotto values('2', 'Maglia', 'Gucci', 'MagliaDonna.jpg');
insert into prodotto values('3', 'Felpa', 'Adidas', 'FelpaRagazza.jpg');
insert into prodotto values('4', 'Jeans', 'Gucci', 'JeansUomo.jpg');
insert into prodotto values('5', 'Camicia', 'Nikita', 'CamiciaUomo.jpg');
insert into prodotto values('6', 'Pigiama', 'Trussardi', 'PigiamaUomo.jpg');
insert into prodotto values('7', 'Jeans', 'Wrangler', 'CamiciaJeansUomo.jpg');
insert into prodotto values('8', 'Parka', 'Robe di kappa', 'ParkaRagazza.jpg');
insert into prodotto values('9', 'Felpa', 'Tommy Hilfiger', 'felpa.jfif');
insert into prodotto values('10', 'Camicia', 'Supreme', 'CamiciaDonna.jpg');
insert into prodotto values('11', 'Camicia', 'Levi s', 'CamiciaJeansUomo.jpg');
insert into prodotto values('12', 'Maglietta', 'Nike', 'magliettaRagazzo.jfif');
insert into prodotto values('13', 'Maglietta', 'Xiaoyao', 'magliettaRagazzo1.jfif');
insert into prodotto values('14', 'Maglietta', 'Norway', 'magliettaRagazza.jfif');


/*PEZZI (CODICE_PRODOTTO, ID, PREZZO)*/
/*codice_prodotto integer, 
id1 integer, 
prezzo float,*/
insert into pezzi(codice_prodotto, id1, prezzo) values ('1','1','179.38');
insert into pezzi(codice_prodotto, id1, prezzo) values ('1','2','179.38');
insert into pezzi(codice_prodotto, id1, prezzo) values ('1','3','179.38');
insert into pezzi(codice_prodotto, id1, prezzo) values ('1','4','179.38');
insert into pezzi (codice_prodotto, id1, prezzo)values ('1','5','179.38');
insert into pezzi(codice_prodotto, id1, prezzo) values ('2','1','44.7');
insert into pezzi(codice_prodotto, id1, prezzo) values ('2','2','44.17');
insert into pezzi(codice_prodotto, id1, prezzo) values ('2','3','44.17');
insert into pezzi(codice_prodotto, id1, prezzo) values ('2','4','44.17');
insert into pezzi (codice_prodotto, id1, prezzo)values ('2','5','44.17');
insert into pezzi(codice_prodotto, id1, prezzo) values ('3','1','110.59');
insert into pezzi(codice_prodotto, id1, prezzo) values ('3','2','110.59');
insert into pezzi(codice_prodotto, id1, prezzo) values ('3','3','110.59');
insert into pezzi(codice_prodotto, id1, prezzo) values ('3','4','110.59');
insert into pezzi(codice_prodotto, id1, prezzo) values ('3','5','110.59');
insert into pezzi(codice_prodotto, id1, prezzo) values ('4','1','14.6');
insert into pezzi(codice_prodotto, id1, prezzo) values ('4','2','14.56');
insert into pezzi(codice_prodotto, id1, prezzo) values ('4','3','14.56');
insert into pezzi(codice_prodotto, id1, prezzo) values ('4','4','14.56');
insert into pezzi(codice_prodotto, id1, prezzo) values ('4','5','14.56');
insert into pezzi(codice_prodotto, id1, prezzo) values ('5','1','137.68');
insert into pezzi(codice_prodotto, id1, prezzo) values ('5','2','137.68');
insert into pezzi(codice_prodotto, id1, prezzo) values ('5','3','137.68');
insert into pezzi(codice_prodotto, id1, prezzo) values ('5','4','137.68');
insert into pezzi(codice_prodotto, id1, prezzo) values ('5','5','137.68');
insert into pezzi(codice_prodotto, id1, prezzo) values ('6','1','157.96');
insert into pezzi(codice_prodotto, id1, prezzo) values ('6','2','157.96');
insert into pezzi(codice_prodotto, id1, prezzo) values ('6','3','157.96');
insert into pezzi(codice_prodotto, id1, prezzo) values ('6','4','157.96');
insert into pezzi(codice_prodotto, id1, prezzo) values ('6','5','157.96');
insert into pezzi(codice_prodotto, id1, prezzo) values ('7','1','162.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('7','2','162.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('7','3','162.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('7','4','162.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('7','5','162.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('8','1','6.71');
insert into pezzi(codice_prodotto, id1, prezzo) values ('8','2','6.71');
insert into pezzi(codice_prodotto, id1, prezzo) values ('8','3','6.71');
insert into pezzi (codice_prodotto, id1, prezzo)values ('8','4','6.71');
insert into pezzi(codice_prodotto, id1, prezzo) values ('8','5','6.71');
insert into pezzi(codice_prodotto, id1, prezzo) values ('9','1','70.02');
insert into pezzi(codice_prodotto, id1, prezzo) values ('9','2','70.02');
insert into pezzi(codice_prodotto, id1, prezzo) values ('9','3','70.02');
insert into pezzi(codice_prodotto, id1, prezzo) values ('9','4','70.02');
insert into pezzi(codice_prodotto, id1, prezzo) values ('9','5','70.02');
insert into pezzi(codice_prodotto, id1, prezzo) values ('10','1','85.78');
insert into pezzi(codice_prodotto, id1, prezzo) values ('10','2','85.78');
insert into pezzi(codice_prodotto, id1, prezzo) values ('10','3','85.78');
insert into pezzi(codice_prodotto, id1, prezzo) values ('10','4','85.78');
insert into pezzi(codice_prodotto, id1, prezzo) values ('10','5','85.78');
insert into pezzi(codice_prodotto, id1, prezzo) values ('11','1','147.24');
insert into pezzi(codice_prodotto, id1, prezzo) values ('11','2','147.24');
insert into pezzi(codice_prodotto, id1, prezzo) values ('11','3','147.24');
insert into pezzi(codice_prodotto, id1, prezzo) values ('11','4','147.24');
insert into pezzi(codice_prodotto, id1, prezzo) values ('11','5','147.24');
insert into pezzi(codice_prodotto, id1, prezzo) values ('12','1','16.6');
insert into pezzi(codice_prodotto, id1, prezzo) values ('12','2','16.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('12','3','16.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('12','4','16.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('12','5','16.76');
insert into pezzi(codice_prodotto, id1, prezzo) values ('13','1','18.98');
insert into pezzi(codice_prodotto, id1, prezzo) values ('13','2','18.98');
insert into pezzi(codice_prodotto, id1, prezzo) values ('13','3','18.98');
insert into pezzi(codice_prodotto, id1, prezzo) values ('13','4','18.98');
insert into pezzi(codice_prodotto, id1, prezzo) values ('13','5','18.98');
insert into pezzi(codice_prodotto, id1, prezzo) values ('14','1','30.74');
insert into pezzi (codice_prodotto, id1, prezzo)values ('14','2','30.74');
insert into pezzi (codice_prodotto, id1, prezzo)values ('14','3','30.74');
insert into pezzi (codice_prodotto, id1, prezzo)values ('14','4','30.74');
insert into pezzi (codice_prodotto, id1, prezzo)values ('14','5','30.74');



/*CLIENTE (CF, NOME, COGNOME, TELEFONO, NASCITA, ETA, ABBONAMENTO, PASSWORD)*/


/*PASSWORD DI DEFAULT DEI CLIENTI PROVA è L'HASH DI "123456789" OTTENUTO CON md5('SognoItaliano!1') LATO PHP*/

insert into cliente values ('SEMADA08','Sempronio', 'Adamo','003083437','1960-04-03',(datediff(current_timestamp(),nascita )/365),'settimanale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());

insert into cliente values ('LUIVER42','Luigi', 'Vergari','864764342','1977-3-2',(datediff(current_timestamp(),nascita )/365),'settimanale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp() );
insert into cliente values ('LUIVER82','Luigi', 'Vergari','745772823','2001-10-7',(datediff(current_timestamp(),nascita )/365),'settimanale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());

insert into cliente values ('FRACAT01','Francesco', 'Catanzaro','727320636','1990-11-0',(datediff(current_timestamp(),nascita )/365),'settimanale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());
insert into cliente values ('LUIVER67','Luigi', 'Vergari','452312027','2000-11-3',(datediff(current_timestamp(),nascita )/365),'settimanale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());

insert into cliente values ('VALDES61','Valentina', 'Desantis','435261274','1977-2-6',(datediff(current_timestamp(),nascita )/365),'mensile','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());
insert into cliente values ('EMAPAN73','Emanuele', 'Panascia','615066616','2001-1-10',(datediff(current_timestamp(),nascita )/365),'mensile','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());
insert into cliente values ('CARDES56','Carolina', 'Desantis','548128735','1977-1-4',(datediff(current_timestamp(),nascita )/365),'mensile','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());


insert into cliente values ('GIUBEL62','Giulio', 'Belfiore','244014632','2002-2-9',(datediff(current_timestamp(),nascita )/365),'annuale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());
insert into cliente values ('LUIGUE15','Luigi', 'Guerrera','880607467','1994-5-7',(datediff(current_timestamp(),nascita )/365),'annuale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());
insert into cliente values ('FRAMAR34','Francesco', 'Marano','050067412','2001-10-9',(datediff(current_timestamp(),nascita )/365),'annuale','b42fc6e1122b95d186773704f69bb634', current_timestamp(), current_timestamp());


/*IMPIEGATO(CF, NOME, COGNOME, TELEFONO, NASCITA, MATRICOLA, RUOLO)*/

insert into impiegato values ('GIUBEL62','Giulio', 'Belfiore','244014632','2002-2-9',49387 ,'gestore');
insert into impiegato values ('LUIGUE15','Luigi', 'Guerrera','880607467','1994-5-7',49388 ,'gestore');
insert into impiegato values ('FRAMAR34','Francesco', 'Marano','050067412','2001-10-9',49389 ,'gestore');

insert into impiegato values ('SIMPAN71','Simone', 'Panascia','083744700','1980-10-10','87670','gestore');
insert into impiegato values ('SEMFIL80','Sempronio', 'Filadelfo','603546273','1985-7-4','77144','gestore');
insert into impiegato values ('LUIBEL65','Luigi', 'Belfiore','152023003','1975-6-11','54644','gestore');
insert into impiegato values ('EMABEL58','Emanuele', 'Belfiore','487838773','1985-9-10','35476','gestore');
insert into impiegato values ('SIMBEL02','Simone', 'Belfiore','003732782','1990-10-2','16802','gestore');

insert into impiegato values ('EMACAT40','Emanuele', 'Catanzaro','370433652','1990-9-5','14167','caporeparto');
insert into impiegato values ('LUIVER72','Luigi', 'Vergari','264133362','1990-6-6','64313','caporeparto');
insert into impiegato values ('GIUADA04','Giulio', 'Adamo','013464241','1990-2-2','03637','caporeparto');
insert into impiegato values ('CARBEL54','Carolina', 'Belfiore','387106628','1990-8-6','41641','caporeparto');
insert into impiegato values ('LUICAT76','Luigi', 'Catanzaro','624667542','1970-8-10','66007','caporeparto');
insert into impiegato values ('CARADA18','Carolina', 'Adamo','324822132','1980-1-2','68387','caporeparto');
insert into impiegato values ('GIUFIL86','Giulio', 'Filadelfo','127444672','1990-3-3','74485','caporeparto');
insert into impiegato values ('LUIDES86','Luigi', 'Desantis','242775187','1990-2-1','57444','caporeparto');
insert into impiegato values ('LUIMAR88','Luigi', 'Marano','508874473','1989-4-8','25333','caporeparto');
insert into impiegato values ('SIMDES16','Simone', 'Desantis','615351818','1991-7-3','41257','caporeparto');


insert into impiegato values ('FRAMAR62','Francesco', 'Marano','711816547','1993-3-9','73873','magazziniere');
insert into impiegato values ('STEADA67','Stefania', 'Adamo','874713667','1993-11-9','07377','magazziniere');
insert into impiegato values ('GIUCAT25','Giulio', 'Catanzaro','015252417','1993-2-0','41747','magazziniere');
insert into impiegato values ('EMADES16','Emanuele', 'Desantis','412307888','1993-3-9','08137','magazziniere');
insert into impiegato values ('STEADA31','Stefania', 'Adamo','220326641','1993-11-2','12825','magazziniere');
insert into impiegato values ('CARFIL20','Carolina', 'Filadelfo','547408546','1993-8-9','54273','magazziniere');
insert into impiegato values ('EMAADA76','Emanuele', 'Adamo','777641821','1993-7-4','00661','magazziniere');
insert into impiegato values ('FRAPAN66','Francesco', 'Panascia','823687584','1993-5-4','46013','magazziniere');
insert into impiegato values ('SIMPAN63','Simone', 'Panascia','130814476','1993-1-5','63810','magazziniere');
insert into impiegato values ('SEMFIL82','Sempronio', 'Filadelfo','046672451','1993-9-2','74540','magazziniere');
insert into impiegato values ('VALBEL55','Valentina', 'Belfiore','545543771','1993-7-1','18271','magazziniere');
insert into impiegato values ('GIUFIL71','Giulio', 'Filadelfo','686224540','1993-10-10','56647','magazziniere');

insert into impiegato values ('STECAT44','Stefania', 'Catanzaro','318241541','1993-7-10','17022','magazziniere');
insert into impiegato values ('LUIVER13','Luigi', 'Vergari','527306274','1993-3-11','64265','magazziniere');
insert into impiegato values ('MATCAT22','Matteo', 'Catanzaro','126650541','1993-8-4','88511','magazziniere');
insert into impiegato values ('SEMADA71','Sempronio', 'Adamo','005810776','1993-1-3','26157','magazziniere');
insert into impiegato values ('STEFIL83','Stefania', 'Filadelfo','525070712','1993-1-6','67011','magazziniere');
insert into impiegato values ('FRAADA57','Francesco', 'Adamo','644243268','1993-11-8','81327','magazziniere');
insert into impiegato values ('STEPAN32','Stefania', 'Panascia','082527478','1993-1-8','81843','magazziniere');
insert into impiegato values ('SEMBEL68','Sempronio', 'Belfiore','747547335','1993-4-7','80573','magazziniere');



/*FORNITORE(CODICE, NOME, SEDE, VIA)*/


insert into fornitore values ('65783','Gate Eleven s.r.l.','Palermo','Via Garibaldi 12', '../Immagini/Database/gateEleven.jpg');
insert into fornitore values ('68340','Tech by Tex','Roma','Via Castelvecchio 77','../Immagini/Database/tec-by-tex.png');
insert into fornitore values ('26144','Andes Organic','Palermo','Via Federico II 33','../Immagini/Database/fumettoDonna.jpg');
insert into fornitore values ('14665','Tech by Tex','Pisa','Via Aldo Moro 31','../Immagini/Database/tec-by-tex.png');
insert into fornitore values ('84003','Tech by Tex','Pisa','Via Manzoni 89','../Immagini/Database/tec-by-tex.png');
insert into fornitore values ('35005','Double A','Firenze','Viale XX Settembre 64','../Immagini/Database/doubleA.gif');
insert into fornitore values ('75047','Gate Eleven s.r.l.','Firenze','Viale XX Settembre 64','../Immagini/Database/gateEleven.jpg');
insert into fornitore values ('30360','Gate Eleven s.r.l.','Catania','Via Garibaldi 12','../Immagini/Database/gateEleven.jpg');
insert into fornitore values ('61448','Pricy B2B','Firenze','Viale Borgo 55','../Immagini/Database/fumettoDonna.jpg');
insert into fornitore values ('73251','Gate Eleven s.r.l.','Milano','Viale XX Settembre 64','../Immagini/Database/gateEleven.jpg');
insert into fornitore values ('11416','Vero Style s.r.l.','Pisa','Via Aldo Moro 31','../Immagini/Database/vero-style.png');
insert into fornitore values ('14024','Double A','Milano','Via Castelvecchio 77','../Immagini/Database/doubleA.gif');
insert into fornitore values ('81308','Vero Style s.r.l.','Milano','Via Aldo Moro 31','../Immagini/Database/vero-style.png');
insert into fornitore values ('64832','Double A','Bologna','Viale Borgo 55','../Immagini/Database/doubleA.gif');
insert into fornitore values ('56187','Vero Style s.r.l.','Pisa','Via Castelvecchio 77','../Immagini/Database/vero-style.png');
insert into fornitore values ('25766','Vero Style s.r.l.','Roma','Via Castelvecchio 77','../Immagini/Database/vero-style.png');
insert into fornitore values ('76845','Tech by Tex','Pisa','Viale Borgo 55','../Immagini/Database/tec-by-tex.png');
insert into fornitore values ('63612','Vesto italiano','Firenze','Via Manzoni 89','../Immagini/Database/fumettoDonna.jpg');
insert into fornitore values ('82810','Double A','Roma','Via Aldo Moro 31','../Immagini/Database/doubleA.gif');
insert into fornitore values ('15141','Double A','Milano','Via Federico II 33','../Immagini/Database/doubleA.gif');


/*FILIALE(CODICE, CITTA, VIA)*/


insert into filiale values ('01331','Catania','Viale Borgo 55');
insert into filiale values ('24160','Torino','Via Manzoni 89');
insert into filiale values ('82351','Roma','Via Badoglio 48');
insert into filiale values ('67234','Firenze','Viale Borgo 55');

/*AFFERENZA_CORRENTE (IMPIEGATO, FILIALE, INIZIO)*/

/*Bisogna piazzare i gestori, gli altri si fanno facile con un trigger*/

/*AFFERENZA_PASSATA(IMPIEGATO, FILIALE, INIZIO, FINE)*/
insert into afferenza_passata values('STEADA67',24160, '2020-1-1','2020-4-1');
insert into afferenza_passata values('LUIVER72',24160, '2020-1-1','2020-4-1');



/*REPARTO (FILIALE, CODICE, NOME )*/

insert into reparto values ('01331','21','City', 'repartoRagazzo.jpg' );
insert into reparto values ('24160','22','Classico', 'repartoDonna.jpg');
insert into reparto values ('67234','23','Street', 'grucce.jpg' );
insert into reparto values ('82351','22','Casual', 'repartoDonna.jpg');


insert into reparto values ('01331','21','City', 'repartoRagazzo.jpg');
insert into reparto values ('01331','23','Sportivo', 'grucce.jpg');
insert into reparto values ('01331','24','Elegante', 'repartoUomo.jpeg');
insert into reparto values ('01331','21','City', 'repartoRagazzo.jpg');

insert into reparto values ('24160','22','Classico', 'repartoDonna.jpg');
insert into reparto values ('24160','21','City', 'repartoRagazzo.jpg');
insert into reparto values ('24160','22','Classico', 'repartoDonna.jpg');
insert into reparto values ('24160','23','Sportivo', 'grucce.jpg');


insert into reparto values ('82351','24','Elegante', 'repartoUomo.jpeg');
insert into reparto values ('82351','23','Sportivo', 'grucce.jpg');
insert into reparto values ('82351','21','City', 'repartoRagazzo.jpg');


insert into reparto values ('67234','21','City', 'repartoRagazzo.jpg');
insert into reparto values ('67234','24','Elegante', 'repartoUomo.jpeg');


/*SEZIONE (FILIALE, REPARTO, CODICE,  NOME, DISPONIBILE)*/

insert into sezione values ('01331','22','1','Ragazza','195');
insert into sezione values ('24160','21','1','Bambino','195');
insert into sezione values ('82351','24','1','Uomo','195');
insert into sezione values ('67234','21','1','Ragazzo','195');

insert into sezione values ('24160','22','1','Ragazza','69');
insert into sezione values ('24160','24','3','Uomo','38');
insert into sezione values ('01331','22','3','Donna','36');
insert into sezione values ('01331','21','1','Ragazzo','44');
insert into sezione values ('01331','21','2','Ragazzo','175');
insert into sezione values ('01331','21','3','Ragazzo','180');
insert into sezione values ('82351','24',,'0','Uomo','115');
insert into sezione values ('82351','21','0','Ragazzo','59');
insert into sezione values ('82351','22','2','Ragazza','178');
insert into sezione values ('67234','22','2','Ragazza','53');
insert into sezione values ('01331','24','1','Uomo','40');
insert into sezione values ('82351','24','2','Uomo','171');
insert into sezione values ('67234','22','2','Donna','170');
insert into sezione values ('82351','22','3','Ragazza','147');
insert into sezione values ('67234','21','3','Ragazzo','46');
insert into sezione values ('01331','24','2','Uomo','131');
insert into sezione values ('82351','22','2','Donna','93');
insert into sezione values ('82351','24','0','Uomo','136');
insert into sezione values ('24160','22','3','Ragazza','107');
insert into sezione values ('82351','22','2','Donna','198');
insert into sezione values ('24160','24','2','Uomo','168');
insert into sezione values ('82351','22','2','Donna','22');
insert into sezione values ('82351','24','3','Uomo','97');
insert into sezione values ('67234','21', '4', 'Bambino', '79');
insert into sezione values ('67234','21', '4', 'Bambino', '79');



/*DEPOSITO(FILIALE, REPARTO, SEZIONE, PRODOTTO, ID_PRODOTTO, ORA, GIORNO, MITTENTE)*/

insert into deposito values ('1331','21','1', '1', '1', current_time(), current_date(), '65783');
insert into deposito values ('1331','22','1', '2', '2', current_time(), current_date(), '65783');
insert into deposito values ('1331','21','2', '1', '3', current_time(), current_date(), '65783');
insert into deposito values ('1331','24','2', '1', '4', current_time(), current_date(), '65783');
insert into deposito values ('1331','22','1', '14', '1', current_time(), current_date(), '65783');

insert into deposito values ('1331','21','1', '9', '1', current_time(), current_date(), '84003');
insert into deposito values ('1331','22','1', '2', '2', current_time(), current_date(), '84003');
insert into deposito values ('1331','22','1', '2', '3', current_time(), current_date(), '84003');
insert into deposito values ('1331','24','1', '4', '4', current_time(), current_date(), '11416');
insert into deposito values ('1331','24','1', '4', '5', current_time(), current_date(), '11416');

insert into deposito values ('82351','24','3', '4', '1', current_time(), current_date(), '25766');
insert into deposito values ('82351','21','0', '7', '2', current_time(), current_date(), '25766');
insert into deposito values ('82351','22','2', '3', '3', current_time(), current_date(), '25766');
insert into deposito values ('82351','22','2', '3', '4', current_time(), current_date(), '76845');
insert into deposito values ('82351','21','0', '6', '5', current_time(), current_date(), '76845');

/*TIROCINIO(MAGAZZINIERE, CAPOREPARTO, INIZIO, FINE)*/
insert into tirocinio values ('FRAMAR62','EMACAT40', current_date(), date_add(current_date(), interval + 2 month));
insert into tirocinio values ('EMACAT40','FRAMAR62', current_date(), date_add(current_date(), interval + 2 month));

/*ORDINE(GESTORE, FORNITORE, PRODOTTO, QUANTITA, INIZIO, PREVISTO )*/
insert into ordine values('SIMPAN71', '65783', 1 , 5, current_date(),DATE_ADD(current_date(), interval 5 day));
insert into ordine values('SIMPAN71', 11416, 2, 10, current_date(), date_add(current_date, interval 5 day));

/*ACQUISTO (CODICE_PRODOTTO, ID_PRODOTTO, CLIENTE, GIORNO, ORA, RICAVO)*/

insert into acquisto values (1,1,'SEMADA08',current_date(), current_time(),'179.38');
insert into acquisto values (1,2,'SEMADA08',current_date(), current_time(),'1');
insert into acquisto values (1,1,'SEMADA08',current_date(), current_time(),'179.38');
insert into acquisto values (1,2,'GIUBEL62',current_date(), current_time(),'1');
insert into acquisto values (2,5,'GIUBEL62',current_date(), current_time(),'1');
insert into acquisto values (3,5,'GIUBEL62',current_date(), current_time(),'1');


/*GESTIONE(MAGAZZINIERE, FILIALE, REPARTO, SEZIONE)*/
insert into gestione values('EMADES16', 1331, 1,1);
insert into gestione values('FRAADA57', 24160, 1,1);


insert into gestione values ('FRAMAR62','1331','37860','2');
insert into gestione values ('STEADA67','1331','86178','2');
insert into gestione values ('GIUCAT25','1331','27157','3');
insert into gestione values ('EMADES16','1331','11708','1');
insert into gestione values ('STEADA31','24160','07805','1');
insert into gestione values ('CARFIL20','24160','27671','3');
insert into gestione values ('EMAADA76','24160','31555','2');
insert into gestione values ('FRAPAN66','82351','10068','1');
insert into gestione values ('SIMPAN63','67234','66186','5');
insert into gestione values ('SEMFIL82','1331','37860','1');
insert into gestione values ('SEMFIL82','1331','37860','3');

/*CONTROLLO(CAPOREPARTO, FILIALE, CODICE)*/

insert into controllo values ('EMACAT40','01331','37860');
insert into controllo values ('LUIVER72','01331','86178');
insert into controllo values ('GIUADA04','01331','27157');
insert into controllo values ('CARBEL54','01331','11708');
insert into controllo values ('LUICAT76','24160','07805');
insert into controllo values ('CARADA18','24160','27671');
insert into controllo values ('GIUFIL86','24160','31555');
insert into controllo values ('LUIDES86','24160','33044');
insert into controllo values ('LUIMAR88','82351','10068');
insert into controllo values ('SIMDES16','67234','66186');

Qualche insert per il database
call posa(1331, 21, 1, 13, 1146);
call posa(82351, 22, 2, 14, 1146);
call posa(82351, 22, 2, 8, 1146);
call posa(1331, 24, 1, 6, 1146);
call posa(1331, 21, 1, 12, 1146);


--N.B:  Ho dimenticato di mettere alcuni valori non nulli, ho rimediato dopo usando il seguente costrutto su ogni tabella interessata
--alter table nometab add constraint nomeconstraint check(attributo is not null);

-- Fine