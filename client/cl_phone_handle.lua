isPhoneActive = false
phoneScaleform = 0
cameraScaleform = 0
appOpen = 0
appOpenIsNonHome = false
lastAppOpen = 0
selectID = 0
appSelectID = 0
renderID = 0
themeID = 0
themeScaleform = {id = "CELLPHONE_IFRUIT", defaultwp = 'Phone_Wallpaper_ifruitdefault'}

apps = {
    --[[ HOMEPAGE ]]--
    [0] = {appID = 'scalePhone.InternalMenu.DontUse.Homepage', 1, type = 'homepage', name = 'Home', icon = 0, notif = 0, openEvent = 'scalePhone.GoBackApp', backEvent = 'scalePhone.ClosePhone', data = {},
        buttons = {
            --[0] = {appID = 1, id = 2, isLeftToRight = false, type = "contacts", name = "Contacts", icon = 5, notif = 0, openEvent = "scalePhone.OpenContacts", backEvent = "scalePhone.GoToHomepage"},
        },
    },
    --[[ ESSENTIAL APPS ]]--
    [1000] = {appID = 1000, id = 7, isLeftToRight = false, type = "messageView", name = "Message", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {contact = "Contact", message = 'unk', fromme = false},
    buttons = {
        }
    },
    [1001] = {appID = 1001, id = 9, isLeftToRight = false, type = "emailView", name = "Email", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {title = "Email", message = 'unk', from = "", to = ""},
    buttons = {
        }
    },
    [1002] = {appID = 1002, id = 15, isLeftToRight = false, type = "todoView", name = "To Do", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {title = "", line1 = '', line2 = '', footer = ""},
    buttons = {
        }
    },
}

RegisterCommand('phone', function()
    if isPhoneActive == false then
        CreateMobilePhone(0)
        renderID = GetMobilePhoneRenderId() --render id for both the phone AND the frontend render.
        SetMobilePhonePosition(45.0,-23.0,-60.0)
        SetMobilePhoneRotation(-90.0,0.0,0.0) --last one is important
        SetPhoneLean(false) --flips the phone in hand
        SetMobilePhoneScale(250.0)
        appOpen = 0
        selectID = 0
        phoneScaleform = generateMainPhone(apps[appOpen].buttons, selectID, themeID)
        isPhoneActive = true
        SetPedConfigFlag(PlayerPedId(), 242, not true)
		SetPedConfigFlag(PlayerPedId(), 243, not true)
		SetPedConfigFlag(PlayerPedId(), 244, true)
		N_0x83a169eabcdb10a2(PlayerPedId(), 0)
        PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    elseif isPhoneActive == true then
        DestroyMobilePhone()
        isPhoneActive = false
        PlaySoundFrontend(-1, "Put_Away", "Phone_SoundSet_Michael", 1)
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
				SetMobilePhoneScale(250.0)
			end
            DrawScaleformMovie(phoneScaleform, 0.1, 0.18, 0.2, 0.35, 255, 255, 255, 255, 0)
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