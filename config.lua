Config = {}

-- Any ID of your wish but unique to your server
Config.UniqueId = 'a9v5m5'

-- Configure the component and drawableid for a item mentioned above
Config.Clothing = {
    -- itemName = { gender = 'm' or 'f' or false, type = 'clothes' or 'prop', componentId = 7, default = 0, drawableId = 10, textureId = 0, palleteId = 0 }
    -- gender: 'm': for male, 'f': for female, false: for all (https://docs.fivem.net/natives/?_0x262B14F48D29DE80)
    -- clothes
    chain1 = { gender = false, type = 'clothes', componentId = 7, default = 0, drawableId = 10, textureId = 0, palleteId = 0 },
    mask1 = { gender = false, type = 'clothes', componentId = 1, default = 0, drawableId = 2, textureId = 0, palleteId = 0 },
    -- props
    band1 = { gender = false, type = 'prop', componentId = 7, default = -1, drawableId = 1, textureId = 0, attached = false },

}

-- Configure the emote for each component
Config.ClothAndProps = {
    -- [componentId] = { animDict = 'clothingtie', animName = 'try_tie_positive_a' }
    ['clothes'] = {
        [1] = {
            animDict = 'mp_masks@standard_car@ds@',
            animName = 'put_on_mask',
            flags = 51,
            wearingText = 'Putting on mask..',
            takingOffText = 'Taking off mask..',
            duration = 600
        },
        [6] = {
            animDict = 'random@domestic',
            animName = 'pickup_low',
            wearingText = 'Putting on shoes..',
            takingOffText = 'Taking off shoes..',
            duration = 1000
        },
        [7] = {
            animDict = 'clothingtie',
            animName = 'try_tie_positive_a',
            wearingText = 'Putting on chain..',
            takingOffText = 'Taking off chain..',
            duration = 600
        },
        [10] = {
            animDict = 'clothingtie',
            animName = 'try_tie_positive_a',
            wearingText = 'Putting on chain..',
            takingOffText = 'Taking off chain..',
            duration = 600
        },
    },
    ['prop'] = {
        [0] = {
            animDict = 'clothingtie',
            animName = 'try_tie_positive_a',
            wearingText = 'Putting on Hat..',
            takingOffText = 'Taking off Hat..',
            duration = 600
        },
        [1] = {
            animDict = 'random@domestic',
            animName = 'pickup_low',
            wearingText = 'Putting on Glass..',
            takingOffText = 'Taking off Glass..',
            duration = 1000
        },
        [2] = {
            animDict = 'clothingtie',
            animName = 'try_tie_positive_a',
            wearingText = 'Putting on Ear..',
            takingOffText = 'Taking off Ear..',
            duration = 600
        },
        [6] = {
            animDict = 'clothingtie',
            animName = 'try_tie_positive_a',
            wearingText = 'Putting on Watch..',
            takingOffText = 'Taking off Watch..',
            duration = 600
        },
        [7] = {
            animDict = 'missmic4',
            animName = 'michael_tux_fidget',
            wearingText = 'Putting on Bracelet..',
            takingOffText = 'Taking off Bracelet..',
            duration = 1500
        },
    }
}