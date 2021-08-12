isPhoneActive = false
phoneScaleform = 0
appOpen = -1
selectID = 0
appSelectID = 0
renderID = 0
themeID = 0

apps = {
    [0] = {id = 2, isLeftToRight = false, name = "Contacts", icon = 5, notif = 0, openEvent = "scalePhone.OpenContacts", backEvent = "scalePhone.Homepage"},
    [1] = {id = 6, isLeftToRight = false, name = "Messages", icon = 2, notif = 0, openEvent = "scalePhone.OpenMessages", backEvent = "scalePhone.Homepage"},
    [2] = {id = 8, isLeftToRight = false, name = "Emails", icon = 4, notif = 0, openEvent = "scalePhone.OpenEmails", backEvent = "scalePhone.Homepage"},
    [3] = {id = 0, isLeftToRight = false, name = "Snapmatic", icon = 1, notif = 0, openEvent = "scalePhone.OpenSnapmatic", backEvent = "scalePhone.Homepage"},
    [4] = {id = 18, isLeftToRight = false, name = "Jobs", icon = 12, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.Homepage"},
    [5] = {id = 18, isLeftToRight = false, name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.Homepage"},
}

buttons = {
    [0] = { --contacts
        --[0] = {name = "Contact", pic = 'CHAR_BLANK_ENTRY', isBot = false, event = ""},
        --[1] = {name = "Contact", pic = 'CHAR_BLANK_ENTRY', isBot = false, event = ""},
        --[2] = {name = "Contact", pic = 'CHAR_BLANK_ENTRY', isBot = false, event = ""},
    },
    [1] = { --messages
        --[0] = {contact = "Lili", h = 15, m = 10, message = "Nelu tea rugat iulia sa idai si ei osuta dojda mi sa sia tigari si maine ti da", event = "scalePhone.ShowMessage", isentthat = false},
        --[1] = {contact = "Dan Nistor", h = 17, m = 5, message = "Salut eu am vb k u iar u incepi sa dai prin ziare si prin astea ce am vb k tine nu i frumos ce ai facut sincer", event = "scalePhone.ShowMessage", isentthat = true},
    },
    [2] = { --emails
        --[0] = {title = "Update 1", to = "fivem.net", from = "homies.net", message = "Boiiiii\nBoiiiii\nBoiiiii\nBoiiiii\nBoiiiii\nBoiiiii\n"},
    },
    [3] = {
        [0] = {selfieOn = false},
        [1] = {selfieOn = true},
    },
    [4] = { --jobs menu
        [0] = {text = "Item 1", event = "core.alert", eventParams = {type = "simple", text = "test1"}},
        [1] = {text = "Item 2", event = "core.alert", eventParams = {type = "simple", text = "test2"}},
        [2] = {text = "Item 3", event = "core.alert", eventParams = {type = "simple", text = "test3"}},
        [3] = {text = "Item 4", event = "core.alert", eventParams = {type = "simple", text = "test54"}},
        [4] = {text = "Item 5", event = "core.alert", eventParams = {type = "simple", text = "test5"}},
        [5] = {text = "Item 6", event = "core.alert", eventParams = {type = "simple", text = "test6"}},
    },
    [5] = { --themes menu
        [0] = {text = "Blue", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 0}},
        [1] = {text = "Green", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 1}},
        [2] = {text = "Red", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 2}},
        [3] = {text = "Orange", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 3}},
        [4] = {text = "Gray", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 4}},
        [5] = {text = "Purple", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 5}},
        [6] = {text = "Pink", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 6}},
    }
}


