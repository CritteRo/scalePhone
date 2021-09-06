local Playlists = {
    "PL_STD_CNT",
    "PL_STD_WZL",
    "PL_LO_CNT",
    "PL_LO_WZL",
    "PL_SP_WORKOUT",
    "PL_SP_INV",
    "PL_SP_INV_EXP",
    "PL_LO_RS",
    "PL_LO_RS_CUTSCENE",
    "PL_SP_PLSH1_INTRO",
    "PL_LES1_FAME_OR_SHAME",
    "PL_STD_WZL_FOS_EP2",
    "PL_MP_WEAZEL",
    "PL_CINEMA_ACTION",
    "PL_CINEMA_ARTHOUSE",
    "PL_CINEMA_MULTIPLAYER",
    "PL_WEB_HOWITZER",
    "PL_WEB_RANGERS"
}
local currentChannel = 1

function openTvApp(channel)
    local _channel = currentChannel
    if channel ~= nil then
        _channel = channel
    end
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    RegisterScriptWithAudio(0)
    SetTvChannel(-1)

    Citizen.InvokeNative(0x9DD5A62390C3B735, 2, Playlists[tonumber(_channel)], 0)
    currentChannel = tonumber(_channel)
    SetTvChannel(2)
    EnableMovieSubtitles(1)
end

AddEventHandler('scalePhone.HandleInput.tv', function(input)
    if input == "left" then
        CellCamMoveFinger(4)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 4)
        if currentChannel > 1 then
            openTvApp(currentChannel - 1)
        else
            openTvApp(#Playlists)
        end
    elseif input == 'right' then
        CellCamMoveFinger(3)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 2)
        if currentChannel < #Playlists then
            openTvApp(currentChannel + 1)
        else
            openTvApp(1)
        end
    elseif input == 'up' then
        --CellCamMoveFinger(1)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 1)
    elseif input == 'down' then
        --CellCamMoveFinger(2)
        --Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 3)
    elseif input == 'select' then
    elseif input == 'back' then
        CellCamMoveFinger(5)
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data)
    end
end)