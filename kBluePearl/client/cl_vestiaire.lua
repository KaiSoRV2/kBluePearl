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
local mainMenuVestiaire = RageUI.CreateMenu('', 'Vos Tenues')
mainMenuVestiaire.Display.Header = true 
mainMenuVestiaire.Closed = function()
    open = false
end

function VestiaireBluePearl()
    if open then 
        open = false
        RageUI.Visible(mainMenuVestiaire, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenuVestiaire, true)
        CreateThread(function()
        while open do 
            RageUI.IsVisible(mainMenuVestiaire,function() 
                RageUI.Separator("↓ Vestiaire ↓")
                RageUI.Checkbox("Prendre votre tenue", nil, service, {}, {
                    onChecked = function(index, items)
                        service = true
                        ServiceOn()
                        ESX.ShowAdvancedNotification('Blue Pearl', '~r~Notification', "Vous venez de prendre votre ~g~tenue", 'CHAR_CHAT_CALL', 1)
                    end,

                    onUnChecked = function(index, items)
                        service = false
                        ServiceOff()
                        ESX.ShowAdvancedNotification('Blue Pearl', '~r~Notification', "Vous venez de ~r~ranger votre tenue", 'CHAR_CHAT_CALL', 1)
                    end
                })
                end)
            Wait(0)
            end
        end)
    end
end

function  ServiceOn()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
                ['torso_1'] = 31,   ['torso_2'] = 2,
                ['arms'] = 82,
                ['pants_1'] = 52,   ['pants_2'] = 2,
                ['shoes_1'] = 20,    ['shoes_2'] = 6,
                ['helmet_1'] = 95,  ['helmet_2'] = 2,
                ['chain_1'] = 22,   ['chain_2'] = 3,
                ['ears_1'] = -1,    ['ears_2'] = 0
            }

        else
            clothesSkin = {
                ['tshirt_1'] = 38,  ['tshirt_2'] = 0,
                ['torso_1']  = 57,  ['torso_2']  = 2,
                ['arms']     = 86,
                ['pants_1']  = 6,  ['pants_2']  = 0,
                ['shoes_1']  = 42,   ['shoes_2']  = 2,
                ['helmet_1'] = 94,  ['helmet_2'] = 2,
                ['chain_1']  = 23,  ['chain_2']  = 0,
                ['ears_1']   = -1,  ['ears_2']   = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end
    
function ServiceOff()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bluepearl' then
            for k, v in pairs(Config.Positions) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Vestiaire.x, v.Vestiaire.y, v.Vestiaire.z)
  
                if dist <= Config.Markers.DistanceMarkers then 
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.Vestiaire.x, v.Vestiaire.y, v.Vestiaire.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.Markers.Texte)  
                    if IsControlJustPressed(1,51) then
                        VestiaireBluePearl()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)