function openEmailView(scaleform, title, from, to, message, canOpenMenu)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 9, 0, 1, to, from, "<c>"..title.."</c>", message)

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, canOpenMenu, 11)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 9, 0)
end

AddEventHandler('scalePhone.HandleInput.emailView', function(input)
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