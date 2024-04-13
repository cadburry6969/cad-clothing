local Framework = require 'framework.client'

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
        local success = Framework:Progress({
            text = _component.wearingText,
            time = _component.duration,
            dict = _component.animDict,
            anim = _component.animName,
            flags = _component.flags
        })
        if success then
            if data.type == 'clothes' then
                SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
            else
                SetPedPropIndex(ped, data.componentId, data.drawableId, data.textureId, data.attached or false)
            end
            Framework:SaveClothing()
        end
        alreadyUsing = false
        ClearPedTasks(ped)
    elseif hasComponentOn[data.type][data.componentId] then
        hasComponentOn[data.type][data.componentId] = false
        alreadyUsing = true
        local success = Framework:Progress({
            text = _component.takingOffText,
            time = _component.duration,
            dict = _component.animDict,
            anim = _component.animName,
            flags = _component.flags
        })
        if success then
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

--[[
RegisterNetEvent('cad-clothing:addAllItems', function(components)
    if not components then return end
    local ped = PlayerPedId()
    for component, data in pairs(components) do
        hasComponentOn[data.type][data.componentId] = true
        if data.type == 'clothes' then
            SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
        else
            SetPedPropIndex(ped, data.componentId, data.drawableId, data.textureId, data.attached or false)
        end
    end
    Wait(500)
    Framework:SaveClothing()
end)

RegisterNetEvent('cad-clothing:removeAllItems', function(components)
    if not components or not next(components) then return end
    local ped = PlayerPedId()
    for component, data in pairs(components) do
        if not data.type or not data.componentId then goto skip end
        hasComponentOn[data.type][data.componentId] = false
        if data.type == 'clothes' then
            SetPedComponentVariation(ped, data.componentId, data.default, 0, 0)
        else
            ClearPedProp(ped, data.componentId)
        end
        ::skip::
    end
    Wait(500)
    Framework:SaveClothing()
end)
]]

RegisterNetEvent('cad-clothing:removeItem', function(data)
    if not data then return end
    local ped = PlayerPedId()
    hasComponentOn[data.type][data.componentId] = false
    if data.type == 'clothes' then
        SetPedComponentVariation(ped, data.componentId, data.default, 0, 0)
    else
        ClearPedProp(ped, data.componentId)
    end
    Wait(500)
    Framework:SaveClothing()
end)