local playerChains = {}

for item, data in pairs(Config.Items) do
    local success, message = exports['qb-core']:AddItem(item, data)
    if not success then print(message) end
end

for _, data in pairs(Config.Chains) do
    exports['qb-inventory']:CreateUseableItem(data.item, function(source, item)
        local playerId = source
        playerChains[playerId] = data
        TriggerClientEvent("chains:useChain", playerId, data)
    end)
end

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000)
    local playerId = Player.PlayerData.source
    if playerChains[playerId] then
        TriggerClientEvent("chains:useChain", playerId, playerChains[playerId])
    end
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(playerId)
    if playerChains[playerId] then
        playerChains[playerId] = nil
    end
end)

local function onRemoveItem(playerId)
    if playerChains[playerId] then
        TriggerClientEvent("chains:removeChain", playerId, playerChains[playerId])
        playerChains[playerId] = nil
    end
end exports('onRemoveItem', onRemoveItem)