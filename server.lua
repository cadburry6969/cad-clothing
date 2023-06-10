local QBCore = exports['qb-core']:GetCoreObject()
local playerChains = {}

for item, data in pairs(Config.Items) do
    local success, message = exports['qb-core']:AddItem(item, data)
    if not success then print(message) end
end

for _, data in pairs(Config.Chains) do
    exports['qb-inventory']:CreateUsableItem(data.item, function(source, item)
        local playerId = source
        if playerChains[playerId] == nil then playerChains[playerId] = {} end
        playerChains[playerId][data.componentId] = data
        TriggerClientEvent("chains:useChain", playerId, playerChains[playerId][data.componentId])
        if Config.AddRemoveItem then
            exports['qb-inventory']:RemoveItem(source, data.item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[data.item], "remove", 1)
        end
    end)
end

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000)
    local playerId = Player.PlayerData.source
    if playerChains[playerId] and next(playerChains[playerId]) then
        TriggerClientEvent("chains:addAllComponents", playerId, playerChains[playerId])
    end
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(playerId)
    if playerChains[playerId] then
        playerChains[playerId] = nil
    end
end)

if Config.AddRemoveItem then
    local components = {
        ["FACE"] = 0,
        ["MASK"] = 1,
        ["HAIR"] = 2,
        ["SHIRT"] = 3,
        ["PANT"] = 4,
        ["PARACHUTE"] = 5,
        ["SHOES"] = 6,
        ["CHAIN"] = 7,
        ["UNDERSHIRT"] = 8,
        ["VEST"] = 9,
        ["DECALS"] = 10,
        ["SHIRT2"] = 11,
    }
    RegisterNetEvent('chains:removeClothing', function(componentId)
        local source = source
        if playerChains[source] and playerChains[source][componentId] then
            TriggerClientEvent("chains:useChain", source, playerChains[source][componentId])
            exports['qb-inventory']:AddItem(source, playerChains[source][componentId].item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[playerChains[source][componentId].item], "add", 1)
            playerChains[source][componentId] = nil
        end
    end)
    RegisterCommand('rem', function(source, args)
        local type = string.upper(tostring(args[1]))
        if playerChains[source] then
            local cId = components[type] or false
            if cId and playerChains[source][cId] then
                TriggerClientEvent("chains:useChain", source, playerChains[source][cId])
                exports['qb-inventory']:AddItem(source, playerChains[source][cId].item, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[playerChains[source][cId].item], "add", 1)
                playerChains[source][cId] = nil
            end
        end
    end, true)
else
    local function getComponentFromItem(item)
        local component = 0
        for _, v in pairs(Config.Chains) do
            if v.item == item then
                component = v.componentId
                break
            end
        end
        return component
    end

    local function onRemoveItem(playerId, item)
        local component = getComponentFromItem(item)
        if playerChains[playerId] and playerChains[playerId][component] then
            TriggerClientEvent("chains:removeChain", playerId, playerChains[playerId][component])
            playerChains[playerId][component] = nil
        end
    end exports('onRemoveItem', onRemoveItem)
end