RegisterCommand('phone', function()
    if isPhoneActive == false then
        CreateMobilePhone(0)
        renderID = GetMobilePhoneRenderId() --render id for both the phone AND the frontend render.
        SetMobilePhonePosition(45.0,-23.0,-60.0)
        SetMobilePhoneRotation(-90.0,0.0,0.0) --last one is important
        SetPhoneLean(false) --flips the phone in hand
        SetMobilePhoneScale(250.0)
        appOpen = -1
        selectID = 0
        phoneScaleform = generateMainPhone(apps, selectID, themeID)
        isPhoneActive = true
        SetPedConfigFlag(PlayerPedId(), 242, not true)
		SetPedConfigFlag(PlayerPedId(), 243, not true)
		SetPedConfigFlag(PlayerPedId(), 244, true)
		N_0x83a169eabcdb10a2(PlayerPedId(), 0)
        PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    elseif isPhoneActive == true then
        DestroyMobilePhone()
        isPhoneActive = false
        PlaySoundFrontend(-1, "Put_Away", "Phone_SoundSet_Michael", 1)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isPhoneActive then
            SetTextRenderId(renderID)
            Scaleform.CallFunction(phoneScaleform, false, "SET_TITLEBAR_TIME", GetClockHours(), GetClockMinutes(), day[GetClockDayOfWeek()])
            if GetFollowPedCamViewMode() == 4 then
				SetMobilePhoneScale(0.0)
			else
				SetMobilePhoneScale(250.0)
			end
            DrawScaleformMovie(phoneScaleform, 0.1, 0.18, 0.2, 0.35, 255, 255, 255, 255, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())

            if appOpen == 3 then
                HideHudComponentThisFrame(7)
                HideHudComponentThisFrame(8)
                HideHudComponentThisFrame(9)
                HideHudComponentThisFrame(6)
                HideHudComponentThisFrame(19)
                HideHudAndRadarThisFrame()
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterCommand('phoneleft', function()
    if isPhoneActive then
        if appOpen > -2 then
            if appOpen == -1 then
                if selectID < #apps then
                    selectID = selectID + 1
                    CellCamMoveFinger(4)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
                else
                    selectID = 0
                    CellCamMoveFinger(4)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
                end
            elseif appOpen == 3 then
                if appSelectID == 0 then
                    appSelectID = 1
                else
                    appSelectID = 0
                end
                CellCamMoveFinger(4)
                CellFrontCamActivate(buttons[appOpen][appSelectID].selfieOn)
            end
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        end
    end
end)
RegisterKeyMapping('phoneleft', "Phone Swipe Left", 'keyboard', 'LEFT')

RegisterCommand('phoneright', function()
    if isPhoneActive then
        if appOpen > -2 then
            if appOpen == -1 then
                if selectID > 0 then
                    selectID = selectID - 1
                    CellCamMoveFinger(3)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
                else
                    selectID = #apps
                    CellCamMoveFinger(3)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
                end
            elseif appOpen == 3 then
                if appSelectID == 0 then
                    appSelectID = 1
                else
                    appSelectID = 0
                end
                CellCamMoveFinger(3)
                CellFrontCamActivate(buttons[appOpen][appSelectID].selfieOn)
            end
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        end
    end
end)
RegisterKeyMapping('phoneright', "Phone Swipe Right", 'keyboard', 'RIGHT')

RegisterCommand('phoneup', function()
    if isPhoneActive then
        if appOpen > -2 then
            if appOpen == -1 then
                selectID = selectID - 3
                if selectID < 0 then
                    selectID = selectID + #apps + 1
                end
                CellCamMoveFinger(1)
                Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
            else
                if apps[appOpen].isLeftToRight == false then
                    if appSelectID > 0 then
                        appSelectID = appSelectID - 1
                    else
                        appSelectID = #buttons[appOpen]
                    end
                    CellCamMoveFinger(1)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", apps[appOpen].id, appSelectID)
                end
            end
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        else
            Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 1)
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        end
    else
        ExecuteCommand('phone')
    end
end)
RegisterKeyMapping('phoneup', "Phone Swipe Up / Open Phone", 'keyboard', 'UP')

