function openMessageView(scaleform, contact, message, fromme)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Message")
    local var = "From: "
    if fromme == true then
        var = "To: "
    end
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 7, 0, var..contact, message, 'CHAR_BLANK_ENTRY')

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 7, 0)
end