# EXAMPLE FOR OX INVENTORY (ox_inventory/data/items.lua)
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

# EXAMPLE FOR QB INVENTORY (qb-core/shared/items.lua)
```lua
	chain1 = {
		name = 'chain1',
		label = 'Chain 1',
		weight = 100,
		type = 'item',
		image = 'chain1.png',
		unique = true,
		useable = true,
		shouldClose = true,
		description = ''
	},
	mask1 = {
		name = 'mask1',
		label = 'Mask 1',
		weight = 100,
		type = 'item',
		image = 'mask1.png',
		unique = true,
		useable = true,
		shouldClose = true,
		description = ''
	},
	band1 = {
		name = 'band1',
		label = 'Band 1',
		weight = 100,
		type = 'item',
		image = 'band1.png',
		unique = true,
		useable = true,
		shouldClose = true,
		description = ''
	},
```
