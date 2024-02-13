isPhoneActive = false
canPhoneBeOpened = true
phoneScaleform = 0
cameraScaleform = 0
appOpen = 0
appOpenIsNonHome = false
lastAppOpen = 0
selectID = 0
appSelectID = 0
renderID = 0
themeID = 0
phoneCaseID = 0
phoneScale = 250.0 --250.0
phonePos = {x = 47.0, y = -22.0, z = -60.0}
sleepMode = false
themeScaleform = {id = "CELLPHONE_IFRUIT", defaultwp = 'Phone_Wallpaper_ifruitdefault'}

TextToTexture = {
    ['_RP_BANNER_'] = {'_RP_BANNER_', 'emailads_rp','emailads_rp'},
    ['_MAZEB_BANNER_'] = {'_MAZEB_BANNER_', 'emailads_maze_bank','emailads_maze_bank'},
    ['_FLEC_BANNER_'] = {'_FLEC_BANNER_', 'thumbnail_fleeca_com','thumbnail_fleeca_com'},
    ['_AMMU_BANNER_'] = {'_AMMU_BANNER_', 'emailads_ammunation','emailads_ammunation'},
    ['_ARENA_BANNER_'] = {'_ARENA_BANNER_', 'emailads_arena','emailads_arena'},
    ['_BENNYS_BANNER_'] = {'_BENNY_BANNER_', 'emailads_bennys','emailads_bennys'},
    ['_LSCUSTOM_BANNER_'] = {'_LSCUSTOM_BANNER_', 'emailads_ls_customs','emailads_ls_customs'},
    ['_LI_BANNER_'] = {'_LI_BANNER_', 'emailads_lifeinvader','emailads_lifeinvader'},
    ['_LSTI_BANNER_'] = {'_LSTI_BANNER_', 'emailads_ls_tourist_info','emailads_ls_tourist_info'},
    ['_WAR_BANNER_'] = {'_WAR_BANNER_', 'emailads_warstock','emailads_warstock'},
    ['_LS_CARMEET_BANNER_'] = {'_LS_CARMEET_BANNER_', 'emailads_ls_car_meet','emailads_ls_car_meet'},
    ['_CASINO_BANNER_'] = {'_CASINO_BANNER_', 'emailads_diamond','emailads_diamond'},
}

overrideWallpaper = {
    --["all"] = {type = ""--[[texture, file, or link]], txd = CreateRuntimeTxd('phone_wallpaper_override')--[[texture directory]], txn = "phone_wallpaper_override"--[[texture name. Should be the same as txd]]}
    --[0] = "",
    --[1] = "",
    --[2] = "",
    --[3] = "",
    --[4] = "",
    --[5] = "",
    --[6] = "",
}
--LOADING WALLPAPERS ON FIRST LOAD--
------------------------------------
Citizen.CreateThread(function()
    local wpType = GetResourceKvpString('scalePhone_wp_type_all')
    local wpImgsource = GetResourceKvpString('scalePhone_wp_imgsource_all')
    local wpImgsource2 = GetResourceKvpString('scalePhone_wp_imgsource2_all')
    if wpType then
        if wpType == 'url' then
            if wpImgsource then
                TriggerEvent('scalePhone.OverrideWallpaper', wpType, 'all', wpImgsource)
            end
        elseif wpType == 'texture' then
            if wpImgsource and wpImgsource2 then
                TriggerEvent('scalePhone.OverrideWallpaper', wpType, 'all', wpImgsource, wpImgsource2)
            end
        elseif wpType == 'clear' then
            TriggerEvent('scalePhone.OverrideWallpaper', wpType, 'all')
        end
    else
        print('cant find wpType')
    end

    for i=0, 6, 1 do
        local wpType = GetResourceKvpString('scalePhone_wp_type_'..i)
        local wpImgsource = GetResourceKvpString('scalePhone_wp_imgsource_'..i)
        local wpImgsource2 = GetResourceKvpString('scalePhone_wp_imgsource2_'..i)
        if wpType then
            if wpType == 'url' then
                if wpImgsource then
                    TriggerEvent('scalePhone.OverrideWallpaper', wpType, i, wpImgsource)
                end
            elseif wpType == 'texture' then
                if wpImgsource and wpImgsource2 then
                    TriggerEvent('scalePhone.OverrideWallpaper', wpType, i, wpImgsource, wpImgsource2)
                end
            elseif wpType == 'clear' then
                TriggerEvent('scalePhone.OverrideWallpaper', wpType, i)
            end
        end
    end
end)
------------------------------------

