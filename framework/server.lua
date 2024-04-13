local Framework = {}

--[[
if Config.Framework == 'qb' then

    AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
        local playerId = player.PlayerData.source
        OnPlayerLoaded(playerId)
    end)

    AddEventHandler('QBCore:Server:OnPlayerUnload', function(playerId)
        OnPlayerUnLoaded(playerId)
    end)

elseif Config.Framework == 'esx' then

    RegisterNetEvent('esx:playerLoaded', function(playerId)
        OnPlayerLoaded(playerId)
    end)

    RegisterNetEvent('esx:playerDropped', function(playerId)
        OnPlayerUnLoaded(playerId)
    end)

end
]]

if Config.Inventory == 'qb' then

    local QBCore = exports['qb-core']:GetCoreObject()

    for itemName in pairs(Config.Clothing) do
        QBCore.Functions.CreateUseableItem(itemName, function(source, item)
            UseComponent(source, item.name)
        end)
    end

elseif Config.Inventory == 'ox' then

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

end

function Framework:Notify(source, msg)
    TriggerClientEvent('ox_lib:notify', source, { description = msg })
end

return Framework