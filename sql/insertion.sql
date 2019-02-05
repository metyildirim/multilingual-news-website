USE dbNews

INSERT INTO tblAdmin VALUES(1,'admin','admin')

INSERT INTO tblLang VALUES (1,'English'),(2, 'Turkish'),(3, 'French')

INSERT INTO tblCat VALUES(1,'World'),(2,'Business'),(3,'Technology'),(4,'Science'),(5,'Health'),(6,'Video'),
(7,'Sport')

INSERT INTO tblUser VALUES(1,'user','user','user@user.com',GETDATE(),0),
						(2,'user2','user2','user2@user.com',GETDATE(),0)

INSERT INTO tblSource VALUES(1,'bbc'),(2,'cnn'),(3,'France24'),(4,'The Paris News'),(5,'AA'),(6,'DHA'),(7,'Fanatik')

INSERT INTO tblEditor VALUES (1,2)

INSERT INTO tblNews VALUES
(1,'US shutdown impasse over Trump`s wall drags on','A partial US government shutdown is likely to continue into next week amid an impasse over funding for President Trump`s proposed Mexico border wall.'
,'Both Congress chambers met for just a few minutes on Thursday but took no steps to end the closure. The House and Senate will now meet again on Monday.
Many lawmakers did not return to Washington for the sessions.
Whether or not to fund the wall is the issue holding up the passing of a government funding budget.
Both sides now seem to accept that the dispute will continue into 2019.
The funding dispute has left hundreds of thousands of federal employees either on unpaid leave or not knowing when they will get paid.
Six things that could topple Trump`s border wall
Who pays for Donald Trump`s wall?
What`s the row about?
Mr Trump says he will not compromise on his demands for funding to build a border wall between the US and Mexico to tackle illegal immigration.
He is refusing to sign a wider spending package, forcing large parts of the government to shut down.
But opposition Democrats - who take over the House of Representatives in January - and some within Mr Trump`s party, the Republicans, insist they won`t give the president the $5bn he says he needs.
Why can`t Trump get his budget passed?
His Republican Party controls both chambers of the outgoing Congress and the budget was indeed passed by the House on Thursday by 217 votes to 185.
However, he needs to find 60 votes in the 100-seat Senate, where the Republicans currently have 51, so he needs to enlist the support of Democrats there.
How is the shutdown playing out?
Nine of 15 federal departments, including State, Homeland Security, Transportation, Agriculture and Justice began partially shutting down after funding for them lapsed at midnight (05:00 GMT) last Saturday.
Hundreds of thousands of federal employees will have to work unpaid or are furloughed, a kind of temporary leave.
In practice, this means that:
Customs and border staff will keep working, although their pay will be delayed. Airports will continue operating.
About 80% of National Parks employees will be sent home, and parks could close - although some may stay open with limited staff and facilities.
About 90% of housing department workers will take unpaid leave, which could delay loan processing and approvals.
Most of the Internal Revenue Service (IRS) will be sent on unpaid leave, including those who assist taxpayers with queries.
The Food and Drug Administration will pause routine inspections but "continue vital activities".
The remaining 75% of the federal government is fully funded until September 2019 - so the defence, veterans affairs, labour and education departments are not affected.'
,'https://ichef.bbci.co.uk/news/660/cpsprodpb/111F5/production/_104933107_mediaitem104933105.jpg',GETDATE(), 1),
(2,'A transformer explosion turned the New York City skyline blue','A transformer explosion at a power plant in Queens temporarily lit up the New York City skyline in a brilliant blue Thursday night.'
,'A transformer explosion at a power plant in Queens temporarily lit up the New York City skyline in a brilliant blue Thursday night.

But despite the eerily glowing color, an alien invasion it was not.
Instead, the light came as part of a brief electrical fire after a "couple of transformers tripped offline" at the intersection of 20th Avenue and 32nd Street in Astoria, Con Edison spokesman Bob McGee told CNN.
The issue caused a transmission dip in the area, and Con Edison crews responded with the Fire Department of New York, Con Edison said.
The incident is under control and no injuries have been reported, the FDNY said. The explosion was determined to be a non-suspicious equipment malfunction, according to a tweet from the NYPD 114th Precinct.
There are no significant reported power outages anymore, New York Gov. Andrew Cuomo said.
"No injuries, no fire, no evidence of extraterrestrial activity," the NYPD said on Twitter.
The explosions lit up the sky in shades of blue visible as far as Manhattan and New Jersey. The tremors shook buildings and rattled windows, sending people running into the streets.
Residents reported temporary power outages.
The explosions temporarily closed LaGuardia Airport in Queens. No flights took off between 9:22 and 10:23 p.m. ET, according to FlightAware, a flight tracking data company.
All terminals were impacted by the loss of commercial power, causing the FAA to issue a temporary ground stop.
LaGuardia Airport has since resumed to normal operations, the FAA said in an advisory posted to its website.
Con Edison said the airport switched to a backup generator during the transmission disturbance, and all power lines serving the area are in service and the system is stable.
Because all FAA facilities at LaGuardia are on generator power there was no interruption to air traffic control, FAA spokesman Greg Martin said.',
'https://cdn.cnn.com/cnnnext/dam/assets/181227220232-03-blue-sky-nyc-1227-exlarge-169.jpeg', GETDATE(), 2),
(3,'Plus de 300 migrants de Libye ont été sauvés','Plus de 300 migrants secourus il y a une semaine au large de la Libye par l`ONG espagnole Proactiva Open Arms sont arrivés, vendredi matin, dans un port du sud de l`Espagne, alors que l`Italie et Malte les ont refusés.'
,'Un bateau est arrivé en Espagne, vendredi 28 décembre au matin, dans la baie de Gibraltar où il doit accoster, avec à son bord plus de 300 migrants secourus la semaine passée au large de la Libye par l`ONG Proactiva Open Arms.
Une fois sur la terre ferme, ces 311 personnes – originaires notamment de Somalie, du Nigeria ou du Mali – seront accueillies par la Croix-Rouge qui leur fournira vêtements, nourriture et assistance médicale si nécessaire. La police procèdera ensuite à leur identification avant qu`ils puissent être dirigés vers des lieux d`accueil. Au total, la procédure prendra "plusieurs heures", indique-t-on au sein de la Croix Rouge.
Secourus le 21 décembre à bord de trois embarcations précaires, ces migrants avaient été autorisés à débarquer en Espagne le lendemain par le gouvernement socialiste de Pedro Sanchez, après avoir été refusés par l`Italie et Malte. Selon Madrid, la Libye, la France et la Tunisie n`avaient quant à elles pas répondu à la demande de l`ONG après la fin de non-recevoir opposée par l`Italie.
Noël à bord
Si Malte a refusé l`accès de ses ports au navire, une femme et un bébé, né sur une plage libyenne quelques jours avant la traversée, ont en revanche pu être évacués samedi sur l`île en hélicoptère. Un mineur a par ailleurs été emmené vers l`île italienne de Lampedusa.
Depuis le feu vert accordé par Madrid, ces migrants ont entrepris une traversée d`une semaine pour rejoindre l`Espagne. Ils ont fêté Noël à bord de l`Open Arms, comme en ont témoigné les photos publiées par l`ONG. Un autre bateau de l`ONG espagnole, le voilier Astral, les a ravitaillés lundi en pleine mer, leur amenant nourriture, médicaments et couvertures.
Proactiva Open Arms avait repris fin novembre, avec deux autres bateaux d`ONG, ses missions de sauvetage au large de la Libye après avoir décidé de les suspendre fin août. Elle dénonçait alors la "criminalisation des ONG", en particulier par l`Italie et son ministre de l`Intérieur d`extrême droite Matteo Salvini.
Après le refus de Rome d`accueillir les migrants sauvés vendredi, le fondateur de l`ONG, Oscar Camps, s`en était pris à Matteo Salvini sur Twitter. "Ta rhétorique et ton message auront une fin, comme tout dans la vie. Mais sache que dans quelques décennies, tes descendants auront honte de ce que tu fais et dis", lui a-t-il lancé.
Premier bateau depuis août
C`est la première fois depuis près de cinq mois que l`Espagne accepte de laisser débarquer le bateau d`une ONG avec des migrants à bord.
Arrivé au pouvoir début juin à Madrid, Pedro Sanchez avait frappé un grand coup quelques jours plus tard en accueillant le navire humanitaire Aquarius, refusé par l`Italie et Malte et au centre de fortes tensions en Europe sur la politique migratoire.
Madrid avait ensuite accepté à trois reprises, en juillet et août, d`accueillir un bateau d`Open Arms avec des migrants à bord, avant de rechigner à laisser de nouveau débarquer l`Aquarius. Le gouvernement préférait alors négocier avec d`autres États européens la répartition de ses migrants.
La route de la Méditerranée centrale est la plus meurtrière, avec 1 306 migrants morts dans la traversée vers les côtes italiennes et maltaises depuis le début de l`année, selon les derniers chiffres de l`Organisation internationale pour les migrations (OIM), actualisés au 19 décembre.
L`Espagne est en revanche devenue depuis cet été la première porte d`entrée des migrants illégaux en Europe, devant la Grèce et l`Italie. Plus de 56 000 migrants sont arrivés dans ce pays par la mer depuis le 1er janvier, tandis que 769 sont morts dans la traversée.'
,'https://scd.france24.com/fr/files_fr/imagecache/home_1024/article/image/openarms-m.jpg',GETDATE(),3),
(4,'Nourrir le comté','Le Downtown Food Pantry s`est effondré mercredi dans le chaos organisé alors que des dizaines de personnes travaillaient avec diligence à leurs postes pour déballer les produits frais dans des récipients et les mettre dans des sacs d`épicerie pour les distribuer aujourd`hui. À peine un chariot est-il vidé qu`un autre leur est apporté.'
,'Balayez devant le Downtown Food Pantry, 124, rue W. Cherry, à Paris, les lundis et mercredis. C’est le moment où des bénévoles préparent l’organisation à but non lucratif pour la distribution du lendemain aux familles affamées du comté de Lamar.
Mercredi, le Downtown Food Pantry était plus occupé que d`habitude, environ deux fois plus de volontaires que d`habitude, a déclaré le directeur exécutif, Allan Hubbard.
"Nous craignions de ne pas avoir assez de volontaires, car c`était juste après les vacances, alors nous l`avons mis sur Facebook, et presque deux fois plus de personnes sont venues comme d`habitude", a-t-il déclaré.
C’est une bonne chose aussi, a déclaré Hubbard, car le garde-manger empaquetait plus de nourriture en prévision d’une distribution plus dense que d’habitude puisque le garde-manger était fermé mardi à Noël.
Les organisations religieuses du comté de Lamar constituent une source fiable d`assistance pour le garde-manger, a déclaré Hubbard, avec plus de 20 églises locales donnant de leur temps et de l`argent pour aider le garde-manger dans sa mission.
Mercredi, Jill Faires, parmi les bénévoles, s`est rendu au garde-manger du centre-ville via l`église du Christ de l`avenue Lamar. Faires a déclaré y avoir fait du bénévolat à quatre reprises.
La socialisation est un autre aspect enrichissant du service, a expliqué Faires, ajoutant qu`elle aimait voir et rencontrer d`autres bénévoles réguliers.
Robert Steelman était un bénévole pour la première fois mercredi. Il a dit que le travail s`était bien déroulé car le garde-manger du centre-ville était bien organisé.
"Ils ont un bon système", a-t-il déclaré, faisant écho au vétéran bénévole Michael Bright, qui a déclaré que cet effort "ne donne même pas l`impression d`être du travail".
Laura Dietk s`est également portée volontaire au garde-manger pour la première fois mercredi. Elle s`est sentie obligée de donner un coup de main, car elle interagit régulièrement avec les gens par le biais de son travail dans une garderie locale qui visitent le garde-manger.
Des dizaines d’organisations du comté de Lamar apportent leur aide en prêtant leur personnel au garde-manger, a déclaré Hubbard. Tandis que les lundis et mercredis sont des jours de préparation, les mardis et jeudis sont des jours de distribution. Les volontaires travaillent ensemble les lundis et les mercredis pour emporter environ 40 000 livres de produits. Les mardis et jeudis, le Downtown Food Pantry est ouvert au public. Des bénévoles aident les clients à trouver ce qu’ils cherchent, à mettre les courses dans des voitures et à garder le magasin propre et en ordre.
M. Hubbard a déclaré que cette semaine et la semaine prochaine font figure d`exceptions, le jour de Noël et le jour de l`An tombant le mardi. Cela signifie que le centre alimentaire du centre-ville est fermé et ne fournit que de la nourriture aujourd`hui et jeudi prochain. La charge de travail supplémentaire de ces jeudis signifie qu`il faut plus de bénévoles. Pour faire du bénévolat, appelez le Downtown Food Pantry au 903-737-8870.
Le centre alimentaire du centre-ville achète ses aliments auprès de la banque alimentaire North Texas Food Bank, qui s`approvisionne auprès de l`organisation à but non lucratif Feeding America. La banque alimentaire du nord du Texas distribue ensuite tous les articles qu`elle reçoit aux 13 comtés de la région du nord du Texas, y compris le comté de Lamar.
La nourriture est grandement nécessaire, a déclaré Hubbard. Le comté de Lamar compte le plus haut pourcentage d`insécurité alimentaire parmi les 13 comtés de la région.
La plupart des jours, les aliments que mangent les volontaires comprennent des oignons, des oranges, des pamplemousses, des courgettes, des aubergines, des poires, des courges spaghettis et des courges musquées. Hubbard a déclaré qu`une grande partie des produits sont de saison et viendront principalement en été, en automne ou en hiver.
Hubbard espère que la diligence des volontaires portera ses fruits aujourd`hui, car il compte servir environ 600 familles au Downtown Food Pantry.'
,'https://bloximages.chicago2.vip.townnews.com/theparisnews.com/content/tncms/assets/v3/editorial/b/ce/bce594fa-09f2-11e9-8c9e-e37fd8c2eb71/5c24fb4dcc986.image.jpg',GETDATE(),4),
(5,'2019 fon akýþý açýsýndan bu yýldan daha iyi olacak','Yýldýzlar Yatýrým Holding Yönetim Kurulu Üyesi Yýldýz, "Fon akýþý açýsýndan gelecek yýl daha iyi olacak diye düþünüyorum." dedi.'
,'Yýldýzlar Yatýrým Holding Yönetim Kurulu Üyesi Hakký Yýldýz, AA muhabirine Türkiye ekonomisi açýsýndan 2018`de yaþanan geliþmeleri deðerlendirdi, 2019`dan beklentilerini paylaþtý.
Son 3-4 yýldýr Türkiye`nin hem iç hem de dýþ birçok sorunla mücadele ettiðini anlatan Yýldýz, dünyada bu kadar problemle karþýlaþýp, bu þekilde ayakta kalabilen baþka bir ülke bulunmadýðýný vurguladý.
Yýldýz, Türkiye`nin sermayesinin güçlü olduðunu, tüm sorunlara raðmen plan yapýlabildiðini ifade ederek, 2018`in zor bir yýl olarak geçtiðini, bu zorluklarýn yansýmalarýnýn 2019`da da görülmeye devam edeceðini söyledi.
Gelecek yýlýn mart ayýnda yerel seçimlerin yapýlacaðýný anýmsatan Yýldýz, "Belediyeleri ekonominin kýlcal damarlarý gibi düþünmek lazým. Hizmetlerin doðru ve zamanýnda yapýlmasýyla seçim sonrasýnda bugünden daha iyi bir gelecek beklentisi olacaktýr. Hükümetin açýkladýðý Yeni Ekonomi Programý`ný uyguladýðýný, bu uygulamanýn yurt dýþýnda da kabul gördüðünü düþünüyorum. Seçimle beraber yerel yönetimlerde doðru bir politikayla 2019`un ilk çeyreði itibarýyla kaldýðýmýz yerden devam ederiz." diye konuþtu.
Yýldýz, teþviklerin kesinlikle 2019`da da devam etmesi gerektiðini vurgulayarak, þunlarý kaydetti:
"Türkiye`deki teþvik sistemi hiçbir ülkede yok. Teþviklerin bu haliyle devam etmesi gerek ama bunlarýn anlatýlmasý, tanýtýlmasý ve faydalarýnýn yatýrýmcýya izah edilmesi konusunda eksiðiz. Burada bir þeyler yapýlabilir. Diðer taraftan çok fazla teþvik var. Belki bunlarýn bir þekilde toparlanýp, daha az kalemde, daha etkili bir sunuma dönüþmesi fayda saðlayacaktýr. Bir yatýrýmcý teþviklerde, yaptýðý yatýrýmýn geri dönüþüyle alakalý dönüþlere bakar. Bu açýdan kurumlar vergisi indirimi ve SGK teþviki yatýrýmlar açýsýndan çok ciddi önem taþýyor. Bunlarýn 2019`da da devam ediyor olmasý bizim açýmýzdan çok sevindirici."
"Yatýrýmlar açýsýndan 2019`a olumsuz bakmak için hiçbir neden yok"
Hakký Yýldýz, yabancý yatýrýmlar açýsýndan ülkede güven ortamýnýn tesisinin önemine iþaret ederek, "Þeffaf, adaletli ve öngörülebilir bir ülke profili çizmek lazým. Bu her yatýrýmcý için geçerli." dedi.
Yatýrýmcýlarýn ülkeye yaptýðý ilk yatýrýmýn tanýma amaçlý olduðu, aldýðý ekonomik faydaya bakarak devam eden giriþimlerde bulunduðunu anlatan Yýldýz, bunun için çizilen profilin önemli olduðunu vurguladý.
Yýldýz, yatýrýmcýlarýn mali anlamda da desteklenmesi gerektiðine dikkati çekerek, "Bankacýlýk anlamýnda yatýrýmlarýn desteklendiði bir ülke olunmasý lazým ki bu Türkiye`nin güçlü kaslarýndan biri. Türkiye`de bankacýlýk sistemi, yatýrýmlara destek veren bir bakýþ açýsýna sahip. Elimizde malzeme var, sadece bunlarý harmanlayýp, güzelce sunduðumuzda yatýrýmlar açýsýndan 2019`a olumsuz bakmak için hiçbir neden yok." deðerlendirmelerini yaptý.
"Türkiye ekonomisi için þu anki faiz oranlarý sürdürülebilir deðil"
Hakký Yýldýz, yatýrýmlar açýsýndan faiz oranlarýnýn seviyesinin kritik nitelikte olduðundan bahsetti.
Faiz oranlarýnýn yüksekliðinden ziyade, yüksek olmasýnýn gerekçelerinin tartýþýlmasý gerektiðini anlatan Yýldýz, "Bu gerekçelere çözüm bulunup uygulandýðýnda, sorun ortadan kalkacaktýr." dedi.
Yýldýz, Türkiye ekonomisi için þu anki faiz oranlarýnýn sürdürülebilir olmadýðýný vurgulayarak, þöyle devam etti:
"Bir ekonomide yatýrýmlar açýsýndan faiz, enflasyon ve döviz olmak üzere 3 ana unsur var. Biz bunlarýn 3`ünü de aþaðýda tutmak için çabaladýk ama maalesef bu en iyi ekonomilerde bile çok zor bir iþ. Belki bugün için faizi biraz daha yukarýda tutup enflasyon ve dövizi aþaðý çekecek, daha saðlýklý büyümeyi yakaladýðýmýzda da otomatik olarak faizi düþürecek bir plan lazým. Mantalite olarak yüksek faize kesinlikle karþýyým. Yüksek faiz demek hem yerli hem yabancý yatýrýmlarýn azalmasý demek ama faiz düþsün diye diðerlerini de yükseltmemek lazým. Çünkü enflasyon ve döviz ithalatçý bir ülkede faizden daha çok olumsuz etki yaratýyor."
"Gelecek yýl, 2018`den daha fazla yabancý kaynak girecek"
Hakký Yýldýz, yabancý yatýrýmcýnýn Türkiye`yi anlamadýðýný ve çözemediðini belirterek, bunun eskiden beri deðiþmediðini ifade etti.
Bugün bu kadar saldýrýya karþý Türkiye`nin hala nasýl ayakta durabildiði konusunun anlaþýlamadýðýný dile getiren Yýldýz, sözlerini þöyle sürdürdü:
"Avrupalýlar ürkektir, kapýsýnýn önündeki olaydan kaçýp güvenli yere kapanýr. Türk halký olaydan kaçmaz, olayýn bulunduðu yere gidip `ne oluyor` diye bakar. Onun için yatýrýmcýlar þu an için Türkiye`ye temkinli yaklaþýyor. Sürecin yönetilip yönetilemeyeceðini, sürdürülüp sürdürülemeyeceðini anlamaya çalýþýyor. Ancak günün sonunda yatýrýmcýlar yine bu kapýdan içeri girecektir ve kazanan yine Türkiye olacaktýr. Yatýrýmcýlar o evhamlarýnýn bir iki yýl sonra yersiz olacaðýný görüp, Türkiye politikalarýný deðiþtireceklerdir. Bu noktada fon akýþý açýsýndan gelecek yýl daha iyi olacak diye düþünüyorum. Gelecek yýl, Türkiye`ye 2018`den çok daha fazla yabancý kaynak girecektir."
Yýldýzlar Yatýrým Holding Yönetim Kurulu Üyesi Hakký Yýldýz, Türkiye`nin kendi coðrafyasý içinde güçlü bir pozisyona sahip olduðunu belirterek, "Bulunduðumuz coðrafya itibarýyla yatýrýma aç, tüketimin yoðun olduðu yaklaþýk 350 milyon nüfusun olduðu bir bölgeden bahsediyoruz. Bu açýdan bizim ihtiyacýmýz olan ülkede yabancý yatýrýmcýyý çekebilecek reçeteleri sunup, yerli yatýrýmcýnýn da daha katma deðerli ürünler üretebileceði bir plan yapmak. Gerisi zaten gelecek." þeklinde konuþmasýný tamamladý.','https://cdnuploads.aa.com.tr/uploads/Contents/2018/12/28/thumbs_b_c_ce390fb97d0b0a6af5264f0a5308abbb.jpg',GETDATE(),5),
(6,'Elon Musk: Supercharger aðý Türkiye’ye uzanacak','Tesla ve Space X þirketlerinin kurucusu Elon Musk, Supercharger aðýnýn Norveç’ten Türkiye’ye kadar uzanacaðýný açýkladý.'
,'Musk, attýðý tweette Ýrlanda`nýn bazý bölgelerinin Supercharger`a  ihtiyacý olduðu twine yanýt olarak, “Supercharger aðý gelecek yýl Avrupa’nýn %100’ünü kaplayacak þekilde geniþleyecek. Ýrlanda’dan Kiev’e, Norveç’ten Türkiye’ye” ifadelerini kullandý. Tesla Model 3’ün Avrupa versiyonunun Kombine Þarj Sistemi (CCS) hýzlý þarj uyumlu portlarla donatýlacaðýný açýklamýþtý. Daha önce Türkiye’deki yatýrýmlarýný dondurduðunu açýklayan þirket, Avrupa’daki Tesla sahiplerine Model 3 gelmeden önce kýtadaki mevcut Süper Þarj Cihazlarýný CCS sistemiyle yükselteceðini de söyledi.'
,'https://cdn-photo.pivol.com/15648/imgs/271220181419380830731.jpg',GETDATE(),6),
(7,'Henry Onyekuru için Bayern Münih, Dortmund ve Valencia devrede','Süper Lig`de ilk yarýnýn son maçýndaki Sivasspor maçýnda iki gol atan ve gösterdiði performansla takýmýn en iyisi olan Henry Onyekuru`nun performansý dünya devleri tarafýndan takip edilmeye devam ediyor.'
,'Galatasaray`ýn Nijeryalý oyuncusu Henry Onyekuru Everton`da bile kalamayacak gibi gözüküyor.
Premier Lig temsilcisinin sezon baþýnda Sarý Kýrmýzýlýlar`a satýn alma opsiyonu olmaksýzýn kiraladýðý genç oyuncunun performansý son dönemde gözle görülür þekilde artarken dünya devleri de onun bu yükseliþini izlemeye devam ediyor.
Bayern, Dortmund, Valencia...
Daha önce Onyekuru`nun birçok maçýný Türk Telekom Stadý`nda izleyen Bayern Münih, Borussia Dortmund ve Valencia gibi kulüpler 21 yaþýndaki forveti kadrolarýna katmak için Everton`la görüþmeye devam ediyor. Hatýrlanacaðý üzere Fransýz PSG de Onyekuru`nun birkaç maçýna daha önce scout`larýný göndermiþti.
Galatasaray para kazanabilir!
Everton`la yapýlan görüþmelerde ocak ayý seçeneðinin de gündeme geldiði öðrenildi. Ancak burada sadece Everton`ýn deðil, Galatasaray`ýn da transfere onay vermesi gerekiyor. Çünkü oyuncunun -kiralýk da olsa- sezon sonuna kadar olan haklarý Sarý Kýrmýzýlýlar`da... Eðer Galatasaray ve Everton anlaþýrsa Onyekuru ocak ayýnda gidebilir ve Cim Bom Nijeryalý`dan para kazanabilir.
Fatih Terim onay verir mi?
Ancak satýþý gündemde olan Rodrigues, Feghouli ve Belhanda varken bir de Onyekuru`nun kadrodan ayrýlmasýna Fatih Terim onay verir mi, bu cevabý kestirilemeyecek bir soru... Burada Onyekuru için verilecek bonservis bedeli ve Galatasaray`ýn alacaðý pay önemli hale geliyor.
Nijeryalý oyuncu sezon baþý 800 bin euroya kiralanmýþtý.','https://img.fanatik.com.tr/img/78/740x418/5c25e5bbae298beab70e829f',GETDATE(),7)

INSERT INTO tblComment VALUES(1,'Tesla çok pahalý.',GETDATE(),1,6),
						(2,'Fatih Terim onay vermez.', GETDATE(),1,7),
						(3,'is that a wall?', GETDATE(),2,1),
						(4,'Are foods healthy?', GETDATE(),2,4),
						(5,'first comment :)', GETDATE(),2,1)

INSERT INTO tblLangNews VALUES(1,1),(1,2),(2,5),(2,6),(2,7),(3,3),(3,4),(2,1),(2,3)

INSERT INTO tblCfg VALUES(1,1),(2,2),(3,3),(4,4)

INSERT INTO tblCatCfg VALUES(1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4),
(4,1),(4,2),(4,3),(4,4),(5,1),(5,2),(5,3),(5,4),(6,1),(6,2),(6,3),(6,4),(7,1),(7,2),(7,3),(7,4)

INSERT INTO tblLangCfg VALUES(1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4)

INSERT INTO tblCatNews VALUES(1,1),(1,2),(1,3),(5,4),(2,5),(3,6),(7,7)

INSERT INTO tblMessages VALUES(1,'Hello Admin!',1),(2,'second message',1),(3,'I am editor, I sent you this message.',2)

INSERT INTO tblEditorshipRequests VALUES(1,1)

INSERT INTO tblOtherMessages VALUES(1,'other message 1','mehmet emin','yýldýrým','mehmetcts@gmail.com'),
							(2,'other message 2','isim','soyisim','mail@mail.com')