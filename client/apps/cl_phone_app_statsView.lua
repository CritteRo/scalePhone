function openMissionStatsView(scaleform)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "View")

    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 0, 'Farmen | Civilian', 'CritteR')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 1, false, 'UID  //  14')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 2, false, 'Level  //  100')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 3, false, 'Heist Points  //  54', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 4, false, 'Job Points  //  32', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 5, false, 'Rank  //  4', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 6, false, 'UID  //  14')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 7, false, 'Level  //  100')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 8, false, 'Heist Points  //  54', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 9, false, 'Job Points  //  32', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 10, false, 'Rank  //  4', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 11, false, 'UID  //  14')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 12, false, 'Level  //  100')
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 13, false, 'Heist Points  //  54', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 14, false, 'Job Points  //  32', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 15, false, 'Rank  //  4', 0)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 16, 'Stats Screen', 100, 1)

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 19, 0)
end

AddEventHandler('scalePhone.HandleInput.bossJobView', function(input)
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
        --CellCamMoveFinger(5)
        --TriggerEvent('scalePhone.BuildMessageView', apps[appOpen].buttons[appSelectID])
        --TriggerEvent('scalePhone.OpenApp', 1000, false)
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