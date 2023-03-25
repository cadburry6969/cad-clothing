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
    }
}

Config.Chains = {
    { item = 'chain1', componentId = 7, default = 0, drawableId = 1, textureId = 0, palleteId = 0 },
}