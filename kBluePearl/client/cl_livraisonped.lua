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

local OuvertLivraison = false 
local mainMenuLivraison = RageUI.CreateMenu('', 'Passer une commande')
mainMenuLivraison.Display.Header = true 
mainMenuLivraison.Closed = function()
    OuvertFriteuses = false
end

local CompteurMission = true
local VerificationLivraison = 0

local table_livraison = {}

function Livraison()
    if OuvertLivraison then 
        OuvertLivraison = false
        RageUI.Visible(mainMenuLivraison, false)
        return
    else
        OuvertLivraison = true 
        RageUI.Visible(mainMenuLivraison, true)
        CreateThread(function()
            while OuvertLivraison do 
                RageUI.IsVisible(mainMenuLivraison, function() 
                    RageUI.Separator("↓ Commandes Disponibles ↓")
                    for k,v in pairs(Config.MenuLivraison) do 
                        RageUI.Button(v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true, {
                            onSelected = function()
                                if CompteurMission then
                                    ESX.TriggerServerCallback('kBluePearl:VerifArgent', function(hasEnoughMoney)
                                        if hasEnoughMoney then
                                            CompteurMission = false
                                            VerificationLivraison = 1
                                            table_livraison = {v.item1, v.count1, v.item2, v.count2, v.item3, v.count3, v.item4, v.count4}
                                            for k in pairs(table_livraison) do
                                                if table_livraison[k] == nil then
                                                    table.remove(table_livraison[k])
                                                end
                                            end
                                            PostOPMSG("Bonjour, nous avons bien reçu votre commande. Votre livraison est en cours !")
                                            RageUI.CloseAll()
                                            MissionPed()
                                        else 
                                            ESX.ShowNotification("~r~Votre entreprise n'a pas accès d'argent pour payer cette livraison !")
                                            RageUI.CloseAll()
                                        end      
                                    end, v.price)
                                else 
                                    RageUI.CloseAll()
                                    PostOPMSG("Vous avez déjà une livraison en cours !")
                                end
                            end,
                        })  
                    end
                end)
            Wait(0)
            end
        end)
    end
end


