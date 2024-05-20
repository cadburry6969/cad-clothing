fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cadburry (Bytecode Studios)'
description 'Clothing Items (standalone)'
version '1.4'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'utils/client.lua',
    'clothing/client.lua',
}

server_scripts {
    'utils/server.lua',
    'clothing/server.lua',
}

dependencies {
    'ox_lib'
}