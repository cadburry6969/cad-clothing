This script allows you to create any clothing component as an item.

# Preview
[Click Here](https://youtu.be/Giy2gnHiIYo)

# Features: 
- Use multiple component items.
- Sync even after re-entering server.
- Removes the component if the item was removed from inventory.
- Optimized Code

# Dependencies
* ox_lib
* es_extended / qb-core
* qb-inventory / ox_inventory

# Configuration 
* Add `cad-clothing` to resources and `ensure cad-clothing` in `server.cfg`
* If you have `qb-inventory` then complete the below steps
	* Compare the below `RemoveItem` function with the one your have in `qb-inventory/server` and add the lines saying `ADDED`.
	```lua
	exports['cad-clothing']:removeComponent(source, item)-- ADDED
	```
```lua
local function RemoveItem(source, item, amount, slot)
	local Player = QBCore.Functions.GetPlayer(source)

	if not Player then return false end

	amount = tonumber(amount) or 1
	slot = tonumber(slot)

	if slot then
		if not Player.PlayerData.items[slot] then
			DropPlayer(source, 'Failed to remove item, most likely cheating')
			return false
		end
		if Player.PlayerData.items[slot].amount > amount then
			Player.PlayerData.items[slot].amount = Player.PlayerData.items[slot].amount - amount
			Player.Functions.SetPlayerData('items', Player.PlayerData.items)

			if not Player.Offline then
				exports['cad-clothing']:removeComponent(source, item) -- ADDED
				TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. Player.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[slot].amount)
			end

			return true
		elseif Player.PlayerData.items[slot].amount == amount then
			Player.PlayerData.items[slot] = nil
			Player.Functions.SetPlayerData('items', Player.PlayerData.items)

			if Player.Offline then return true end

			exports['cad-clothing']:removeComponent(source, item) -- ADDED
			TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')

			return true
		end
	else
		local slots = GetSlotsByItem(Player.PlayerData.items, item)
		local amountToRemove = amount

		if not slots then return false end

		for _, _slot in pairs(slots) do
			if not Player.PlayerData.items[_slot] then
				DropPlayer(source, 'Failed to remove item, most likely cheating')
				return false
			end
			if Player.PlayerData.items[_slot].amount > amountToRemove then
				Player.PlayerData.items[_slot].amount = Player.PlayerData.items[_slot].amount - amountToRemove
				Player.Functions.SetPlayerData('items', Player.PlayerData.items)

				if not Player.Offline then
					exports['cad-clothing']:removeComponent(source, item) -- ADDED

					TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. Player.PlayerData.items[_slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[_slot].amount)
				end

				return true
			elseif Player.PlayerData.items[_slot].amount == amountToRemove then
				Player.PlayerData.items[_slot] = nil
				Player.Functions.SetPlayerData('items', Player.PlayerData.items)

				if Player.Offline then return true end
				exports['cad-clothing']:removeComponent(source, item) -- ADDED

				TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')

				return true
			end
		end
	end
	return false
end
```