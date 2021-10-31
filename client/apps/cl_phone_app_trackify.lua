local lastRunId = nil

function openTrackifyView(scaleform, title, buttons, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)

    math.randomseed(GetGameTimer())
    local newId = math.random(100000,999999)
    while newId == lastRunId do
        newId = math.random(100000,999999)
    end

    lastRunId = newId

    --[[if buttons ~= nil then
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, 0, buttons[0].title, buttons[0].subtitle)
        for i=1, #buttons-1, 1 do
            Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, i, false, buttons[i].title)
        end
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 19, #buttons, buttons[#buttons].title)
    end]]
    local app = appOpen
    local appSession = 0
    local _coords= vector3(0.0,0.0,0.0)
    local dist = #(_coords - GetEntityCoords(PlayerPedId()))

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, false, 9)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)

    --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, 0, 0, 0, dontShowIntro, 1, 1)
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 23, 1)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, 0, 0, 0, 0, 1, 1)
    Wait(100) -- not sure why we wait, but it doesn't work otherwise.
    Citizen.CreateThread(function()
        while app == appOpen do
            if lastRunId ~= nil and newId ~= lastRunId then
                break
            end
            pedPos = GetEntityCoords(PlayerPedId())
            dist = #(_coords.xy - pedPos.xy)
            local _x = _coords.x - pedPos.x
            local _y = _coords.y - pedPos.y
            local _heading = GetEntityHeading(PlayerPedId()) - GetHeadingFromVector_2d(_x, _y)
            if _heading <=0 then
                _heading = _heading + 360
            end
            --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, _rotation, _distance, _distanceOnPhone(smaller = accurate), 1, 1.0, 10)
            Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, _heading, dist, 100, 60, 10.0, 50)
            Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 23,1)
            Wait(1000)
        end
    end)
end

AddEventHandler('scalePhone.HandleInput.trackifyView', function(input)
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
        lastRunId = nil
        isAppOpen = false
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