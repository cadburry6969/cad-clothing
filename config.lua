Config = {}

-- Add/Remove item upon wearing/removing item component
Config.AddRemoveItem = true

-- Configure all the items you want in server
Config.Items = {
    ['chain1'] = {
        ['name'] = 'chain1',
        ['label'] = 'Chain 1',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'chain1.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Some chain',
    },
    ['mask1'] = {
        ['name'] = 'mask1',
        ['label'] = 'Mask 1',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'mask1.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Some mask',
    }
}

-- Configure the component and drawableid for a item mentioned above
Config.Chains = {
    { item = 'chain1', componentId = 7, default = 0, drawableId = 10, textureId = 0, palleteId = 0 },
    { item = 'chain2', componentId = 7, default = 0, drawableId = 11, textureId = 0, palleteId = 0 },
    { item = 'mask1', componentId = 1, default = 0, drawableId = 1, textureId = 0, palleteId = 0 },
}

-- Configure the emote for each component
Config.Component = {
    -- [componentId] = { animDict = 'clothingtie', anim = 'try_tie_positive_a', flags = 51 }
    [1] = {
        animDict = 'mp_masks@standard_car@ds@',
        anim = 'put_on_mask',
        flags = 51,
        wearingProgressText = 'Putting on mask..',
        takingoffProgressText = 'Taking off mask..',
        progressTime = 600
    },
    [7] = {
        animDict = 'clothingtie',
        anim = 'try_tie_positive_a',
        flags = 51,
        wearingProgressText = 'Putting on chain..',
        takingoffProgressText = 'Taking off chain..',
        progressTime = 3000
    }
}