;;;========================================================
;;; Sistema Experto Deportistas Mundiales:
;;;
;;; Es un sistema experto que hace preguntas y en base a 
;;; los datos determina que personaje del deporte mundial 
;;; es y dice sus logros.
;;;
;;; Asignatura: Inteligencia Artificial
;;;
;;; Hecho por: Eddy Fidel, Ricardo De la Rosa, 
;;;         Maicel Abreu y Wilfredo Hernández
;;;========================================================


;;;========================================================
;;; Funciones
;;;========================================================


(deffunction preguntar (?interrogante $?valores-permitidos)
   (printout t ?interrogante)
   (bind ?respuesta (read))
   (if (lexemep ?respuesta) 
       then (bind ?respuesta (lowcase ?respuesta)))
   (while (not (member ?respuesta ?valores-permitidos)) do
      (printout t ?interrogante)
      (bind ?respuesta (read))
      (if (lexemep ?respuesta) 
          then (bind ?respuesta (lowcase ?respuesta))))
   ?respuesta)

(deffunction responder-si-o-no (?interrogante)
   (bind ?respuesta (preguntar ?interrogante si no s n))
   (if (or (eq ?respuesta si) (eq ?respuesta s))
       then si 
       else no))

(deffunction responder-baloncesto-o-tennis (?interrogante)
   (bind ?respuesta (preguntar ?interrogante baloncesto tennis b t))
   (if (or (eq ?respuesta baloncesto) (eq ?respuesta b))
       then baloncesto 
       else tennis))

(deffunction responder-baloncesto-o-golf (?interrogante)
   (bind ?respuesta (preguntar ?interrogante baloncesto golf b g))
   (if (or (eq ?respuesta baloncesto) (eq ?respuesta b))
       then baloncesto 
       else golf))


;;;========================================================
;;; Reglas generales
;;;========================================================


(defrule determinar-deportista-mundial ""
   (not (deportista-mundial ?))
   (not (logros ?))
   =>
   (assert (deportista-mundial
      (preguntar "Los deportistas mundiales que desea consultar, ¿Nacieron antes o después del 1975? (antes/despues) "
                    antes despues))))


;;;========================================================
;;; Reglas de preguntas antes del 1975
;;;========================================================


(defrule determinar-beisbolista ""
   (deportista-mundial antes)
   (not (logros ?))
   =>
   (assert (antes-beisbolista (responder-si-o-no "El deportista mundial, ¿Es un beisbolista? (si/no) "))))
   
(defrule determinar-beisbolista-temporadas ""
   (deportista-mundial antes)
   (antes-beisbolista si)
   (not (logros ?))
   =>
   (assert (antes-beisbolista-temporadas (responder-si-o-no "El beisbolista profesional, ¿Ha jugado más de 15 temporadas en las Grandes Ligas? (si/no) "))))

(defrule determinar-baloncesto-golf ""
   (deportista-mundial antes)
   (antes-beisbolista no)
   (not (logros ?))
   =>
   (assert (antes-baloncesto-golf (responder-baloncesto-o-golf "Si no es un beisbolista, entonces ¿Juega baloncesto ó golf? (baloncesto/golf) "))))


;;;========================================================
;;; Reglas de preguntas después del 1975
;;;========================================================


(defrule determinar-baloncesto-tennis ""
   (deportista-mundial despues)
   (not (logros ?))
   =>
   (assert (despues-baloncesto-tennis (responder-baloncesto-o-tennis "¿Es un deportista profesional de baloncesto ó de tennis? (baloncesto/tennis) "))))


;;;========================================================
;;; Reglas de respuestas antes del 1975
;;;========================================================


