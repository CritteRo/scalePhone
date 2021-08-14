function openMessagesMenu(scaleform, messages, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 6)
    for i,k in pairs(messages) do
        local var = ""
        if k.isentthat == true then
            var = "To: "
        end
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 6, slotID, Hour, Minute, Player Name, Message)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 6, i, k.h, k.m, var..k.contact, k.message)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 6, selectID)
end