apps = {
    --[[ HOMEPAGE ]]--
    [0] = {appID = 'scalePhone.InternalMenu.DontUse.Homepage', 1, type = 'homepage', name = 'Home', icon = 0, notif = 0, openEvent = 'scalePhone.GoBackApp', backEvent = 'scalePhone.ClosePhone', data = {},
        buttons = {
            --[0] = {appID = 1, id = 2, isLeftToRight = false, type = "contacts", name = "Contacts", icon = 5, notif = 0, openEvent = "scalePhone.OpenContacts", backEvent = "scalePhone.GoToHomepage"},
        },
    },
    --[[ ESSENTIAL APPS ]]--
    [1000] = {appID = 1000, id = 7, isLeftToRight = false, type = "messageView", name = "Message", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {contact = "Contact", message = 'unk', fromme = false, hasPic = "CHAR_BLANK_ENTRY", canOpenMenu = false, selectEvent = ""},
    buttons = {
        }
    },
    [1001] = {appID = 1001, id = 9, isLeftToRight = false, type = "emailView", name = "Email", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {title = "Email", message = 'unk', from = "", to = "", canOpenMenu = false, selectEvent = ""},
    buttons = {
        }
    },
    [1002] = {appID = 1002, id = 15, isLeftToRight = false, type = "todoView", name = "To Do", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {title = "", line1 = '', line2 = '', footer = ""},
    buttons = {
        }
    },
}

RegisterCommand('phone', function()
    if isPhoneActive == false and canPhoneBeOpened == true then
        TriggerEvent('scalePhone.OpenPhone')
    elseif isPhoneActive == true then
        TriggerEvent('scalePhone.ClosePhone')
    end
end)
RegisterKeyMapping('phone', "Open Phone", 'keyboard', 'm')

Citizen.CreateThread(function()
    while true do
        if isPhoneActive then
            local coords = GetEntityCoords(PlayerPedId())
            SetTextRenderId(renderID)
            Scaleform.CallFunction(phoneScaleform, false, "SET_TITLEBAR_TIME", GetClockHours(), GetClockMinutes(), day[GetClockDayOfWeek()])
            Scaleform.CallFunction(phoneScaleform, false, "SET_SIGNAL_STRENGTH", GetZoneScumminess(GetZoneAtCoords(coords.x, coords.y, coords.z)))
            if GetFollowPedCamViewMode() == 4 then
				SetMobilePhoneScale(0.0)
			else
				SetMobilePhoneScale(tonumber(phoneScale) + 0.0)
			end
            if apps[appOpen].type == "tv" then
                SetTvAudioFrontend(true)
                Set_2dLayer(4)
                Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 90.0, 255, 255, 255, 255)
            else
                DrawScaleformMovie(phoneScaleform, 0.1, 0.18, 0.2, 0.35, 255, 255, 255, 255, 0)
            end
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())

            if apps[appOpen].type == 'snapmatic' then
                HideHudComponentThisFrame(7)
                HideHudComponentThisFrame(8)
                HideHudComponentThisFrame(9)
                HideHudComponentThisFrame(6)
                HideHudComponentThisFrame(19)
                HideHudAndRadarThisFrame()

                DrawScaleformMovieFullscreen(cameraScaleform, 255, 255, 255, 255)
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterCommand('phoneleft', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'left')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneleft', "Phone Swipe Left", 'keyboard', 'LEFT')

RegisterCommand('phoneright', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'right')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneright', "Phone Swipe Right", 'keyboard', 'RIGHT')

RegisterCommand('phoneup', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'up')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneup', "Phone Swipe Up", 'keyboard', 'UP')

RegisterCommand('phonedown', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'down')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phonedown', "Phone Swipe Down", 'keyboard', 'DOWN')

RegisterCommand('phoneselect', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'select')
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneselect', "Phone Select", 'keyboard', 'RETURN')

RegisterCommand('phoneback', function()
    if isPhoneActive then
        if appOpen ~= 0 then
            TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'back')
            PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", 1)
        else
            TriggerEvent('scalePhone.HandleInput.homepage', 'back')
        end
    end
end)
RegisterKeyMapping('phoneback', "Phone Back", 'keyboard', 'BACK')