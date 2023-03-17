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

function SetVehicleMaxMods(veh)
    local props = {
      modEngine       = 3,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    } 
    ESX.Game.SetVehicleProperties(veh, props)
end

local Ouvert = false 
local MenuGarage = RageUI.CreateMenu('', 'Véhicules Entreprises')
MenuGarage.Display.Header = true 
MenuGarage.Closed = function()
    Ouvert = false
end

function GarageBluePearl()
    if open then 
        open = false
        RageUI.Visible(MenuGarage, false)
        return
    else
        open = true 
        RageUI.Visible(MenuGarage, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuGarage,function() 
                RageUI.Separator("↓ Véhicules ↓")
                    for k,v in pairs(Config.VehiculeBluePearl) do
                        RageUI.Button(v.label, nil, {RightLabel = "→→"}, true , {
                        onSelected = function()
                            if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                                ESX.ShowNotification("~b~Blue Pearl\n~r~Point de spawn bloquée")
                            else
                                local model = GetHashKey(v.spawnname)
                                RequestModel(model)
                                while not HasModelLoaded(model) do 
                                    Wait(10) 
                                end
                                veh = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                                SetVehicleNumberPlateText(veh, "BPearl"..math.random(50, 999))
                                SetVehicleWindowTint(veh, 1)
                                SetVehicleCustomPrimaryColour(veh, 32, 72, 247)
                                SetVehicleCustomSecondaryColour(veh, 32, 72, 247)
                                SetVehicleFixed(veh)
                                SetVehRadioStation(veh, 0)
                                SetVehicleMaxMods(veh)
                                RageUI.CloseAll()
                            end
                        end
                        })
                    end
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
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Garage_Voiture.x, v.Garage_Voiture.y, v.Garage_Voiture.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.TypeGarage, v.Garage_Voiture.x, v.Garage_Voiture.y, v.Garage_Voiture.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte) 
                    if IsControlJustPressed(1,51) then
                        GarageBluePearl()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)


local Ouvert = false 
local mainRetourVoitureBP = RageUI.CreateMenu('', 'Rentrer le véhicule')
mainRetourVoitureBP.Display.Header = true 
mainRetourVoitureBP.Closed = function()
    Ouvert = false
end

function RetourVoitureBP()
    if Ouvert then 
        Ouvert = false
        RageUI.Visible(mainRetourVoitureBP, false)
        return
    else
        Ouvert = true 
        RageUI.Visible(mainRetourVoitureBP, true)
        CreateThread(function()
            while Ouvert do 
                RageUI.IsVisible(mainRetourVoitureBP,function() 
                RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 1 then
                            DeleteEntity(veh)
                            ESX.ShowNotification('~r~Garage \n~g~- Véhicule rangé !~s~')
                            RageUI.CloseAll()
                        end
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
                local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Voiture_Retour.x, v.Voiture_Retour.y, v.Voiture_Retour.z)
  
                if dist2 <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.TypeGarage, v.Voiture_Retour.x, v.Voiture_Retour.y, v.Voiture_Retour.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist2 <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RetourVoitureBP()
                        else
                            ESX.ShowNotification('Vous devez être dans un ~r~Véhicule !~s~')
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

-- Bateau 

local Ouvert = false 
local mainRetourBateauBP = RageUI.CreateMenu('', 'Rentrer le véhicule')
mainRetourBateauBP.Display.Header = true 
mainRetourBateauBP.Closed = function()
    Ouvert = false
end

function RetourBateauBP()
    if Ouvert then 
        Ouvert = false
        RageUI.Visible(mainRetourBateauBP, false)
        return
    else
        Ouvert = true 
        RageUI.Visible(mainRetourBateauBP, true)
        CreateThread(function()
            while Ouvert do 
                RageUI.IsVisible(mainRetourBateauBP,function() 
                RageUI.Button("Ranger votre bateau", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 1 then
                            DeleteEntity(veh)
                            ESX.ShowNotification('~r~Garage \n~g~- Bateau rangé !~s~')
                            SetEntityCoordsNoOffset(PlayerPedId(), Config.Markers_Retour_Bateau.TP_Ped.x, Config.Markers_Retour_Bateau.TP_Ped.y, Config.Markers_Retour_Bateau.TP_Ped.z, false, false, false, true)
                            RageUI.CloseAll()
                        end
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
                local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Bateau_Retour.x, v.Bateau_Retour.y, v.Bateau_Retour.z)
  
                if dist2 <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers_Retour_Bateau.TypeRetourBateau, v.Bateau_Retour.x, v.Bateau_Retour.y, v.Bateau_Retour.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers_Retour_Bateau.Largeur, Config.Markers_Retour_Bateau.Epaisseur, Config.Markers_Retour_Bateau.Hauteur, Config.Markers_Retour_Bateau.Color.r, Config.Markers_Retour_Bateau.Color.g, Config.Markers_Retour_Bateau.Color.b, Config.Markers_Retour_Bateau.Opaciter, Config.Markers_Retour_Bateau.Saute, true, p19, Config.Markers_Retour_Bateau.Tourne)  
                end
  
                if dist2 <= 10.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RetourBateauBP()
                        else
                            ESX.ShowNotification('Vous devez être dans un ~r~Véhicule !~s~')
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)