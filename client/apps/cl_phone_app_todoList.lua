function openStatsMenu(scaleform, list, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Stats")
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 14)
    for i,k in pairs(list) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 14, i, k.procent, k.title, k.text)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 14, selectID)
end