local QBCore = exports['qb-core']:GetCoreObject()

local isWearingChain = false
RegisterNetEvent('chains:useChain', function(data)
    if not data then return end
    local ped = PlayerPedId()
    if not isWearingChain then
        isWearingChain = true
        TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"})
        QBCore.Functions.Progressbar("cad_chain", "Putting on chain..", 3000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            SetPedComponentVariation(ped, data.componentId, data.drawableId, data.textureId, data.palleteId or 0)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    elseif isWearingChain then
        isWearingChain = false
        TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"})
        QBCore.Functions.Progressbar("cad_chain", "Taking off chain..", 3000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            SetPedComponentVariation(ped, data.componentId, data.default)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    end
end)

RegisterNetEvent('chains:removeChain', function(data)
    local ped = PlayerPedId()
    -- TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"})
    isWearingChain = false
    SetPedComponentVariation(ped, data.componentId, data.default)
    -- TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)