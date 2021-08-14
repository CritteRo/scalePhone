function openCustomMenu(scaleform, title, buttons, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 18)
    for i,k in pairs(buttons) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 18, i, 0, k.text)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 18, seletID)
end