function MissionPed()

    local TypeVehiculeLivraison = GetHashKey("boxville4")  

	RequestModel(TypeVehiculeLivraison)
	while not HasModelLoaded(TypeVehiculeLivraison) do
		Wait(1)
	end
	RequestModel('s_m_m_gardener_01')
	while not HasModelLoaded('s_m_m_gardener_01') do
		Wait(1)
	end 

    VehiculeLivraison = CreateVehicle(TypeVehiculeLivraison, Config.Livraison.SpawnVehicle, Config.Livraison.SpawnHeading, true, false)                        
    ClearAreaOfVehicles(GetEntityCoords(VehiculeLivraison), 5000, false, false, false, false, false);  
    SetVehicleOnGroundProperly(VehiculeLivraison)
	SetVehicleNumberPlateText(VehiculeLivraison, "Post OP")
	SetEntityAsMissionEntity(VehiculeLivraison, true, true)
	SetVehicleEngineOn(VehiculeLivraison, true, true, false)
    SetVehicleDoorsLockedForAllPlayers(VehiculeLivraison, true)
        
    PedInVehicle = CreatePedInsideVehicle(VehiculeLivraison, 26, GetHashKey('s_m_m_gardener_01'), -1, true, false)    
    SetEntityInvincible(PedInVehicle, true)
    SetBlockingOfNonTemporaryEvents(PedInVehicle, 1)          	
        
    BlipVehiculeLivraison = AddBlipForEntity(VehiculeLivraison)                                                        	
    SetBlipFlashes(BlipVehiculeLivraison, true)  
    SetBlipColour(BlipVehiculeLivraison, 5)

    TaskVehicleDriveToCoord(PedInVehicle, VehiculeLivraison, Config.Livraison.Point_Livraison.x, Config.Livraison.Point_Livraison.y, Config.Livraison.Point_Livraison.z, 7.5, 0, GetEntityModel(VehiculeLivraison), 63, 2.0)	
    Wait(5000)
    PostOPMSG("Votre livraison est en cours d'expédition !") 
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)    

        local Depot = vector3(-1857.32, -1197.64, 13.01)
        local CoordsPed = GetEntityCoords(PedInVehicle)
        local CoordsPlayer = GetEntityCoords(PlayerPedId())

        local dist0 = Vdist(CoordsPed.x, CoordsPed.y, CoordsPed.z, Config.Livraison.Point_Livraison.x, Config.Livraison.Point_Livraison.y, Config.Livraison.Point_Livraison.z)
        local dist1 = Vdist(CoordsPed.x, CoordsPed.y, CoordsPed.z, Config.Livraison.Porte_Vehicle.x, Config.Livraison.Porte_Vehicle.y, Config.Livraison.Porte_Vehicle.z)
        local dist2 = Vdist(CoordsPed.x, CoordsPed.y, CoordsPed.z, Depot.x, Depot.y, Depot.z)


        if VerificationLivraison == 1 and dist0 <= 5 then
            Wait(1500)
            SetEntityHeading(VehiculeLivraison, Config.Livraison.Point_Livraison_Heading) 
            SetVehicleDoorOpen(VehiculeLivraison, 2, false, false)
            SetVehicleDoorOpen(VehiculeLivraison, 3, false, false) 
            Wait(1500)     
            TaskGoToCoordAnyMeans(PedInVehicle, Config.Livraison.Porte_Vehicle.x, Config.Livraison.Porte_Vehicle.y, Config.Livraison.Porte_Vehicle.z, 1.0, 0, 0, 786603, 0xbf800000)  
            VerificationLivraison = 2            
        end 

        if VerificationLivraison == 2 and dist1 <= 0.5 then
            SetEntityHeading(PedInVehicle, Config.Livraison.Heading_Porte_Vehicle)
            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do
               Wait(100)
            end

            TaskPlayAnim(PedInVehicle, 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            prop_boite = CreateObject(GetHashKey("hei_prop_heist_box"), CoordsPed.x, CoordsPed.y, CoordsPed.z,  true,  true, true)
            AttachEntityToEntity(prop_boite, PedInVehicle, GetPedBoneIndex(PedInVehicle, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
            Wait(2500)
            SetVehicleDoorShut(VehiculeLivraison, 2, true)
            SetVehicleDoorShut(VehiculeLivraison, 3, true)
            Wait(500)
            TaskGoToCoordAnyMeans(PedInVehicle, Depot.x, Depot.y, Depot.z, 1.0, 0, 0, 786603, 0xbf800000)
            VerificationLivraison = 3
        end

        if VerificationLivraison == 3 and dist2 <= 1 then 
            Wait(1000)
            SetEntityHeading(PedInVehicle, Config.Livraison.Heading_Depot) 
            TriggerServerEvent('kBluePearl:Livraison', table_livraison)
            Wait(2000)
            DeleteEntity(prop_boite)
            ClearPedTasks(PedInVehicle)
            TaskVehicleDriveToCoord(PedInVehicle, VehiculeLivraison, Config.Livraison.SpawnVehicle.x, Config.Livraison.SpawnVehicle.y, Config.Livraison.SpawnVehicle.z, 7.5, 0, GetEntityModel(VehiculeLivraison), 63, 2.0)
            VerificationLivraison = 4
        end

        if VerificationLivraison == 4 and IsPedInAnyVehicle(PedInVehicle, true) then 
            Wait(1500)
            RemovePedElegantly(PedInVehicle)
            DeleteEntity(VehiculeLivraison)
            PostOPMSG("Votre livraison a bien été effectué !")
            VerificationLivraison = 0
            CompteurMission = true
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bluepearl' then
            for k, v in pairs(Config.Positions) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Livraison.x, v.Livraison.y, v.Livraison.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Livraison.x, v.Livraison.y, v.Livraison.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        Livraison()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)


--------------------------------------------------------------------------------------------------------------------------
                                       -- [ Fonction Notification Téléhpone ] --
--------------------------------------------------------------------------------------------------------------------------

function PostOPMSG(msg)
	local phoneNr = "Post OP"
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	ESX.ShowNotification("Vous avez un nouveau message de ~o~Post OP")
	TriggerServerEvent('gcPhone:sendMessage', phoneNr, msg) --> Si vous utilisez GCPhone ne changer rien. Si vous avez un autre téléphone utiliser le bon TriggerServentEvent liée à votre téléphone
end