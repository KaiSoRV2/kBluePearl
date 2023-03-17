ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



-- Friteuses

local OuvertFriteuses = false 
local mainMenuFriteuses = RageUI.CreateMenu('', 'Friteuses')
mainMenuFriteuses.Display.Header = true 
mainMenuFriteuses.Closed = function()
    OuvertFriteuses = false
end

local VerifAnimationFriteuse = 0

function Friteuses()
    if OuvertFriteuses then 
        OuvertFriteuses = false
        RageUI.Visible(mainMenuFriteuses, false)
        return
    else
        OuvertFriteuses = true 
        RageUI.Visible(mainMenuFriteuses, true)
        CreateThread(function()
            while OuvertFriteuses do 
                RageUI.IsVisible(mainMenuFriteuses,function() 
                    RageUI.Separator("↓ Friteuses ↓")

                    RageUI.Button("Potatoz", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItem', function(hasEnoughItem)
                            if hasEnoughItem then
                                if VerifAnimationFriteuse == 0 or VerifAnimationFriteuse == 1 then 
                                    VerifAnimationFriteuse = VerifAnimationFriteuse + 1
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Friteuses.x, Config.Animation.Pos_Anim_Friteuses.y, Config.Animation.Pos_Anim_Friteuses.z, false, false, false, true)
                                    SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Friteuses)
                                    RageUI.CloseAll()
                                    RequestAnimDict('anim@amb@nightclub@lazlow@ig1_vip@')
                                    while not HasAnimDictLoaded('anim@amb@nightclub@lazlow@ig1_vip@') do
                                        Wait(100)
                                    end

                                    TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@lazlow@ig1_vip@', 'clubvip_base_laz', 8.0, -8, -1, 49, 0, 0, 0, 0)

                                    Wait(Config.Animation.Duree_Cuisson_Friteuses)
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    ClearPedTasks(PlayerPedId())   
                                    DeleteEntity(prop) 
                                    DeleteEntity(prop2) 
                                    TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Potatoz.itemdel, Config.Cuisine.Potatoz.countdel, Config.Cuisine.Potatoz.itemadd, Config.Cuisine.Potatoz.countadd, Config.Cuisine.Potatoz.label)  
                                    VerifAnimationFriteuse = VerifAnimationFriteuse - 1
                                else 
                                    ESX.ShowNotification("~r~ Vos deux friteuses sont déjà en cours d'utilisation !")
                                end 
                            else 
                                ESX.ShowNotification("~r~ Vous n'avez plus asez de Pomme de Terre !")
                            end
                        end, Config.Cuisine.Potatoz.itemdel, Config.Cuisine.Potatoz.countdel)                                   
                    end
                    })   

                    -- Préparation Frites                  

                    RageUI.Button("Frites", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItem', function(hasEnoughItem)
                            if hasEnoughItem then
                                if VerifAnimationFriteuse == 0 or VerifAnimationFriteuse == 1 then 
                                    VerifAnimationFriteuse = VerifAnimationFriteuse + 1
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Friteuses.x, Config.Animation.Pos_Anim_Friteuses.y, Config.Animation.Pos_Anim_Friteuses.z, false, false, false, true)
                                    SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Friteuses)
                                    RageUI.CloseAll()
                                    RequestAnimDict('anim@amb@nightclub@lazlow@ig1_vip@')
                                    while not HasAnimDictLoaded('anim@amb@nightclub@lazlow@ig1_vip@') do
                                        Wait(100)
                                    end

                                    TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@lazlow@ig1_vip@', 'clubvip_base_laz', 8.0, -8, -1, 49, 0, 0, 0, 0)

                                    Wait(Config.Animation.Duree_Cuisson_Friteuses)
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    ClearPedTasks(PlayerPedId())   
                                    DeleteEntity(prop) 
                                    DeleteEntity(prop2) 
                                    TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Frites.itemdel, Config.Cuisine.Frites.countdel, Config.Cuisine.Frites.itemadd, Config.Cuisine.Frites.countadd, Config.Cuisine.Frites.label)  
                                    VerifAnimationFriteuse = VerifAnimationFriteuse - 1
                                else 
                                    ESX.ShowNotification("~r~ Vos deux friteuses sont déjà en cours d'utilisation !")
                                end  
                            else 
                                ESX.ShowNotification("~r~ Vous n'avez plus asez de Pomme de Terre !")
                            end
                        end, Config.Cuisine.Frites.itemdel, Config.Cuisine.Frites.countdel)                            
                    end
                    }) 
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bluepearl' then
            for k, v in pairs(Config.Positions) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Friteuses.x, v.Friteuses.y, v.Friteuses.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Friteuses.x, v.Friteuses.y, v.Friteuses.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 1.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        Friteuses()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

