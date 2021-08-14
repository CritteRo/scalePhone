function openEmailsMenu(scaleform, emails, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 8)
    for i,k in pairs(emails) do
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, slotID, someIconID, 0, Title, Message)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, i, 1, 0, k.title, k.message)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 8, selectID)
end

