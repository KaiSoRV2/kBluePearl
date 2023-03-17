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

local open = false 
local societyargent = nil
local mainMenuBoss = RageUI.CreateMenu('', 'Gestion Entreprise')
mainMenuBoss.Display.Header = true 
mainMenuBoss.Closed = function()
  open = false
end

function MenuBossBP()
    if open then 
        open = false
        RageUI.Visible(mainMenuBoss, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenuBoss, true)
        CreateThread(function()
        while open do 
            RageUI.IsVisible(mainMenuBoss,function() 
            RageUI.Separator("↓ Gestion Entreprise ↓") 
            RageUI.Button("Accédez à la gestion de l\'entreprise" , nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    GestionBoss()
                    RageUI.CloseAll()    
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
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Boss.x, v.Boss.y, v.Boss.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Boss.x, v.Boss.y, v.Boss.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        MenuBossBP()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)