local QBCore = exports['qb-core']:GetCoreObject()
local alreadyUsing = false
local hasComponentOn = {}

RegisterNetEvent('chains:useChain', function(data)
    if not data then return end
    if alreadyUsing then return end
    local ped = PlayerPedId()
    local _component = Config.Component[data.componentId]
    if not hasComponentOn[data.componentId] then
        hasComponentOn[data.componentId] = true
        alreadyUsing = true
        QBCore.Functions.Progressbar("cad_chain", _component.wearingProgressText, _component.progressTime, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = _component.animDict,
            anim = _component.anim,
            flags = _component.flags,
        }, {}, {}, function()
            alreadyUsing = false
            SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
            ClearPedTasks(ped)
        end, function ()
            alreadyUsing = false
            ClearPedTasks(ped)
        end)
    elseif hasComponentOn[data.componentId] then
        hasComponentOn[data.componentId] = false
        alreadyUsing = true
        QBCore.Functions.Progressbar("cad_chain", _component.takingoffProgressText, _component.progressTime, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = _component.animDict,
            anim = _component.anim,
            flags = _component.flags,
        }, {}, {}, function()
            alreadyUsing = false
            SetPedComponentVariation(ped, data.componentId, data.default)
            ClearPedTasks(ped)
        end, function ()
            alreadyUsing = false
            ClearPedTasks(ped)
        end)
    end
end)

RegisterNetEvent('chains:addAllComponents', function(components)
    if not components then return end
    local ped = PlayerPedId()
    for component, data in pairs(components) do
        hasComponentOn[data.componentId] = true
        SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
    end
end)

RegisterNetEvent('chains:removeChain', function(data)
    local ped = PlayerPedId()
    hasComponentOn[data.componentId] = false
    SetPedComponentVariation(ped, data.componentId, data.default)
end)