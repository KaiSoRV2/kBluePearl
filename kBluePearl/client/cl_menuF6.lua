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

local mainMenu = RageUI.CreateMenu("", "Blue Pearl") 
local AnnonceMenu = RageUI.CreateSubMenu(mainMenu, "", "Annonces")
local open = false

mainMenu.Closed = function() 
    open = false 
end 

ComptCommand = false

function MenuBluePearl()
    if open then 
        open = false 
            RageUI.Visible(mainMenu, false) 
            return 
    else 
        open = true 
            RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator("↓ Options ↓") 
                    RageUI.Button("Facture", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.UI.Menu.Open(
                            'dialog', GetCurrentResourceName(), 'facture',
                            {
                                title = 'Donner une facture'
                            },
                            function(data, menu)
                        
                                local amount = tonumber(data.value)
                        
                                if amount == nil or amount <= 0 then
                                    ESX.ShowNotification('Montant invalide')
                                else
                                    menu.close()
                        
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        
                                    if closestPlayer == -1 or closestDistance > 3.0 then
                                        ESX.ShowNotification('Pas de joueurs proche')
                                    else
                                        local playerPed = GetPlayerPed(-1)
                        
                                        Citizen.CreateThread(function()
                                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                            Citizen.Wait(5000)
                                            ClearPedTasks(playerPed)
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_irishpub', 'irishpub', amount)
                                            ESX.ShowNotification("~r~Vous avez bien envoyé la facture")
                                        end)
                                    end
                                end
                            end,
                            function(data, menu)
                                menu.close()
                        end)
                    end
                    })

                    RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true, {}, AnnonceMenu)    
                    
                    RageUI.Button("Prendre une Commande", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        if not ComptCommand then 
                            ComptCommand = true
                            PrendreUneCommande()
                        else 
                            ESX.ShowNotification("~r~Vous avez déjà une commande en cours !")
                        end
                    end})
                end)

                RageUI.IsVisible(AnnonceMenu, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Separator("↓ Annonces ↓")
                    RageUI.Button("Annonce ~g~Ouverture~s~", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('kBluePearl:AnnonceOuverture')
                    end
                    })

                    RageUI.Button("Annonce ~r~Fermeture~s~", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('kBluePearl:AnnonceFermeture')  
                    end
                    })

                    RageUI.Button("Annonce ~y~Recrutement~s~", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('kBluePearl:AnnonceRecrutement') 
                    end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("F6", "bluepearl", "Ouvrir le menu du Blue Pearl", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == "bluepearl" then
        MenuBluePearl()
    end
end)