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

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

-- Fonctions Boss Menu

function ArgentRefresh(money)
    bluepearl = ESX.Math.GroupDigits(money)
end

function UpdateMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            ArgentRefresh(money)
        end, ESX.PlayerData.job.name)
    end
end

function GestionBoss()
    TriggerEvent('esx_society:openBossMenu', 'bluepearl', function(data, menu)
        menu.close()
    end, {wash = false})
end

-- Fonctions Coffre

function getInventory()
    ESX.TriggerServerCallback('kBluePearl:playerinventory', function(inventory)                            
        all_items = inventory   
    end)
end

function getStock()
    ESX.TriggerServerCallback('kBluePearl:getStockItems', function(inventory)                     
        all_items = inventory     
    end)
end

-- Blips 

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Blips.BlipsMaps.Position.x, Config.Blips.BlipsMaps.Position.y, Config.Blips.BlipsMaps.Position.z)
    SetBlipSprite(blip, Config.Blips.BlipsMaps.Type)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, Config.Blips.BlipsMaps.Color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.Blips.BlipsMaps.Title)
    EndTextCommandSetBlipName(blip)
end)
