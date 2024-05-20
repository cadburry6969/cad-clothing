local Utils = {}

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

function Utils:Notify(source, msg)
    TriggerClientEvent('ox_lib:notify', source, { description = msg })
end

return Utils