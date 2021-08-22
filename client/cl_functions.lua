AddEventHandler("scalePhone.ChangePhoneTheme", function(_data)
    if _data.themeID ~= nil then
        themeID = _data.themeID
        if isPhoneActive then
            phoneScaleform = generateMainPhone(apps[0].buttons, selectID, themeID)
            appOpen = 0
        end
    end
end)

AddEventHandler("scalePhone.TogglePhoneSleepMode", function()
    sleepMode = not sleepMode
    Scaleform.CallFunction(phoneScaleform, false, "SET_SLEEP_MODE", sleepMode)
end)

blacklistID = {
    0, 1000, 1001, 1002, 'scalePhone.InternalMenu.DontUse.Homepage', 'scalePhone.Internal.Themes'
}

typeDetails = {
    ['homepage'] = {id = 1, isLeftToRight = true},
    ['contacts'] = {id = 2, isLeftToRight = false},
    ['callscreen'] = {id = 4, isLeftToRight = false},
    ['messagesList'] = {id = 6, isLeftToRight = false},
    ['messageView'] = {id = 7, isLeftToRight = false},
    ['emailList'] = {id = 8, isLeftToRight = false},
    ['emailView'] = {id = 9, isLeftToRight = false},
    ['menu'] = {id = 18, isLeftToRight = false},
    ['snapmatic'] = {id = 16, isLeftToRight = true},
    ['todoList'] = {id = 14, isLeftToRight = false},
    ['todoView'] = {id = 15, isLeftToRight = false},
    ['missionStatsView'] = {id = 19, isLeftToRight = false},
    ['numpad'] = {id = 11, isLeftToRight = true},
    ['gps'] = {id = 24, isLeftToRight = false},
    ['settings'] = {id = 22, isLeftToRight = false},
}

function RemoveNotifications(appID)
    for i,k in pairs(apps[0].buttons) do
        if appID == k.appID then
            k.notif = 0
        end
    end
end

function getAppOpen(isLast)
    local retval = appOpen
    if isLast ~= nil and isLast == true then
        retval = lastAppOpen
    end
    return retval
end

function sleepModeStatus()
    return sleepMode
end