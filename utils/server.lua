local Utils = {}

-- Framework Loaded Event (ESX)
RegisterNetEvent('esx:playerLoaded', function(playerId, _, _)
    TriggerClientEvent('cad-clothing:wearSaved', playerId)
end)

-- Framework Loaded Event (QBCore)
AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
    local source = player.PlayerData.source
    TriggerClientEvent('cad-clothing:wearSaved', source)
end)

-- Framework Loaded Event (OX)
AddEventHandler('ox:playerLoaded', function(playerId, _, _)
    TriggerClientEvent('cad-clothing:wearSaved', playerId)
end)

if GetResourceState('ox_inventory') == 'started' then
exports('useItem', function(event, item, inv, _, _)
    if event == 'usingItem' then
        UseComponent(inv.id, item.name)
        return false
    end
end)

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    if (type(payload.fromInventory) == 'number') and (payload.fromInventory ~= payload.toInventory) then
        local source = payload.fromInventory
        local data = payload.fromSlot
        if data and Config.Clothing[data.name] then
            RemoveComponent(source, data.name)
        end
    elseif (type(payload.toInventory) == 'number') and (payload.fromInventory ~= payload.toInventory) then
        local source = payload.toInventory
        local data = payload.toSlot
        if data and (type(data) == 'table') and Config.Clothing[data.name] then
            RemoveComponent(source, data.name)
        end
    end
end)
elseif GetResourceState('qb-inventory') == 'started' or GetResourceState('lj-inventory') == 'started' or GetResourceState('ps-inventory') == 'started' then
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, _, _, _)
    if not fromInventory or not toInventory or not fromSlot then return end
    if fromInventory ~= 'player' or (fromInventory == toInventory) then return end
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    local items = player.PlayerData.items
    for _, item in pairs(items) do
        if item.slot == fromSlot then
            if item and Config.Clothing[item.name] then
                RemoveComponent(source, item.name)
            end
        end
    end
end)

for itemName in pairs(Config.Clothing) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        UseComponent(source, itemName)
    end)
end
end

function Utils:Notify(source, msg)
    TriggerClientEvent('ox_lib:notify', source, { description = msg })
end

return Utils