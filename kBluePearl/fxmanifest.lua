fx_version 'cerulean'
game {'gta5'};

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

    "client/cl_boss.lua",
    "client/cl_coffre.lua",
    "client/cl_cuisine.lua",
    "client/cl_garage.lua",
    "client/cl_livraisonped.lua",
    "client/cl_livraisonplayer.lua",
    "client/cl_menuF6.lua",
    "client/cl_retour_garage.lua",
    "client/cl_vestiaire.lua",
    "client/client.lua",
    "config.lua",

}

server_scripts {
    "server/server.lua",
}