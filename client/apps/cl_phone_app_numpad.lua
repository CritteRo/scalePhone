function openNumpadMenu(scaleform, title, buttons, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "")
    if apps[appOpen].dataText ~= nil then
        Scaleform.CallFunction(scaleform, false, "SET_HEADER", apps[appOpen].dataText)
    end
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 11)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, true, 9)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)
    for i,k in pairs(buttons) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 11, i, k.text)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 11, 0)
end

AddEventHandler('scalePhone.HandleInput.numpad', function(input)
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
        TriggerEvent(apps[appOpen].buttons[appSelectID].event, apps[appOpen].buttons[appSelectID].eventParams)
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
