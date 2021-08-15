fx_version 'cerulean'
game 'gta5'

author 'CritteR / CritteRo'
description 'GTA:O Style phone for FiveM, using scaleforms.'

client_scripts {
    'client/cl_functions.lua',
    'client/apps/cl_scaleform_functions.lua',
    'client/apps/cl_phone_app_homepage.lua',
    'client/apps/cl_phone_app_snapmatic.lua',
    'client/apps/cl_phone_app_contacts.lua',
    'client/apps/cl_phone_app_emailList.lua',
    'client/apps/cl_phone_app_emailView.lua',
    'client/apps/cl_phone_app_messagesList.lua',
    'client/apps/cl_phone_app_messageView.lua',
    'client/apps/cl_phone_app_todoList.lua',
    'client/apps/cl_phone_app_menu.lua',
    'client/apps/cl_phone_app_numpad.lua',
    'client/cl_phone_handle.lua',
    'client/cl_phone_events.lua',
    'client/cl_phone_example.lua',
}

server_scripts {
    'server/sv_phone_handle.lua',
}