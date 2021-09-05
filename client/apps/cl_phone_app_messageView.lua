function openMessageView(scaleform, contact, message, fromme, hasPic, canOpenMenu)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Message")
    local var = "From: "
    if fromme == true then
        var = "To: "
    end
    local pic = 'CHAR_BLANK_ENTRY'
    local _canOpenMenu = false
    if hasPic ~= nil then
        pic = hasPic
    end
    if canOpenMenu ~= nil then
        _canOpenMenu = canOpenMenu
    end
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 7, 0, var..contact, message, pic)

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, _canOpenMenu, 11)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 7, 0)
end

AddEventHandler('scalePhone.HandleInput.messageView', function(input)
    if input == "left" then
        CellCamMoveFinger(4)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 4)
    elseif input == 'right' then
        CellCamMoveFinger(3)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 2)
    elseif input == 'up' then
        CellCamMoveFinger(1)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 1)
    elseif input == 'down' then
        CellCamMoveFinger(2)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 3)
    elseif input == 'select' then
        if apps[appOpen].data.canOpenMenu ~= nil and apps[appOpen].data.canOpenMenu == true and apps[appOpen].data.selectEvent ~= nil then
            CellCamMoveFinger(5)
            TriggerEvent(apps[appOpen].data.selectEvent, apps[appOpen].data)
        end
    elseif input == 'back' then
        CellCamMoveFinger(5)
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data)
    end

    local ret = Scaleform.CallFunction(phoneScaleform, true, "GET_CURRENT_SELECTION")
    while true do
        if IsScaleformMovieMethodReturnValueReady(ret) then
            appSelectID = GetScaleformMovieMethodReturnValueInt(ret) --output
            break
        end
        Citizen.Wait(0)
    end
end)