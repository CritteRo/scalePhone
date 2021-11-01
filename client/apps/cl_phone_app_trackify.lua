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
    local app = appOpen
    local appSession = 0
    local range = 100
    local _coords= vector3(0.0,0.0,0.0)
    local dist = #(_coords - GetEntityCoords(PlayerPedId()))

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, false, 9)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)

    --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, 0, 0, 0, dontShowIntro, 1, 1)
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 23, 1)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, -1, 0, 0, 1, 1, 1)
    Wait(100) -- not sure why we wait, but it doesn't work otherwise.
    Citizen.CreateThread(function()
        while app == appOpen and isPhoneActive == true do
            if lastRunId ~= nil and newId ~= lastRunId then
                break
            end
            pedPos = GetEntityCoords(PlayerPedId())
            local row = 0
            for i,k in pairs(buttons) do
                --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 23, row) breaks the scaleform
                dist = #(k.coords.xy - pedPos.xy)
                local _x = k.coords.x - pedPos.x
                local _y = k.coords.y - pedPos.y
                local _heading = GetEntityHeading(PlayerPedId()) - GetHeadingFromVector_2d(_x, _y)
                if _heading <=0 then
                    _heading = _heading + 360
                end
                --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, 0, _rotation, _distance, _distanceOnPhone(smaller = accurate), 1, 1.0, 10)
                if dist <= range or k.alwaysOnScreen == true then
                    print(dist)
                    if dist >= 400.0 then
                        dist = 400.0
                    end
                    print(dist)
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, row, _heading, dist, range, 1, 10.0, 1)
                elseif k.range ~= nil and type(k.range) == 'number' and dist <= k.range then
                    if dist >= 400.0 then
                        dist = 400.0
                    end
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, row, _heading, dist, range, 1, 10.0, 1)
                else
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 23, row, -1, 0, 0, 1, 1.0, 1)
                end
                row = row + 1
            end
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