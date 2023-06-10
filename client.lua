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
        QBCore.Functions.Progressbar("cad_chain", _component.wearingProgressText, _component.progressTime, false, false, {
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
        QBCore.Functions.Progressbar("cad_chain", _component.takingoffProgressText, _component.progressTime, false, false, {
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

    RegisterNetEvent('qb-radialmenu:removeComponent', function(data)
        local component = data.component
        if components[component] then
            TriggerServerEvent('chains:removeClothing', components[component])
        end
    end)

    local items = {
        id = 'removecomponent',
        title = 'Remove Clothing',
        icon = 'shirt',
        items = {
            {
                id = 'cadmask',
                title = 'Mask',
                icon = 'mask',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'MASK',
                shouldClose = true
            }, {
                id = 'cadchain',
                title = 'Chain',
                icon = 'link',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'CHAIN',
                shouldClose = true
            }, {
                id = 'cadvest',
                title = 'Vest',
                icon = 'vest',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'VEST',
                shouldClose = true
            }, {
                id = 'cadshoes',
                title = 'Shoes',
                icon = 'shoe-prints',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'SHOES',
                shouldClose = true
            }, {
                id = 'cadshirt',
                title = 'Shirt',
                icon = 'shirt',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'SHIRT',
                shouldClose = true
            }, {
                id = 'cadshirt2',
                title = 'Shirt 2',
                icon = 'shirt',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'SHIRT2',
                shouldClose = true
            }, {
                id = 'cadundershirt',
                title = 'Undershirt',
                icon = 'shirt',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'UNDERSHIRT',
                shouldClose = true
            }, {
                id = 'cadpant',
                title = 'Pant',
                icon = 'socks',
                type = 'client',
                event = 'qb-radialmenu:removeComponent',
                component = 'PANT',
                shouldClose = true
            }
        }
    }
    exports['qb-radialmenu']:AddOption(items)
end