function openEmailView(scaleform, title, from, to, message)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 9, 0, 1, "To: ~b~me~s~,", 'From: ~b~'..from..'~s~', "<c>"..title.."</c>", message)

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 9, 0)
end