RegisterCommand('phonedown', function()
    if isPhoneActive then
        if appOpen > -2 then
            if appOpen == -1 then
                selectID = selectID + 3
                if selectID > #apps then
                    selectID = selectID - #apps -1
                end
                CellCamMoveFinger(2)
                Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", 1, selectID)
            elseif appOpen == 2 then
                
            else
                if apps[appOpen].isLeftToRight == false then
                    if appSelectID < #buttons[appOpen] then
                        appSelectID = appSelectID + 1
                    else
                        appSelectID = 0
                    end
                    CellCamMoveFinger(2)
                    Scaleform.CallFunction(phoneScaleform, false, "DISPLAY_VIEW", apps[appOpen].id, appSelectID)
                end
            end
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        else
            Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 3)
            PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
        end
    end
end)
RegisterKeyMapping('phonedown', "Phone Swipe Down", 'keyboard', 'DOWN')

RegisterCommand('phoneselect', function()
    if isPhoneActive then
        if appOpen == -1 then
            if apps[selectID] ~= nil then
                if apps[selectID].openEvent == "scalePhone.OpenMessages" then
                    appOpen = selectID
                    appSelectID = 0
                    CellCamMoveFinger(5)
                    openMessagesMenu(phoneScaleform, buttons[appOpen], appSelectID)
                elseif apps[selectID].openEvent == "scalePhone.OpenContacts" then
                    appOpen = selectID
                    appSelectID = 0
                    CellCamMoveFinger(5)
                    openContactsMenu(phoneScaleform, buttons[appOpen], appSelectID)
                elseif apps[selectID].openEvent == "scalePhone.OpenEmails" then
                    appOpen = selectID
                    appSelectID = 0
                    CellCamMoveFinger(5)
                    openEmailsMenu(phoneScaleform, buttons[appOpen], appSelectID)
                elseif apps[selectID].openEvent == "scalePhone.OpenSnapmatic" then
                    appOpen = selectID
                    appSelectID = 0
                    CellCamMoveFinger(5)
                    openSnapmatic(phoneScaleform)
                elseif apps[selectID].openEvent == "scalePhone.OpenCustomMenu" then
                    appOpen = selectID
                    appSelectID = 0
                    CellCamMoveFinger(5)
                    openCustomMenu(phoneScaleform, apps[selectID].name, buttons[appOpen], appSelectID)
                end
            end
        elseif appOpen == 1 then
            CellCamMoveFinger(5)
            openMessageViewer(phoneScaleform, buttons[appOpen][appSelectID].contact, buttons[appOpen][appSelectID].message, buttons[appOpen][appSelectID].isentthat)
            appOpen = -3
        elseif appOpen == 2 then
            CellCamMoveFinger(5)
            openEmailViewer(phoneScaleform, buttons[appOpen][appSelectID].title, buttons[appOpen][appSelectID].from, buttons[appOpen][appSelectID].to, buttons[appOpen][appSelectID].message)
            appOpen = -2
        elseif appOpen == 3 then
            TakePhoto()
            if (WasPhotoTaken() and SavePhoto(-1)) then
                ClearPhoto()
            end
        else
            if appOpen ~= -2 and appOpen ~= -3 then
                TriggerEvent(buttons[appOpen][appSelectID].event, buttons[appOpen][appSelectID].eventParams)
            end
        end
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneselect', "Phone Select", 'keyboard', 'RETURN')

RegisterCommand('phoneback', function()
    if isPhoneActive then
        if appOpen ~= -1 then
            if apps[appOpen] ~= nil then
                if apps[appOpen].backEvent == "scalePhone.Homepage" then
                    appOpen = -1
                    CellCamMoveFinger(5)
                    showHomepage(phoneScaleform, apps, selectID, themeID)
                end
            elseif appOpen == -2 then
                appOpen = 2
                CellCamMoveFinger(5)
                openEmailsMenu(phoneScaleform, buttons[appOpen], appSelectID)
            elseif appOpen == -3 then
                appOpen = 1
                CellCamMoveFinger(5)
                openMessagesMenu(phoneScaleform, buttons[appOpen], appSelectID)
            end
            PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", 1)
        else
            ExecuteCommand('phone')
        end
    end
end)
RegisterKeyMapping('phoneback', "Phone Back", 'keyboard', 'BACK')