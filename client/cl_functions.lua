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
    TriggerEvent('scalePhone.Event.SleepModeChanged', sleepMode)
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
    ['tv'] = {id = -1, isLeftToRight = false},
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

function findButtonIdUsingData(appID, dataSample) --this approach might get....ummm....laggy.
    if apps[appID] ~= nil then
        if apps[appID].buttons ~= nil then
            local id = nil
            for i,k in pairs(apps[appID].buttons) do
                if k.eventParams ~= nil then
                    if type(k.eventParams) == 'table' and type(dataSample) ~= 'table' then
                        for j,v in pairs(k.eventParams) do
                            if v == dataSample then
                                id = i
                                break
                            end
                        end
                    elseif type(k.eventParams) ~= 'table' and type(dataSample) ~= 'table' then
                        if k.eventParams == dataSample then
                            id = i
                            break
                        end
                    elseif type(k.eventParams) == 'table' and type(dataSample) == 'table' then
                        if k.eventParams == dataSample then
                            id = i
                            break
                        end
                    end
                end
            end

            if id ~= nil then
                return id
            else
                print('[[  ::  ERROR  ::  WE COULD NOT FIND YOUR BUTTON ID. MAKE SURE THE SAMPLE DATA MATCHES ANY VALUE IN "eventParams" OR IS EQUAL TO "eventParams"  ::  ]]')
            end
        end
    else
        print('[[  ::  ERROR  ::  INVALID APP ID WHEN SEARCHING FOR A BUTTON ID  ::  ]]')
    end
end

function reorderAppButtons(appID)
    local row = 0
    local placeholder = {}
    local IsFirstItemANill = false
    if apps[appID].buttons[0] ~= nil then
        IsFirstItemANill = false
    else
        IsFirstItemANill = true
    end
    for i,k in pairs(apps[appID].buttons) do
        if apps[appID].buttons[i] ~= nil then
            placeholder[row] = apps[appID].buttons[i]
            row = row + 1
        else
            if i == 0 then
                IsFirstItemANill = true
            end
        end
    end
    if IsFirstItemANill == false then
        for i = #placeholder, 0, -1 do
            placeholder[i+1] = placeholder[i]
        end
        placeholder[0] = placeholder[#placeholder]
        placeholder[#placeholder] = nil
    end

    apps[appID].buttons = placeholder
end

function setPhoneScale(scale)
    local _scale = 250.0
    local _pos = {x = 47.0, y = -22.0, z = -60.0}
    if tonumber(scale) ~= nil then
        _scale = tonumber(scale) + 0.0
        _pos.y = -16.0
        print('[  ::  WARNING IN setPhoneScale  ::  Setting a custom phone scale value might cause a unexpected behavior. Please use "large" or "default" instead.  ::  ]')
    elseif scale == "default" then
    elseif scale == "large" then
        _scale = 350.0
        _pos.y = -16.0
        --_pos.x = 55.0
    else
        print('[  ::  ERROR IN setPhoneScale  ::  parameter is not a number. Setting phone scale to "default"  ::  ]')
    end
    phoneScale = _scale
    phonePos = _pos
    SetMobilePhonePosition(phonePos.x, phonePos.y, phonePos.z)
end