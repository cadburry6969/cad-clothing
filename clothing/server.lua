local Framework = require 'framework.server'

Clothing = {}

local function checkGender(src, gender)
    local models = {
        [`mp_m_freemode_01`] = 'm',
        [`mp_f_freemode_01`] = 'f',
    }
    local model = GetEntityModel(GetPlayerPed(src))
    local tyype = models[model]
    return (tyype and gender) and (tyype ~= gender)
end

function UseComponent(playerId, itemName)
    local itemData = Config.Clothing[itemName]
    if itemData then
        if checkGender(playerId, itemData.gender) then
            Framework:Notify(playerId, 'You cannot wear this')
            return false
        end
        itemData.item = itemName
        if not Clothing[playerId] then
            Clothing[playerId] = {}
            Clothing[playerId]['clothes'] = {}
            Clothing[playerId]['prop'] = {}
        end
        Clothing[playerId][itemData.type][itemData.componentId] = itemData
        TriggerClientEvent("cad-clothing:useItem", playerId, Clothing[playerId][itemData.type][itemData.componentId])

        return false
    end
end
exports('useComponent', UseComponent)

function RemoveComponent(playerId, itemName)
    local type = Config.Clothing[itemName].type
    local componentId = Config.Clothing[itemName].componentId
    if Clothing[playerId] and Clothing[playerId][type][componentId] then
        TriggerClientEvent('cad-clothing:removeItem', playerId, Clothing[playerId][type][componentId])
        Clothing[playerId][type][componentId] = nil
    end
end
exports('removeComponent', RemoveComponent)

--[[
function OnPlayerLoaded(playerId)
    Wait(1000)
    if Clothing[playerId] and next(Clothing[playerId]) then
        TriggerClientEvent("cad-clothing:addAllItems", playerId, Clothing[playerId])
    end
end

function OnPlayerUnLoaded(playerId)
    if Clothing[playerId] then
        Clothing[playerId] = nil
    end
end
]]