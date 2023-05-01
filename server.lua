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