-- Fourneaux 

local OuvertFourneaux = false 
local mainMenuFourneaux = RageUI.CreateMenu('', 'Fourneaux')
mainMenuFourneaux.Display.Header = true 
mainMenuFourneaux.Closed = function()
    OuvertFourneaux = false
end

local VerifAnimationViande1 = 0
local VerifAnimationViande2 = 0

function Fourneaux()
    local position_poele1 = {x = -1844.29, y = -1186.128, z = 14.24}
    local position_poele2 = {x = -1844.79, y = -1186.196, z = 14.24}

    if OuvertFourneaux then 
        OuvertFourneaux = false
        RageUI.Visible(mainMenuFourneaux, false)
        return
    else
        OuvertFourneaux = true 
        RageUI.Visible(mainMenuFourneaux, true)
        CreateThread(function()
            while OuvertFourneaux do 
                RageUI.IsVisible(mainMenuFourneaux,function() 
                    RageUI.Separator("↓ Fourneaux ↓")

                    -- Préparation Beauf de Kobe 

                    RageUI.Button("Beauf de Kobe", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItem', function(hasEnoughItem)
                            if hasEnoughItem then
                                if VerifAnimationViande1 == 0 or VerifAnimationViande2 == 0 then
                                    if VerifAnimationViande1 == 0 then 
                                        VerifAnimationViande1 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                        
                                        prop = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele1.x, position_poele1.y, position_poele1.z,  true,  true, true)
                                        prop2 = CreateObject(GetHashKey("prop_cs_steak"), position_poele1.x, position_poele1.y, position_poele1.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop) 
                                        DeleteEntity(prop2) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Beauf_de_Kobe.itemdel, Config.Cuisine.Beauf_de_Kobe.countdel, Config.Cuisine.Beauf_de_Kobe.itemadd, Config.Cuisine.Beauf_de_Kobe.countadd, Config.Cuisine.Beauf_de_Kobe.label)  
                                        VerifAnimationViande1 = 0

                                    elseif VerifAnimationViande2 == 0 then
                                        VerifAnimationViande2 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                        
                                        prop3 = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele2.x, position_poele2.y, position_poele2.z,  true,  true, true)
                                        prop4 = CreateObject(GetHashKey("prop_cs_steak"), position_poele2.x, position_poele2.y, position_poele2.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop3) 
                                        DeleteEntity(prop4) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Beauf_de_Kobe.itemdel, Config.Cuisine.Beauf_de_Kobe.countdel, Config.Cuisine.Beauf_de_Kobe.itemadd, Config.Cuisine.Beauf_de_Kobe.countadd, Config.Cuisine.Beauf_de_Kobe.label)  
                                        VerifAnimationViande2 = 0                                
                                    end
                                else 
                                    ESX.ShowNotification("~r~ Vos plaques de cuisson sont déjà toutes utilisées !")
                                end
                            else 
                                ESX.ShowNotification("~r~ Vous n'avez plus asez de Beauf de Kobe Surgelé !")
                            end
                        end, Config.Cuisine.Beauf_de_Kobe.itemdel, Config.Cuisine.Beauf_de_Kobe.countdel)
                    end
                    })   

                    -- Préparation Poulet
                    
                    RageUI.Button("Poulet", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItem', function(hasEnoughItem) 
                            if hasEnoughItem then
                                if VerifAnimationViande1 == 0 or VerifAnimationViande2 == 0 then
                                    if VerifAnimationViande1 == 0 then 
                                        VerifAnimationViande1 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BBQ', 0, true)
                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            
                                        prop5 = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele1.x, position_poele1.y, position_poele1.z,  true,  true, true)
                                        prop6 = CreateObject(GetHashKey("prop_turkey_leg_01"), position_poele1.x, position_poele1.y, position_poele1.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop5) 
                                        DeleteEntity(prop6) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Poulet.itemdel, Config.Cuisine.Poulet.countdel, Config.Cuisine.Poulet.itemadd, Config.Cuisine.Poulet.countadd, Config.Cuisine.Poulet.label)  
                                        VerifAnimationViande1 = 0 

                                    elseif VerifAnimationViande2 == 0 then
                                        VerifAnimationViande2 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            
                                        prop7 = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele2.x, position_poele2.y, position_poele2.z,  true,  true, true)
                                        prop8 = CreateObject(GetHashKey("prop_turkey_leg_01"), position_poele2.x, position_poele2.y, position_poele2.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop7) 
                                        DeleteEntity(prop8) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Poulet.itemdel, Config.Cuisine.Poulet.countdel, Config.Cuisine.Poulet.itemadd, Config.Cuisine.Poulet.countadd, Config.Cuisine.Poulet.label)  
                                        VerifAnimationViande2 = 0                              
                                    end
                                else 
                                    ESX.ShowNotification("~r~ Vos plaques de cuisson sont déjà toutes utilisées !")
                                end
                            else 
                                ESX.ShowNotification("~r~ Vous n'avez plus asez de Poulet Surgelé !")
                            end
                        end, Config.Cuisine.Poulet.itemdel, Config.Cuisine.Poulet.countdel)
                    end
                    }) 

                    -- Préparation Porc 

                    RageUI.Button("Porc", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItem', function(hasEnoughItem)  
                            if hasEnoughItem then
                                if VerifAnimationViande1 == 0 or VerifAnimationViande2 == 0 then
                                    if VerifAnimationViande1 == 0 then 
                                        VerifAnimationViande1 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            
                                        prop9 = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele1.x, position_poele1.y, position_poele1.z,  true,  true, true)
                                        prop10 = CreateObject(GetHashKey("prop_cs_steak"), position_poele1.x, position_poele1.y, position_poele1.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop9) 
                                        DeleteEntity(prop10) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Porc.itemdel, Config.Cuisine.Porc.countdel, Config.Cuisine.Porc.itemadd, Config.Cuisine.Porc.countadd, Config.Cuisine.Porc.label)  
                                        VerifAnimationViande1 = 0

                                    elseif VerifAnimationViande2 == 0 then
                                        VerifAnimationViande2 = 1
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        SetEntityCoordsNoOffset(PlayerPedId(), Config.Animation.Pos_Anim_Fourneaux.x, Config.Animation.Pos_Anim_Fourneaux.y, Config.Animation.Pos_Anim_Fourneaux.z, false, false, false, true)
                                        SetEntityHeading(PlayerPedId(), Config.Animation.Heading_Fourneaux)
                                        RageUI.CloseAll()
                                        RequestAnimDict('amb@prop_human_bbq@male@idle_a')
                                        while not HasAnimDictLoaded('amb@prop_human_bbq@male@idle_a') do
                                            Wait(100)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bbq@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            
                                        prop11 = CreateObject(GetHashKey("prop_kitch_pot_fry"), position_poele2.x, position_poele2.y, position_poele2.z,  true,  true, true)
                                        prop12 = CreateObject(GetHashKey("prop_cs_steak"), position_poele2.x, position_poele2.y, position_poele2.z+0.01,  true,  true, true)
                                        Wait(Config.Animation.Duree_Cuisson_Viandes)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())   
                                        DeleteEntity(prop11) 
                                        DeleteEntity(prop12) 
                                        TriggerServerEvent('kBluePearl:Preparation', Config.Cuisine.Porc.itemdel, Config.Cuisine.Porc.countdel, Config.Cuisine.Porc.itemadd, Config.Cuisine.Porc.countadd, Config.Cuisine.Porc.label)

                                        VerifAnimationViande2 = 0                              
                                    end                                
                                else 
                                    ESX.ShowNotification("~r~ Vos plaques de cuisson sont déjà toutes utilisées !")
                                end
                            else 
                                ESX.ShowNotification("~r~ Vous n'avez plus asez de Porc Surgelé !")
                            end
                        end, Config.Cuisine.Porc.itemdel, Config.Cuisine.Porc.countdel)
                    end
                    }) 
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bluepearl' then
            for k, v in pairs(Config.Positions) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Fourneaux.x, v.Fourneaux.y, v.Fourneaux.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Fourneaux.x, v.Fourneaux.y, v.Fourneaux.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 1.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        Fourneaux()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)


