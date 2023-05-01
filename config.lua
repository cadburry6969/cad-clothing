Config = {}

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

Config.Chains = {
    { item = 'chain1', componentId = 7, default = 0, drawableId = 10, textureId = 0, palleteId = 0 },
    { item = 'chain2', componentId = 7, default = 0, drawableId = 11, textureId = 0, palleteId = 0 },
    { item = 'mask1', componentId = 1, default = 0, drawableId = 1, textureId = 0, palleteId = 0 },
}

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