(defrule antes-michael-jordan ""
   (deportista-mundial antes)
   (antes-beisbolista no)
   (antes-baloncesto-golf baloncesto)
   (not (logros ?))
   =>
   (assert (logros "Michael Jeffrey Jordan (Brooklyn, Nueva York, 17 de febrero de 1963), más conocido como Michael Jordan
, es un exjugador de baloncesto estadounidense.

- 6 veces campeón de la NBA (1991, 1992, 1993, 1996, 1997, 1998)
- 6 veces MVP de las finales (1991, 1992, 1993, 1996, 1997, 1998)
- 14 veces All-Star (no participó en el de la temporada 1985-1986 por lesión)
- 5 veces MVP de la Temporada (1988, 1991, 1992, 1996, 1998)
- 2 medallas de oro olímpicas (Los Ángeles 1984, Barcelona 1992)
- Mejor Defensor del Año (1988)
- Rookie del Año (1985)
- 11 veces en el Mejor Quinteto de la NBA (10 en el 1º, 1 en el 2º)
- 2 Concursos de Mates (1987, 1988)
- Nombrado mejor jugador de la historia de la NBA
- Naismith College Player of the Year (1984)
- John R. Wooden Award (1984)
- Adolph Rupp Trophy (1984)
- ACC Men's Basketball Player of the Year (1983–84)
- 1 Medalla de Oro en Juegos Panamericanos (Caracas, 1983)
- Deportista del Año (Sports Illustrated, 1991)
- Miembro del Basketball Hall of Fame (2009)76​")))

(defrule antes-tiger-woods ""
   (deportista-mundial antes)
   (antes-beisbolista no)
   (antes-baloncesto-golf golf)
   (not (logros ?))
   =>
   (assert (logros "Eldrick Tiger Woods (n. Cypress, California, 30 de diciembre de 1975) es un golfista estadounidense.
Es considerado uno de los golfistas más importantes de todos los tiempos, junto a Jack Nicklaus y Arnold Palmer.

- Masters de Augusta: 4 (1997, 2001, 2002, 2005)
- Abierto de los Estados Unidos: 3 (2000, 2002, 2008)
- Abierto Británico: 3 (2000, 2005, 2006)
- Campeonato de la PGA: 4 (1999, 2000, 2006, 2007)
- Derrotó a Bob Mai en un desempate de tres hoyos por un golpe: Woods (3-4-5=12), May (4-4-5=13)
- Derrotó a Chris DiMarco con un birdie en el primer hoyo de desempate
- Derrotó a Rocco Mediate con un par en el primer hoyo de la muerte súbita después de un playoff 
de 18 hoyos en el que ambos jugadores hicieron el par del campo")))

(defrule antes-derek-jeter ""
   (deportista-mundial antes)
   (antes-beisbolista si)
   (antes-beisbolista-temporadas no)
   (not (logros ?))
   =>
   (assert (logros "Derek Sanderson Jeter (Pequannock Township, Nueva Jersey el 26 de junio de 1974) es un ex jugador 
estadounidense de Béisbol profesional que jugó toda su carrera en las Grandes Ligas con los 
New York Yankees, novena de la cual fue nombrado capitán desde el año 2003 hasta su retiro en 2014.

- Posee 12 temporadas anotando 100 o mas carreras-(104, 116, 127, 134, 119, 110, 124, 111, 132, 116, 102 107).
- Ha conectado 200 hits o mas en 7 temporadas- (203, 219, 201, 202, 214, 206, 212).
- Tiene 7 temporadas con 30 dobles o mas-(31,37, 35, 44, 39, 39).
- En 3 ocasiones ha conectado 20 jonrones o mas- (24, 21, 23).
- Se ha tragado 100 ponches o mas en 8 ocasiones- (102, 125, 119, 116, 114, 117, 102, 100).
- Su promedio ha rondado los 300 o mas en 11 ocasiones- (314, 324, 349, 339, 311, 24, 309, 343, 322, 300, 334).
- Ha visitado el Juego de Estrellas en 10 ocasiones.
- A la defensiva ha ganado 6 Guantes de Oro- (2004, 2005, 2006, 2009).
- Ha recibido 4 premios Silver Slugger-(2006, 2007, 2008, 2009).
- En junio 227, 2008 conecto su doble 400.
- En julio 12, 2008 conecto su cuadrangular 200.
- En septiembre 14, 208 empato la marca de mas hits conectados en el Yankee Staduim uniéndose a Lou Gehrig.
- Es el sexto jugador en las mayores que posee 2,700 hits, 1,500 anotas, 220 jonrones, 300 robos de base y 1,000 
carreras impulsadas junto a Craig Boggie, Barry Bonds, Rickey Henderson, Willie Mays y Paul Molitor.
- A la defensiva tiene 2,123 juegos como torpedero, 5,354 asistencias, 214 errores, 1,132 dobles matanzas y un 
por ciento de 976 como fildeador.
- En 15 temporadas tiene a su haber 2,138 juegos, 8,659 turnos, 1,574 anotadas, 2,747 hits, 430 dobles, 58 triples, 
24 jonrones, 1,068 impulsadas, 885 bases por bolas, 1,466 ponches y 317 de promedio de por vida.
- Tiene 28 Series de postemporadas que se dividen en 7 Series Mundiales,  8 Series de Campeonato y 13 Series 
de División.
- Ha ganado el premio Hank Aaron  (2006-2009).
- Jugador Más Valioso en el Juego de Estrellas del 2000.
- Jugador Más Valioso en la Serie Mundial del 2000.
- Novato del Año en 1996.")))

(defrule antes-alex-rodriguez ""
   (deportista-mundial antes)
   (antes-beisbolista si)
   (antes-beisbolista-temporadas si)
   (not (logros ?))
   =>
   (assert (logros "Alexander Emmanuel Rodríguez Navarro (nacido el 27 de julio de 1975 en Nueva York, NY, 
Estados Unidos) es un exbeisbolista profesional estadounidense de origen dominicano que 
jugaba en las Grandes Ligas de Béisbol para los Yankees de Nueva York.

- 14 veces All-Star
- 7 veces como SS (1996-98, 2000-03)
- 7 veces como 3B (2004-2008, 2010-2011)
- 3 veces Jugador Más Valioso de la Liga Americana (2003, 2005, 2007)
- 10 veces Premio Bate de Plata de la Liga Americana
- 7 veces como SS (1996, 1998-2003)
- 3 veces como 3B (2005, 2007, 2008)
- 4 veces AL Hank Aaron Award (2001–03, 2007)
- 2 veces Seattle Mariners Player of the Year (1998, 2000)
- 2 veces Baseball America MLB Player of the Year (2000, 2002)
- 4 veces Baseball America 1st-Team Major League All-Star (SS) (1998, 2000–03)
- 3 veces Texas Rangers Player of the Year (2001–03)
- 2 veces AL Gold Glove Award (SS) (2002, 2003)
- 2 veces The Sporting News Player of the Year (2002, 2007)
- 1993 1st Team High School All-American (IF)
- 1994 Seattle Mariners Minor League Player of the Year
- 1994 Midwest League All-Star (SS)
- 1995 Baseball America 1st Team Minor League All-Star (SS)
- 1995 Triple-A All-Star (SS)
- 1996 The Sporting News Player of the Year
- 2002 Player of the Year Award - This Year in Baseball Awards
- 2005 Baseball America 1st-Team Major League All-Star (3B)
- 2005 Individual Performance of the Year Award - This Year in Baseball Awards
- 2007 Hitter of the Year - This Year in Baseball Awards
- 2007 Pepsi Clutch Performer of the Year")))


;;;========================================================
;;; Reglas de respuestas después del 1975
;;;========================================================


(defrule despues-kobe-bryant ""
   (deportista-mundial despues)
   (despues-baloncesto-tennis baloncesto)
   (not (logros ?))
   =>
   (assert (logros "Kobe Bean Bryant (Filadelfia, 23 de agosto de 1978) es un exjugador estadounidense de baloncesto que 
disputó veinte temporadas en la NBA, todas ellas en Los Angeles Lakers, desde 1996 hasta 2016.

- MVP de las Finales de la NBA:2009, 2010
- 5 veces campeón de la NBA: 2000, 2001, 2002, 2009, 2010
- 2 veces máximo anotador: 2006, 2007
- 18 veces All-Star: 1998, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 
2015, 2016.
- 11 apariciones consecutivas (No hubo All-Star Game en el 99 Y se perdió el All-Star Game del 2010 por una lesión)
- MVP de la temporada regular: 2008
- 4 veces MVP del All-Star Game: 2002, 2007, 2009 2011
- Máximo anotador de la historia en el All Stars (año 2012)
- 11 veces en el mejor quinteto de la NBA: 2002, 2003, 2004, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013
- 2 veces en el segundo mejor quinteto de la NBA: 2000, 2001
- 2 veces en el tercer mejor quinteto de la NBA: 1999, 2005
- 9 veces en el mejor quinteto defensivo de la NBA: 2000, 2003, 2004, 2006, 2007, 2008, 2009, 2010, 2011
- 3 veces segundo mejor quinteto defensivo de la NBA: 2001, 2002, 2012
- Segundo mejor quinteto de rookies: 1997
- Campeón del Concurso de Mates del All Star: 1997")))

(defrule despues-roger-federer ""
   (deportista-mundial despues)
   (despues-baloncesto-tennis tennis)
   (not (logros ?))
   =>
   (assert (logros "Roger Federer (Basilea, Suiza, 8 de agosto de 1981) es un tenista profesional suizo que actualmente 
ocupa el segundo lugar en la clasificación de la ATP.

- 20 títulos de Grand Slam
- 67​ sus diez finales consecutivas de Grand Slam
- 23 semifinales de Grand Slam
- 36 cuartos de final consecutivos de Grand Slam
- 3 Grand Slams ganados en el mismo año en tres ocasiones 2004, 2006 y 2007
- Jugador que ha ganado cinco torneos consecutivos en dos torneos de Grand Slam (Wimbledon y el Abierto de Estados Unidos)
- Tiene el mayor récord de victorias consecutivas conseguidas sobre hierba y pistas duras
- Es el jugador masculino que más semanas ha estado en el número 1 del ranking con 308 semanas
- 65 torneos de Grand Slam consecutivos desde el Abierto de Australia 1999 hasta el Abierto de Australia 2016
- 10 victorias estando 0-2 en sets, liderando con Aaron Krickstein y Boris Becker como los únicos jugadores en lograrlo 
en la Era Abierta")))


;;;========================================================
;;; Reglas de conclusión
;;;========================================================


(defrule cabecera ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Sistema Experto Deportistas Mundiales")
  (printout t crlf crlf))

(defrule imprimir-logros ""
  (declare (salience 10))
  (logros ?texto)
  =>
  (printout t crlf crlf)
  (printout t "Deportista mundial y sus logros:")
  (printout t crlf crlf)
  (format t "%s%n%n%n" ?texto))

