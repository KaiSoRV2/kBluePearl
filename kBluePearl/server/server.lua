ESX = nil

 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 TriggerEvent('esx_society:registerSociety', 'bluepearl', 'bluepearl', 'society_bluepearl', 'society_bluepearl', 'society_bluepearl', {type = 'private'})
   
------------------------[ CONFIG ANNONCES F6 ]------------------------ 

RegisterServerEvent('kBluePearl:AnnonceOuverture')
AddEventHandler('kBluePearl:AnnonceOuverture', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blue Pearl', '~r~Annonce', 'Le Blue Pearl est maintenant ~b~ouvert !', 'CHAR_CHAT_CALL', 1) --> Modif Char pour le logo entreprise
	end
end)

RegisterServerEvent('kBluePearl:AnnonceFermeture')
AddEventHandler('kBluePearl:AnnonceFermeture', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blue Pearl', '~r~Annonce', 'Le Blue Pearl ferme ses portes pour ~r~aujourd\'hui~s~ !', 'CHAR_CHAT_CALL', 1)
	end
end)

RegisterServerEvent('kBluePearl:AnnonceRecrutement')
AddEventHandler('kBluePearl:AnnonceRecrutement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blue Pearl', '~r~Annonce', '~s~Recrutement en cours, rendez-vous au Blue Pearl', 'CHAR_CHAT_CALL', 1)
	end
end)

------------------------[ CONFIG COFFRE ]------------------------ 

ESX.RegisterServerCallback('kBluePearl:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

	
end)

ESX.RegisterServerCallback('kBluePearl:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bluepearl', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('kBluePearl:putStockItems')
AddEventHandler('kBluePearl:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bluepearl', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~HUD_COLOUR_BLUELIGHT~Coffre : ~s~Blue Pearl \n~s~- ~o~Quantitée ~s~: "..count.."")
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
		end
	end)
end)

RegisterServerEvent('kBluePearl:takeStockItems')
AddEventHandler('kBluePearl:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bluepearl', function(inventory)
			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~r~Retrait\n~s~- ~HUD_COLOUR_BLUELIGHT~Coffre : ~s~Blue Pearl \n~s~- ~o~Quantitée ~s~: "..count.."")
	end)
end)


------------------------[ CONFIG CUISINE ]------------------------ 

