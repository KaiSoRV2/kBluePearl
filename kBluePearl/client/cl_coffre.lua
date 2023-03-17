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

local mainMenu = RageUI.CreateMenu("", "Action :")
local PutMenu = RageUI.CreateSubMenu(mainMenu,"", "Votre Inventaire :")
local GetMenu = RageUI.CreateSubMenu(mainMenu,"", "Coffre Entreprise :")

local open = false

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    open = false
end

all_items = {}
  
function CoffreBluePearl() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while open do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                        getStock()
                    end},GetMenu);

                    RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                        getInventory()
                    end},PutMenu);
                end)

                RageUI.IsVisible(GetMenu, function()  
                    for k,v in pairs(all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = "x"..""..v.nb}, true, {onSelected = function()
                            local count = KeyboardInput("Combien voulez vous en déposer",nil,4)
                            count = tonumber(count)
                            if count <= v.nb then
                                TriggerServerEvent("kBluePearl:takeStockItems",v.item, count)
                            else
                                ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                            end
                            getStock()
                        end});
                    end
                end)

                RageUI.IsVisible(PutMenu, function()        
                    for k,v in pairs(all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = "x"..""..v.nb}, true, {onSelected = function()
                            local count = KeyboardInput("Combien voulez vous en déposer",nil,4)
                            count = tonumber(count)
                            TriggerServerEvent("kBluePearl:putStockItems",v.item, count)
                            getInventory()
                        end});
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
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Coffre.x, v.Coffre.y, v.Coffre.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Coffre.x, v.Coffre.y, v.Coffre.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 1.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte) 
                    if IsControlJustPressed(1,51) then
                        RageUI.CloseAll()
                        CoffreBluePearl()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)