
day = {
	[1] = "Mon", [2] = "Tue", [3] = "Wed", [4] = "Thu", [5] = "Fri", [6] = "Sat", [7] = "Sun"
}

themes = {
    [0] = {name = "Blue", id = 1, wallpaper = "Phone_Wallpaper_ifruitdefault"},
    [1] = {name = "Green", id = 2, wallpaper = "Phone_Wallpaper_greenshards"},
    [2] = {name = "Red", id = 3, wallpaper = "Phone_Wallpaper_orangeherringbone"},
    [3] = {name = "Orange", id = 4, wallpaper = "Phone_Wallpaper_orangetriangles"},
    [4] = {name = "Gray", id = 5, wallpaper = "Phone_Wallpaper_diamonds"},
    [5] = {name = "Purple", id = 6, wallpaper = "Phone_Wallpaper_purpleglow"},
    [6] = {name = "Pink", id = 7, wallpaper = "Phone_Wallpaper_purpletartan"},
}

--view id 4 = call screen / 11 = numpad / 14 = better todo / 15 = todo 6= sms list / 8 = email list / 24 = weird text
function generateMainPhone(_apps, _selectID, _theme)
    local scaleform = Scaleform.Request('CELLPHONE_IFRUIT')

    Scaleform.CallFunction(scaleform, false, "SET_THEME", themes[_theme].id)
    Scaleform.CallFunction(scaleform, false, "SET_SLEEP_MODE", 0)
    showHomepage(scaleform, _apps, _selectID, _theme)

    return scaleform
end

function showHomepage(scaleform, apps, selectID, theme)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)

    SetPedConfigFlag(PlayerPedId(), 242, not true)
	SetPedConfigFlag(PlayerPedId(), 243, not true)
	SetPedConfigFlag(PlayerPedId(), 244, true)

    CellCamActivate(false, false)
	CellFrontCamActivate(false)

    Scaleform.CallFunction(scaleform, false, "SET_BACKGROUND_CREW_IMAGE", themes[theme].wallpaper)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 1)
    for i,k in pairs(apps) do
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 1, slotID, iconID, notification number, App Name, opacityFloat)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 1, i, k.icon, k.notif, k.name, 500.0)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 1, selectID)
end

AddEventHandler('scalePhone.HandleInput.homepage', function(input)
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
        TriggerEvent('scalePhone.OpenApp', apps[appOpen].buttons[selectID].appID, false)
    elseif input == 'back' then
        CellCamMoveFinger(5)
        ExecuteCommand('phone')
    end
    if input ~= 'select' and input ~= 'back' then
        local ret = Scaleform.CallFunction(phoneScaleform, true, "GET_CURRENT_SELECTION")
        while true do
            if IsScaleformMovieMethodReturnValueReady(ret) then
                selectID = GetScaleformMovieMethodReturnValueInt(ret) --output
                break
            end
            Citizen.Wait(0)
        end
    end
end)

--[[
APP icons:
1 = snapmatic,
2 = sms,
3 = blank / black
4 = email,
5 = contacts
6 = web,
11 = contacts with a plus
12 = jobs / todo?
14 = multiple people
24 = settings
27 = ! sign
]]