RegisterServerEvent("kBluePearl:Preparation")
AddEventHandler("kBluePearl:Preparation", function(itemdel, countdel, itemadd, countadd, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local limite_itemadd = xPlayer.getInventoryItem(itemadd).count
	if limite_itemadd >= 100 then
        TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas en porter d'avantage")
    else
		xPlayer.removeInventoryItem(itemdel, countdel)
        xPlayer.addInventoryItem(itemadd, countadd)
        TriggerClientEvent("esx:showNotification", source, "Vous venez de préparer x"..countadd.."~HUD_COLOUR_RADAR_ARMOUR~ "..label)
    end
end)


ESX.RegisterServerCallback('kBluePearl:VerifNombreItem', function(source, cb, itemdel, countdel)

	local xPlayer = ESX.GetPlayerFromId(source)
	local verif_itemdel = xPlayer.getInventoryItem(itemdel).count
	if verif_itemdel >= countdel then 
		cb(true)
	else 
	 	cb(false)
	end
end)

-- Plan de Travail 

RegisterServerEvent("kBluePearl:PlanDeTravail")
AddEventHandler("kBluePearl:PlanDeTravail", function(itemdel, countdel, itemdel2, countdel2, itemadd, countadd, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local limite_itemadd = xPlayer.getInventoryItem(itemadd).count
	if limite_itemadd >= 100 then
        TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas en porter d'avantage")

    elseif (itemdel2 and countdel2) ~= nil then 
		xPlayer.removeInventoryItem(itemdel, countdel)
		xPlayer.removeInventoryItem(itemdel2, countdel2)
		xPlayer.addInventoryItem(itemadd, countadd)
		TriggerClientEvent("esx:showNotification", source, "Vous venez de préparer x"..countadd.."~HUD_COLOUR_RADAR_ARMOUR~ "..label)	
	else 
		xPlayer.removeInventoryItem(itemdel, countdel)
        xPlayer.addInventoryItem(itemadd, countadd)
        TriggerClientEvent("esx:showNotification", source, "Vous venez de préparer x"..countadd.."~HUD_COLOUR_RADAR_ARMOUR~ "..label)
    end
end)

ESX.RegisterServerCallback('kBluePearl:VerifNombreItemAssemblage', function(source, cb, itemdel, countdel, itemdel2, countdel2)

	local xPlayer = ESX.GetPlayerFromId(source)

	if (itemdel2 and countdel2) == nil then 
		local verif_itemdel = xPlayer.getInventoryItem(itemdel).count
		if verif_itemdel >= countdel then
			cb(true)
		else
			cb(false)
		end
	
	elseif ((itemdel and countdel) and (itemdel2 and countdel2)) ~= nil then
		local verif_itemdel = xPlayer.getInventoryItem(itemdel).count
		local verif_itemdel2 = xPlayer.getInventoryItem(itemdel2).count
	
		if verif_itemdel >= countdel and verif_itemdel2 >= countdel2 then
			cb(true)
		else
			cb(false)
		end
	end
end)


------------------------[ CONFIG LIVRAISON PED]------------------------ 

ESX.RegisterServerCallback('kBluePearl:VerifArgent', function(source, cb, price)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bluepearl', function(account)
		societyAccount = account 
	end)

	if societyAccount.money <= price then
		cb(false)
	else 
		societyAccount.removeMoney(price)
		cb(true)
	end
end)

RegisterServerEvent('kBluePearl:Livraison')
AddEventHandler('kBluePearl:Livraison', function(table_livraison)
	
	for k in pairs(table_livraison) do
		--print("type de l'indice",table_livraison[k], type(table_livraison[k]))
		if type(table_livraison[k]) ~= 'string' then
			--print("pas un string")
		else 
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bluepearl', function(inventory)
				inventory.addItem(table_livraison[k], table_livraison[k+1])
			end)
		end
	end
end)

------------------------[ CONFIG LIVRAISON PLAYER]------------------------ 

ESX.RegisterServerCallback('kBluePearl:MenuEnPreparation', function(source, cb, Table_Menu)

	local xPlayer = ESX.GetPlayerFromId(source)

	local verif_item1 = xPlayer.getInventoryItem(Table_Menu[1]).count
	local verif_item2 = xPlayer.getInventoryItem(Table_Menu[4]).count
	local verif_item3 = xPlayer.getInventoryItem(Table_Menu[7]).count

	if (verif_item1 >= Table_Menu[3]) and (verif_item2 >= Table_Menu[6]) and (verif_item3 >= Table_Menu[9]) then
		cb(true)
	else 
		cb(false)
	end
end)


RegisterServerEvent('kBluePearl:DepotMenu')
AddEventHandler('kBluePearl:DepotMenu', function(price_menu, Table_Menu)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney  = ESX.Math.Round(price_menu / 100 * 30)
	local societyMoney = ESX.Math.Round(price_menu / 100 * 70)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bluepearl', function(account)
        societyAccount = account
    end)

	xPlayer.removeInventoryItem(Table_Menu[1], Table_Menu[3])
	xPlayer.removeInventoryItem(Table_Menu[4], Table_Menu[6])
	xPlayer.removeInventoryItem(Table_Menu[7], Table_Menu[9])					
	xPlayer.addMoney(playerMoney)
    societyAccount.addMoney(societyMoney)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez rapporté :\nEntreprise : ~g~"..societyMoney.."$\n~s~Employé : ~g~"..playerMoney.."$")

end)
