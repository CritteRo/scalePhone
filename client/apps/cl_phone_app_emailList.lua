function openEmailsMenu(scaleform, emails, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 8)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, true, 10)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)
    for i,k in pairs(emails) do
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, slotID, someIconID, 0, Title, Message)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, i, 1, 0, k.title, k.message)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 8, selectID)
end


AddEventHandler('scalePhone.HandleInput.emailList', function(input)
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
        CellCamMoveFinger(5)
        --TriggerEvent('scalePhone.BuildEmailView', apps[appOpen].buttons[appSelectID])
        if apps[appOpen].buttons[appSelectID] ~= nil then
            TriggerEvent(apps[appOpen].buttons[appSelectID].event, apps[appOpen].buttons[appSelectID].eventParams)
        end
    elseif input == 'back' then
        CellCamMoveFinger(5)
        RemoveNotifications(appOpen)
        --apps[0].buttons[2].notif = 0
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