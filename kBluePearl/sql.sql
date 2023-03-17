INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_bluepearl', 'Blue Pearl', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_bluepearl', 'Blue Pearl', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_bluepearl', 'Blue Pearl', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('bluepearl', 'Blue Pearl')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('bluepearl',0,'stagiaire','Stagiaire',20,'{}','{}'),
	('bluepearl',1,'employer','Employé',40,'{}','{}'),
	('bluepearl',2,'respequipe','Responsable Equipe',60,'{}','{}'),
	('bluepearl',3,'copdg','Co-PDG',85,'{}','{}'),
	('bluepearl',4,'boss','PDG',100,'{}','{}')
;

INSERT INTO `items` (name, label, `limit`,rare,can_remove) VALUES -- Uniquement si vous n'avez pas déjà les items !!
    
	-- Saké 
	('sake','Saké', 100, 0, 1),
	
	-- Accompagnements
	('pommedeterre','Pomme de Terre', 100, 0, 1),
	('frites','Frites', 100, 0, 1),
	('potatoz','Potatoz', 100, 0, 1),
	
	-- Viandes Surgelés
	('beaufkobesurgelé','Beauf de Kobe Surgelé', 100, 0, 1),
	('pouletsurgelé','Poulet Surgelé', 100, 0, 1),
	('porcsurgelé','Porc Surgelé', 100, 0, 1),

	-- Viandes
	('beaufkobe','Beauf de Kobe', 100, 0, 1),
	('poulet','Poulet', 100, 0, 1),
	('porc','Porc', 100, 0, 1),

	('nem','Nêm', 100, 0, 1), -- Poulet + Porc
	('yakitorib','Yakitori Beauf & Fromage', 100, 0, 1),
	('yakitorip','Yakitori Boulettes Poulet', 100, 0, 1),
	
	-- Légumes 
    ('avocat','Avocat', 100, 0, 1), 
    ('fromage','Fromage', 100, 0, 1), 
	('concombre','Concombre', 100, 0, 1), 

    -- Makis

    ('sakesotomaki','Sake Soto Maki', 100, 0, 1), -- Avocat et Saumon
    ('tekkasotomaki','Tekka Soto Maki', 100, 0, 1), -- Avocat et Thon
	('makisaf','Maki Avocat & Fromage', 100, 0, 1),
	('makiscf','Maki Concombre & Fromage', 100, 0, 1),
	('makisr','Maki Saumon Roll', 100, 0, 1), -- Saumon Fromage


	--  Sushis 
	('sushis','Sushi Saumon', 100, 0, 1),
	('sushit','Sushi Thon', 100, 0, 1)
;