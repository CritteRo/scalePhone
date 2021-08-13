AddEventHandler("scalePhone.ChangePhoneTheme", function(_data)
    if _data.themeID ~= nil then
        themeID = _data.themeID
        if isPhoneActive then
            phoneScaleform = generateMainPhone(apps, selectID, themeID)
            appOpen = -1
        end
    end
end)

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

function runHomepageApp(_event, selectID)
    if _event == "scalePhone.OpenMessages" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openMessagesMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenContacts" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openContactsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenEmails" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openEmailsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenStatsMenu" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openStatsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenSnapmatic" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openSnapmatic(phoneScaleform)
    elseif _event == "scalePhone.OpenCustomMenu" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openCustomMenu(phoneScaleform, apps[selectID].name, buttons[appOpen], appSelectID)
    end
end

function openMessagePrompt(name)
    Citizen.CreateThread(function()
        DisplayOnscreenKeyboard(1, "CELL_EMAIL_BOD", "", "Message "..name, "", "", "", 100)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            TriggerServerEvent('sendPhone.SendSMS', name, result)
            TriggerEvent('scalePhone.Event.ReceiveMessage', {contact = name, message = result}, true)
        end
    end)
end