-- Plan de Travail

local OuvertPlanTravail = false 
local mainMenuPlanTravail = RageUI.CreateMenu("", "Plan de Travail")
local MakisMenu = RageUI.CreateSubMenu(mainMenuPlanTravail, "", "Makis")
local SushiMenu = RageUI.CreateSubMenu(mainMenuPlanTravail, "", "Sushi")
local YakitoriMenu = RageUI.CreateSubMenu(mainMenuPlanTravail, "", "Yakitori")
mainMenuPlanTravail.Display.Header = true 
mainMenuPlanTravail.Closed = function()
    OuvertPlanTravail = false
end

local VerifPlanTravail = true


function PlanTravail()
    if OuvertPlanTravail then 
        OuvertPlanTravail = false
        RageUI.Visible(mainMenuPlanTravail, false)
        return
    else
        OuvertPlanTravail = true 
        RageUI.Visible(mainMenuPlanTravail, true)
        CreateThread(function()
            while OuvertPlanTravail do 
                RageUI.IsVisible(mainMenuPlanTravail, function() 
                    RageUI.Separator("↓ Plan de Travail ↓")
                    RageUI.Button("Makis", nil, {RightLabel = "→→"}, true, {}, MakisMenu);
                    RageUI.Button("Sushi", nil, {RightLabel = "→→"}, true, {}, SushiMenu); 
                    RageUI.Button("Yakitori", nil, {RightLabel = "→→"}, true, {}, YakitoriMenu); 
                end)

                RageUI.IsVisible(MakisMenu, function()
                    RageUI.Separator("↓ Makis ↓")
                    RageUI.Button("Maki Avocat & Fromage", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                                if hasEnoughItems then
                                    if VerifPlanTravail then 
                                        VerifPlanTravail = false
                                        RageUI.CloseAll()
                                        FreezeEntityPosition(PlayerPedId(), true)
                                        MiseEnMenu(Config.Plan_De_Travail.makisaf.itemdel, Config.Plan_De_Travail.makisaf.countdel, Config.Plan_De_Travail.makisaf.itemdel2, Config.Plan_De_Travail.makisaf.countdel2, Config.Plan_De_Travail.makisaf.itemadd, Config.Plan_De_Travail.makisaf.countadd, Config.Plan_De_Travail.makisaf.label)
                                    else 
                                        ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                    end
                                else 
                                    ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                                end
                            end, Config.Plan_De_Travail.makisaf.itemdel, Config.Plan_De_Travail.makisaf.countdel, Config.Plan_De_Travail.makisaf.itemdel2, Config.Plan_De_Travail.makisaf.countdel2)
                        end
                    })

                    RageUI.Button("Maki Concombre & Fromage", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.makiscf.itemdel, Config.Plan_De_Travail.makiscf.countdel, Config.Plan_De_Travail.makiscf.itemdel2, Config.Plan_De_Travail.makiscf.countdel2, Config.Plan_De_Travail.makiscf.itemadd, Config.Plan_De_Travail.makiscf.countadd, Config.Plan_De_Travail.makiscf.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.makiscf.itemdel, Config.Plan_De_Travail.makiscf.countdel, Config.Plan_De_Travail.makiscf.itemdel2, Config.Plan_De_Travail.makiscf.countdel2)
                    end
                    })

                    RageUI.Button("Maki Saumon Roll", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.makisr.itemdel, Config.Plan_De_Travail.makisr.countdel, Config.Plan_De_Travail.makisr.itemdel2, Config.Plan_De_Travail.makisr.countdel2, Config.Plan_De_Travail.makisr.itemadd, Config.Plan_De_Travail.makisr.countadd, Config.Plan_De_Travail.makisr.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.makisr.itemdel, Config.Plan_De_Travail.makisr.countdel, Config.Plan_De_Travail.makisr.itemdel2, Config.Plan_De_Travail.makisr.countdel2) 
                    end
                    })

                    RageUI.Button("Sake Soto Maki", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.sakesotomaki.itemdel, Config.Plan_De_Travail.sakesotomaki.countdel, Config.Plan_De_Travail.sakesotomaki.itemdel2, Config.Plan_De_Travail.sakesotomaki.countdel2, Config.Plan_De_Travail.sakesotomaki.itemadd, Config.Plan_De_Travail.sakesotomaki.countadd,  Config.Plan_De_Travail.sakesotomaki.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.sakesotomaki.itemdel, Config.Plan_De_Travail.sakesotomaki.countdel, Config.Plan_De_Travail.sakesotomaki.itemdel2, Config.Plan_De_Travail.sakesotomaki.countdel2)
                    end
                    })

                    RageUI.Button("Tekka Soto Maki", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.tekkasotomaki.itemdel, Config.Plan_De_Travail.tekkasotomaki.countdel, Config.Plan_De_Travail.tekkasotomaki.itemdel2, Config.Plan_De_Travail.tekkasotomaki.countdel2, Config.Plan_De_Travail.tekkasotomaki.itemadd, Config.Plan_De_Travail.tekkasotomaki.countadd,  Config.Plan_De_Travail.tekkasotomaki.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.tekkasotomaki.itemdel, Config.Plan_De_Travail.tekkasotomaki.countdel, Config.Plan_De_Travail.tekkasotomaki.itemdel2, Config.Plan_De_Travail.tekkasotomaki.countdel2) 
                    end
                    })
                end)

                RageUI.IsVisible(SushiMenu, function()
                    RageUI.Separator("↓ Sushi ↓")
                    RageUI.Button("Sushi Saumon", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.sushis.itemdel, Config.Plan_De_Travail.sushis.countdel, Config.Plan_De_Travail.sushis.itemdel2, Config.Plan_De_Travail.sushis.countdel2, Config.Plan_De_Travail.sushis.itemadd, Config.Plan_De_Travail.sushis.countadd, Config.Plan_De_Travail.sushis.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.sushis.itemdel, Config.Plan_De_Travail.sushis.countdel, Config.Plan_De_Travail.sushis.itemdel2, Config.Plan_De_Travail.sushis.countdel2)
                    end
                    })

                    RageUI.Button("Sushi Thon", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.sushit.itemdel, Config.Plan_De_Travail.sushit.countdel, Config.Plan_De_Travail.sushit.itemdel2, Config.Plan_De_Travail.sushit.countdel2, Config.Plan_De_Travail.sushit.itemadd, Config.Plan_De_Travail.sushit.countadd, Config.Plan_De_Travail.sushit.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.sushit.itemdel, Config.Plan_De_Travail.sushit.countdel, Config.Plan_De_Travail.sushit.itemdel2, Config.Plan_De_Travail.sushit.countdel2) 
                    end
                    })
                end)

                RageUI.IsVisible(YakitoriMenu, function()
                    RageUI.Separator("↓ Yakitori ↓")
                    RageUI.Button("Yakitori Beauf & Fromage", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.yakitorib.itemdel, Config.Plan_De_Travail.yakitorib.countdel, Config.Plan_De_Travail.yakitorib.itemdel2, Config.Plan_De_Travail.yakitorib.countdel2, Config.Plan_De_Travail.yakitorib.itemadd, Config.Plan_De_Travail.yakitorib.countadd, Config.Plan_De_Travail.yakitorib.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.yakitorib.itemdel, Config.Plan_De_Travail.yakitorib.countdel, Config.Plan_De_Travail.yakitorib.itemdel2, Config.Plan_De_Travail.yakitorib.countdel2)
                    end
                    })

                    RageUI.Button("Yakitori Boulette Poulet", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.yakitorip.itemdel, Config.Plan_De_Travail.yakitorip.countdel, Config.Plan_De_Travail.yakitorip.itemdel2, Config.Plan_De_Travail.yakitorip.countdel2, Config.Plan_De_Travail.yakitorip.itemadd, Config.Plan_De_Travail.yakitorip.countadd, Config.Plan_De_Travail.yakitorip.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.yakitorip.itemdel, Config.Plan_De_Travail.yakitorip.countdel, Config.Plan_De_Travail.yakitorip.itemdel2, Config.Plan_De_Travail.yakitorip.countdel2) 
                    end
                    })

                    RageUI.Button("Nêm", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('kBluePearl:VerifNombreItemAssemblage', function(hasEnoughItems) 
                            if hasEnoughItems then
                                if VerifPlanTravail then 
                                    VerifPlanTravail = false
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    MiseEnMenu(Config.Plan_De_Travail.nem.itemdel, Config.Plan_De_Travail.nem.countdel, Config.Plan_De_Travail.nem.itemdel2, Config.Plan_De_Travail.nem.countdel2, Config.Plan_De_Travail.nem.itemadd, Config.Plan_De_Travail.nem.countadd, Config.Plan_De_Travail.nem.label)
                                else 
                                    ESX.ShowNotification("~r~Vous êtes déjà entrain de composer sur le plan de travail !")
                                end
                            else 
                                ESX.ShowNotification("~r~Il vous manque certains ingrédients pour faire cette recette !")
                            end
                        end, Config.Plan_De_Travail.nem.itemdel, Config.Plan_De_Travail.nem.countdel, Config.Plan_De_Travail.nem.itemdel2, Config.Plan_De_Travail.nem.countdel2) 
                    end
                    })
                end)

            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bluepearl' then
            for k, v in pairs(Config.Positions) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Plan_Travail.x, v.Plan_Travail.y, v.Plan_Travail.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Plan_Travail.x, v.Plan_Travail.y, v.Plan_Travail.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 1.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        RageUI.CloseAll()
                        PlanTravail()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

function MiseEnMenu(itemdel, countdel, itemdel2, countdel2, itemadd, countadd, label)
    local TpPed = vector3(-1844.45, -1187.82, 14.309)
    local TpHeading = 53.16
    local PosProp = vector3(-1845.056, -1187.32, 14.23)

    SetEntityCoordsNoOffset(PlayerPedId(), TpPed.x, TpPed.y, TpPed.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), TpHeading)

    RequestAnimDict('mini@repair')
    while not HasAnimDictLoaded('mini@repair') do
        Wait(100)
    end

    TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_ped', 8.0, -8, -1, 49, 0, 0, 0, 0) 
    propmenu = CreateObject(GetHashKey("prop_ff_noodle_01"), PosProp.x, PosProp.y, PosProp.z+0.01,  true,  true, true)

    Wait(Config.Animation.Duree_Mise_En_Menu)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId()) 
    DeleteEntity(propmenu) 
    TriggerServerEvent("kBluePearl:PlanDeTravail", itemdel, countdel, itemdel2, countdel2, itemadd, countadd, label)
    VerifPlanTravail = true

end
