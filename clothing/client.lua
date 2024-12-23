local Utils = require 'utils.client'

local alreadyUsing = false
local hasComponentOn = {}
hasComponentOn['clothes'] = {}
hasComponentOn['prop'] = {}

RegisterNetEvent('cad-clothing:useItem', function(data)
    if not data then return end
    if alreadyUsing then return end
    local ped = PlayerPedId()
    local _component = Config.ClothAndProps[data.type][data.componentId]
    if not _component then return print('Animation is not configured for Type: '..data.type..', component: '..data.componentId) end
    if not hasComponentOn[data.type][data.componentId] then
        hasComponentOn[data.type][data.componentId] = true
        alreadyUsing = true
        local success = Utils:Progress({
            text = _component.wearingText,
            time = _component.duration,
            dict = _component.animDict,
            anim = _component.animName,
            flags = _component.flags
        })
        if success then
            SetResourceKvp(string.format('%s:%s:%d', Config.UniqueId, data.type, data.componentId), 'true')
            if data.type == 'clothes' then
                SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
            else
                SetPedPropIndex(ped, data.componentId, data.drawableId, data.textureId, data.attached or false)
            end
        end
        alreadyUsing = false
        ClearPedTasks(ped)
    elseif hasComponentOn[data.type][data.componentId] then
        hasComponentOn[data.type][data.componentId] = false
        alreadyUsing = true
        local success = Utils:Progress({
            text = _component.takingOffText,
            time = _component.duration,
            dict = _component.animDict,
            anim = _component.animName,
            flags = _component.flags
        })
        if success then
            SetResourceKvp(string.format('%s:%s:%d', Config.UniqueId, data.type, data.componentId), 'false')
            if data.type == 'clothes' then
                SetPedComponentVariation(ped, data.componentId, data.default, 0, 0)
            else
                ClearPedProp(ped, data.componentId)
            end
        end
        alreadyUsing = false
        ClearPedTasks(ped)
    end
end)

RegisterNetEvent('cad-clothing:wearSaved', function()
    local ped = PlayerPedId()
    for item, data in pairs(Config.Clothing) do
        local kvp = GetResourceKvpString(string.format('%s:%s:%d', Config.UniqueId, data.type, data.componentId))
        if kvp and (kvp == 'true') then
            hasComponentOn[data.type][data.componentId] = true
            if data.type == 'clothes' then
                SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
            else
                SetPedPropIndex(ped, data.componentId, data.drawableId, data.textureId, data.attached or false)
            end
        end
    end
end)

RegisterNetEvent('cad-clothing:removeItem', function(data)
    if not data then return end
    local ped = PlayerPedId()
    hasComponentOn[data.type][data.componentId] = false
    if data.type == 'clothes' then
        SetPedComponentVariation(ped, data.componentId, data.default, 0, 0)
    else
        ClearPedProp(ped, data.componentId)
    end
end)