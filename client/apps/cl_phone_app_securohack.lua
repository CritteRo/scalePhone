local lastRunId = nil
local _stage = 0 --(0 = no signal, 1 = hacking, 2 = complete, 3 = custom message or HACK IN PROGRESS, 4 = custome message or WEAK SIGNAL)

function openSecuroHackView(scaleform, title, buttons, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)

    math.randomseed(GetGameTimer())
    local newId = math.random(100000,999999)
    --while newId == lastRunId do
        newId = math.random(100000,999999)
    --end

    lastRunId = newId
    local app = appOpen
    local appSession = 0
    local _startMsg = "START HACKING_"

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, false, 9)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)

    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, 5,0)
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 27, 0)
    
    Citizen.CreateThread(function()
        while app == appOpen and isPhoneActive == true do
            if lastRunId ~= nil and newId ~= lastRunId then
                break
            end
            Wait(1000)
            local pedPos = GetEntityCoords(PlayerPedId())
            _stage = 0 --NO SIGNAL, at first
            Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0)
            for i,k in pairs(buttons) do
                dist = #(k.coords - pedPos)
                if dist <= k.weakSignalDist then
                    _stage = 4
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0)
                    if k.weakSignalMessage ~= nil then
                        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0, tostring(k.weakSignalMessage))
                    end
                end
                if dist <= k.strongSignalDist then
                    _stage = 3
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0, _startMsg)
                    if k.strongSignalMessage ~= nil then
                        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0, tostring(k.strongSignalMessage))
                    end
                end
            end
            if app == appOpen and isPhoneActive == true then
                Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 27, 0)
            end
        end
    end)
end

AddEventHandler('scalePhone.HandleInput.securoHack', function(input)
    if input == "left" then
        CellCamMoveFinger(4)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 4)
    elseif input == 'right' then
        CellCamMoveFinger(3)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 2)
    elseif input == 'up' then
        CellCamMoveFinger(1)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 1)
    elseif input == 'down' then
        CellCamMoveFinger(2)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 3)
    elseif input == 'select' then
        if _stage ~= 1 then
            CellCamMoveFinger(5)
            local pedPos = GetEntityCoords(PlayerPedId())
            for i,k in pairs(apps[appOpen].buttons) do
                local dist = #(k.coords - pedPos)
                if dist <= k.strongSignalDist then
                    _stage = 1
                    local time = k.timeNeeded * 10
                    local progress = 0
                    while progress <= 100 do
                        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0, tostring(k.weakSignalMessage))
                        Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 27, 0)
                        Wait(time)
                    end
                    _stage = 2
                    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 27, 0, _stage,0)
                    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 27, 0)
                    TriggerEvent(k.event, k.eventParams)
                end
            end
        end
    elseif input == 'back' then
        if _stage ~= 1 then
            CellCamMoveFinger(5)
            lastRunId = nil
            TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data)
        end
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