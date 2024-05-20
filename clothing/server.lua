local Utils = require 'utils.server'

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
            Utils:Notify(playerId, 'You cannot wear this')
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
    local itemData = Config.Clothing[itemName]
    if itemData then
        local type = itemData.type
        local componentId = itemData.componentId
        if Clothing[playerId] and Clothing[playerId][type][componentId] then
            TriggerClientEvent('cad-clothing:removeItem', playerId, Clothing[playerId][type][componentId])
            Clothing[playerId][type][componentId] = nil
        end
    end
end
exports('removeComponent', RemoveComponent)