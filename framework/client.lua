local Framework = {}

if Config.Progress == 'qb' then

    local QBCore = exports['qb-core']:GetCoreObject()

    function Framework:Progress(data)
        local p = promise.new()
        QBCore.Functions.Progressbar("cad_chain", data.text, data.time, false, false, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = data.dict,
            anim = data.anim,
            flags = data.flags,
        }, {}, {}, function()
            p:resolve(true)
        end, function ()
            p:resolve(false)
        end)

        return Citizen.Await(p)
    end

elseif Config.Progress == 'ox' then

    function Framework:Progress(data)
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

end

function Framework:SaveClothing()
    -- ADD YOUR CLOTHING EVENTS/EXPORTS

    if Config.IlleniumAppearance then
        local ped = PlayerPedId()
        local appearance = exports['illenium-appearance']:getPedAppearance(ped)
        TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
    end

end

return Framework