AddEventHandler("scalePhone.ChangePhoneTheme", function(_data)
    if _data.themeID ~= nil then
        themeID = _data.themeID
        if isPhoneActive then
            phoneScaleform = generateMainPhone(apps[0].buttons, selectID, themeID)
            appOpen = 0
        end
    end
end)

AddTextEntry('MS_PROMPT_SMS', "Send message:")
function openMessagePrompt(name)
    Citizen.CreateThread(function()
        DisplayOnscreenKeyboard(1, "MS_PROMPT_SMS", "", "", "", "", 150)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            TriggerServerEvent('sendPhone.SendSMS', name, result)
            TriggerEvent('scalePhone.Event.ReceiveMessage', {contact = name, message = result}, true)
        end
        AddTextEntry('MS_PROMPT_SMS', "Send message: ")
    end)
end

blacklistID = {
    1000, 1001, 'scalePhone.InternalMenu.DontUse.Homepage'
}

typeDetails = {
    ['homepage'] = {id = 1, isLeftToRight = true},
    ['contacts'] = {id = 2, isLeftToRight = false},
    ['messagesList'] = {id = 6, isLeftToRight = false},
    ['messageView'] = {id = 7, isLeftToRight = false},
    ['emailList'] = {id = 8, isLeftToRight = false},
    ['emailView'] = {id = 9, isLeftToRight = false},
    ['menu'] = {id = 18, isLeftToRight = false},
    ['snapmatic'] = {id = 16, isLeftToRight = true},
    ['todoList'] = {id = 14, isLeftToRight = false},
    ['numpad'] = {id = 11, isLeftToRight = true},
}