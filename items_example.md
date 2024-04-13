# Below are examples for adding clothing related items

> QB INVENTORY
```lua
    chain1                       = { name = 'chain1', label = 'Chain 1', weight = 100, type = 'item', image = 'chain1.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Some chain' },
    mask1                        = { name = 'mask1', label = 'Mask 1', weight = 100, type = 'item', image = 'mask1.png', unique = true, useable = true, shouldClose = false, combinable = nil, description = 'Some mask' },
    band1                        = { name = 'band1', label = 'Band 1', weight = 100, type = 'item', image = 'band1.png', unique = true, useable = true, shouldClose = false, combinable = nil, description = 'Some band' }
```

> OX INVENTORY
```lua
    ['chain1'] = {
		label = 'Chain 1',
        weight = 100,
		consume = 0,
        server = {
			export = 'cad-clothing.useItem'
		},
	},
    ['mask1'] = {
		label = 'Mask 1',
        weight = 100,
		consume = 0,
        server = {
			export = 'cad-clothing.useItem'
		},
	},
    ['band1'] = {
		label = 'Band 1',
        weight = 100,
		consume = 0,
        server = {
			export = 'cad-clothing.useItem'
		},
	},
```