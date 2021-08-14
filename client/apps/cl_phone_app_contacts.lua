function openContactsMenu(scaleform, contacts, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 2)
    for i,k in pairs(contacts) do
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 2, slotID, unk, Contact Name, unk, Contact Mugshot)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 2, i, 0, k.name, "", k.pic)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 2, selectID)
end