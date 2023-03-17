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

MenuEnPreparation = false
function PrendreUneCommande()
    
    local Active = true
    while Active do 
        for k,v in pairs(Config.MenuLivraisonPlayer) do

            random = math.random(1, #Config.MenuLivraisonPlayer)
            Table_Menu = {v.item1, v.label1, v.count1, v.item2, v.label2, v.count2, v.item3, v.label3, v.count3}
            price_menu = v.price

            if random == v.id then
                Active = false
                MenuEnPreparation = true
                break
            end 
        end 
    end 
    Citizen.Wait(1000)
end 


local LivraisonEnCours = false
function LivraisonPlayer()
    local Active = true
    while Active do 
        for k,v in pairs(Config.LieuLivraison) do
            random = math.random(1, #Config.LieuLivraison)

            if random == v.id then 
                Active = false
                Position_Livrasion = vector3(v.pos.x, v.pos.y, v.pos.z)
                BlipLivraison = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
                SetBlipFlashes(BlipLivraison, true)  
                SetBlipColour(BlipLivraison, 5)
                BluePearlLivraison("Le lieu de la livraison vient d'être placer sur votre GPS !")
                SetBlipAsMissionCreatorBlip(BlipLivraison,true)
				SetBlipRoute(BlipLivraison, 1)
                LivraisonEnCours = true
                break
            end
        end 
    end 
end 


Citizen.CreateThread(function()
    while true do
        if MenuEnPreparation then 
            ESX.TriggerServerCallback('kBluePearl:MenuEnPreparation', function(HasEnoughItemsForMenu) 
                if HasEnoughItemsForMenu then 
                    ESX.ShowNotification("~g~Vous pouvez désormais procéder à la livraison !")
                    MenuEnPreparation = false
                    LivraisonPlayer()
                else 
                    ESX.ShowNotification("~r~Il vous faut : ~s~\nx"..Table_Menu[3].." "..Table_Menu[2].."\nx"..Table_Menu[6].." "..Table_Menu[5].."\nx"..Table_Menu[9].." "..Table_Menu[8])
                end
            end, Table_Menu)
        end
        Citizen.Wait(2000) 
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 750
        if LivraisonEnCours then 
            local CoordsPlayer = GetEntityCoords(PlayerPedId()) 
            local dist = Vdist(CoordsPlayer.x, CoordsPlayer.y, CoordsPlayer.z, Position_Livrasion.x, Position_Livrasion.y, Position_Livrasion.z)
            if dist <= 3 then 
                wait = 0
                ESX.ShowHelpNotification(Config.Markers.Texte) 
                DrawMarker(Config.Markers.Type, Position_Livrasion.x, Position_Livrasion.y, Position_Livrasion.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.Markers.Largeur, Config.Markers.Epaisseur, Config.Markers.Hauteur, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Opaciter, Config.Markers.Saute, true, p19, Config.Markers.Tourne)  
                if IsControlJustPressed(1,51) then
                    ESX.TriggerServerCallback('kBluePearl:MenuEnPreparation', function(StillHasItems) 
                        if StillHasItems then 
                            TriggerServerEvent('kBluePearl:DepotMenu', price_menu, Table_Menu)
                            RemoveBlip(BlipLivraison)
                            LivraisonEnCours = false
                            ComptCommand = false
                        else 
                            ESX.ShowNotification("~r~Vous avez dû faire tomber des éléments de votre livraison lors de votre trajet !")
                        end 
                    end, Table_Menu)
                end
            end
        end
    Citizen.Wait(wait) 
    end
end)

function BluePearlLivraison(msg)
	local phoneNr = "Livraison BP"
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	ESX.ShowNotification("Vous avez un nouveau message de ~o~Livraison BP")
	TriggerServerEvent('gcPhone:sendMessage', phoneNr, msg) --> Si vous utilisez GCPhone ne changer rien. Si vous avez un autre téléphone utiliser le bon TriggerServentEvent liée à votre téléphone
end