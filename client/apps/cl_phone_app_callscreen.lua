function openCallscreen(scaleform,contactName, contactPic, callStatus, canAnswer)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    local minutes = 00
    local seconds = 00
    local wait = minutes..":"..seconds

    local name = 'unk'
    local pic = ''
    local status = 'unk'
    local answer = false
    if contactName ~= nil then
        name = contactName
    end
    if contactPic ~= nil then
        pic = contactPic
    end
    if callStatus ~= nil then
        status = callStatus
    end
    if canAnswer ~= nil then
        answer = canAnswer
    end

    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Call")
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 4, 0, 0, name,pic,callStatus.."\n"..wait)

    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, answer, 5)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 6)

    Citizen.CreateThread(function()
        local app = appOpen
        while app == appOpen do
            seconds = seconds + 1
            if seconds == 60 then
                seconds = 0
                minutes = minutes + 1
            end
            wait = ""
            if minutes < 10 then
                wait = "0"..minutes..":"
            else
                wait = minutes..":"
            end
            if seconds < 10 then
                wait = wait.."0"..seconds
            else
                wait = wait..seconds
            end
            Scaleform.CallFunction(phoneScaleform, false, "SET_DATA_SLOT", 4, 0, 0, contactName,contactPic,callStatus.."\n"..wait)
            Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 4, 0)
            Wait(1000)
        end
    end)
end

AddEventHandler('scalePhone.HandleInput.callscreen', function(input)
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
        if apps[appOpen].data.canAnswer ~= nil and apps[appOpen].data.canAnswer == true and apps[appOpen].data.selectEvent ~= nil then
            CellCamMoveFinger(5)
            TriggerEvent(apps[appOpen].data.selectEvent, apps[appOpen].data)
            print('test')
            PlaySoundFrontend(-1, "Hang_Up", "Phone_SoundSet_Michael", 1)
        end
    elseif input == 'back' then
        StopPedRingtone(PlayerPedId())
        CellCamMoveFinger(5)
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data)
        PlaySoundFrontend(-1, "Hang_Up", "Phone_SoundSet_Michael", 1)
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