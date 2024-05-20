local Utils = {}

function Utils:Progress(data)
    return lib.progressBar({
        duration = data.time,
        label = data.text,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = data.dict,
            clip = data.anim,
            flag = data.flags,
        }
    })
end

function Utils:SaveClothing()
    -- ADD YOUR CLOTHING EVENTS/EXPORTS

    if Config.IlleniumAppearance then
        local ped = PlayerPedId()
        local appearance = exports['illenium-appearance']:getPedAppearance(ped)
        TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
    end

end

return Utils