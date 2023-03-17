Config = {

    DrawText = "Appuyez sur ~HUD_COLOUR_RADAR_ARMOUR~ [E] ~s~ pour parler à la personne",
    
    Blips = {
        BlipsMaps = {
            Title = "~b~Blue ~s~Pearl",
            Type = 93,
            Color = 38,
            Position = {x = -1837.91, y = -1189.28, z =14.30},
        },
    },

    Markers = {
        Type = 22,
        TypeGarage = 36, 
        Hauteur = 0.3,
        Epaisseur = 0.3,
        Largeur = 0.3,
        Opaciter = 255,
        DistanceMarkers = 5,
        Saute = true,
        Tourne = true, 
        Color = {r = 32, b = 247, g = 72},
        Texte = "Appuyez sur ~HUD_COLOUR_RADAR_ARMOUR~ [E]",
    },

    Markers_Retour_Bateau = {
        TypeRetourBateau = 35, 
        Hauteur = 0.7,
        Epaisseur = 0.7,
        Largeur = 0.7,
        Opaciter = 255,
        DistanceMarkers = 25,
        Saute = true,
        Tourne = true, 
        Color = {r = 255, b = 0, g = 0},
        Texte = "Appuyez sur ~HUD_COLOUR_RADAR_ARMOUR~ [E]",
        TP_Ped = {x = -1800.697, y = -1226.401, z = 1.589},
    },

    Positions = {
        {
            Fourneaux = vector3(-1843.93, -1186.45, 14.30),
            Friteuses = vector3(-1842.85, -1184.38, 14.30),
            Plan_Travail = vector3(-1844.53, -1187.83, 14.30),

            Coffre = vector3(-1843.97, -1189.67, 14.30), 
            Boss = vector3(-1831.08, -1197.78, 19.42),
            Vestiaire = vector3(-1832.18, -1190.03, 19.42),
            Livraison = vector3(-1837.44, -1185.23, 14.30),

            Garage_Voiture = vector3(-1855.98, -1194.87, 13.016),
            Voiture_Retour = vector3(-1842.54, -1213.26, 13.01),
            Bateau_Retour = vector3(-1798.73, -1232.13, 2.13),
        },
    },

    Livraison = {
        SpawnVehicle = vector3(-1362.24, -712.37, 24.73),
        SpawnHeading = 21.56,
        Point_Livraison = vector3(-1851.35, -1185.39, 12.91),
        Point_Livraison_Heading = 321.17,
        Porte_Vehicle = vector3(-1856.73, -1192.72, 13.01),
        Heading_Porte_Vehicle = 321.82,
        Heading_Depot = 234.38,
    },  

    MenuLivraison = {
        Viandes = {label = "Viandes", item1 = 'beaufkobesurgelé', count1 = 10, item2 = 'pouletsurgelé', count2 = 10, item3 = 'porcsurgelé', count3 = 10, price = 15000, index = 0},
        Legumes_Fromages = {label = "Légumes & Fromages", item1 = 'pommedeterre', count1 = 50, item2 = 'avocat', count2 = 50, item3 = 'fromage', count3 = 50 , item4 = 'concombre', count4 = 50, price = 5000, index = 1},
        Boissons = {label = "Boissons", item1 = 'sake', count1 = 50, item2 = 'icetea', count2 = 50, item3 = 'limonade', count3 = 50, item4 = 'water', count4 = 50, price = 1000, index = 2},
    },

    Animation = {
        Duree_Cuisson_Viandes = 10000, -- milliseconds
        Duree_Cuisson_Friteuses = 4000, 
        Duree_Mise_En_Menu = 4000,

        Heading_Fourneaux = 59.85, 
        Pos_Anim_Fourneaux = {x = -1843.929, y = -1186.473, z = 14.31},

        Heading_Friteuses = 59.85,
        Pos_Anim_Friteuses = {x = -1842.714, y = -1184.401, z = 14.31},
    },

    Cuisine = {
        Beauf_de_Kobe = {itemdel = "beaufkobesurgelé", countdel = 1, itemadd = 'beaufkobe', countadd = 1, label = "Beauf de Kobe"}, -- Count correspond au nombre que vous allez produire pour une préparation
        Poulet = {itemdel = "pouletsurgelé", countdel = 1, itemadd = 'poulet', countadd = 1, label = "Poulet"},
        Porc = {itemdel = "porcsurgelé", countdel = 1, itemadd = 'porc', countadd = 1, label = "Porc"},
        Frites = {itemdel = "pommedeterre", countdel = 5, itemadd = 'frites', countadd = 10, label = "Frites"},
        Potatoz = {itemdel = "pommedeterre", countdel = 5, itemadd = 'potatoz', countadd = 10, label = "Potatoz"},
    },
   

    Plan_De_Travail = {
        -- Maki
        makisaf = {itemdel = "avocat", countdel = 1, itemdel2 = "fromage", countdel2 = 1, itemadd = 'makisaf', countadd = 1, label = "Maki Avocat & Fromage"},
        makiscf = {itemdel = "concombre", countdel = 1, itemdel2 = "fromage", countdel2 = 1, itemadd = 'makisaf', countadd = 1, label = "Maki Concombre & Fromage"},
        makisr = {itemdel = "saumon", countdel = 1, itemdel2 = "fromage", countdel2 = 1, itemadd = 'makisr', countadd = 1, label = "Maki Saumon Roll"},
        tekkasotomaki = {itemdel = "avocat", countdel = 1, itemdel2 = "thon", countdel2 = 1, itemadd = 'tekkasotomaki', countadd = 1, label = "Tekka Soto Maki"},
        sakesotomaki = {itemdel = "avocat", countdel = 1, itemdel2 = "saumon", countdel2 = 1, itemadd = 'sakesotomaki', countadd = 1, label = "Sake Soto Maki"},

        -- Sushi
        sushis = {itemdel = "saumon", countdel = 1, itemdel2 = nil, countdel2 = nil, itemadd = 'sushis', countadd = 5, label = "Sushi Saumon"},
        sushit = {itemdel = "thon", countdel = 1, itemdel2 = nil, countdel2 = nil, itemadd = 'sushit', countadd = 5, label = "Sushi Thon"},

        -- Yakitori + Nêm
        nem = {itemdel = "poulet", countdel = 1, itemdel2 = "porc", countdel2 = 1, itemadd = 'nem', countadd = 10, label = "Nêm"},
        yakitorib = {itemdel = "beaufkobe", countdel = 1, itemdel2 = "fromage", countdel2 = 1, itemadd = 'yakitorib', countadd = 5, label = "Yakitori Beauf & Fromage"},
        yakitorip = {itemdel = "poulet", countdel = 1, itemdel2 = nil, countdel2 = nil, itemadd = 'yakitorip', countadd = 5, label = "Yakitori Boulettes Poulet"},

    },

    VehiculeBluePearl = { 
        {label = "Cognoscenti", spawnname = "cognoscenti", spawnzone = vector3(-1843.38, -1212.83, 12.68), headingspawn = 152.86}, 
        {label = "Baller", spawnname = "baller6", spawnzone = vector3(-1843.38, -1212.83, 12.68), headingspawn = 152.86}, 
        {label = "Limousine", spawnname = "stretch", spawnzone = vector3(-1861.31, -1211.57, 12.70), headingspawn = 230.03}, 
        {label = "Bateau de Pêche", spawnname = "tug", spawnzone = vector3(-1793.96, -1229.20, 1.09), headingspawn = 322.36}, 
    },

    MenuLivraisonPlayer = {
        {item1 = "nem", label1 = "Nêm", count1 = 10, item2 = "potatoz", label2 = "Potatoz", count2 = 10, item3 = "icetea", label3 = "Ice Tea", count3 = 2, id = 1, price = 5000},
        {item1 = "makisr", label1 = "Maki SR", count1 = 10, item2 = "potatoz", label2 = "Potatoz", count2 = 10, item3 = "limonade", label3 = "Limonade", count3 = 2, id = 2, price = 5000},
        {item1 = "yakitorip", label1 = "Yakitori BP", count1 = 3, item2 = "frites", label2 = "Frites", count2 = 10, item3 = "icetea", label3 = "Ice Tea", count3 = 2, id = 3, price = 5000},
        {item1 = "sushit", label1 = "Sushi Thon", count1 = 10, item2 = "frites", label2 = "Frites", count2 = 10, item3 = "limonade", label3 = "Limonade", count3 = 2, id = 4, price = 5000},
    },

    LieuLivraison = {
        {id = 1, pos = vector3(-1722.57, -482.82, 41.61)},
        {id = 2, pos = vector3(-83.35, -281.41, 45.55)},
        {id = 3, pos = vector3(-1075.67, -1026.61, 4.54)},
    },
}