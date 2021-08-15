function openContactsMenu(scaleform, contacts, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 2)
    for i,k in pairs(contacts) do
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 2, slotID, unk, Contact Name, unk, Contact Mugshot)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 2, i, 0, k.name, "", k.pic)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 2, selectID)
end

AddEventHandler('scalePhone.HandleInput.contacts', function(input)
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
        TriggerEvent(apps[appOpen].buttons[appSelectID].event, apps[appOpen].buttons[appSelectID].eventParams, false)
    elseif input == 'back' then
        CellCamMoveFinger(5)
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data, false)
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