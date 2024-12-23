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

return Utils