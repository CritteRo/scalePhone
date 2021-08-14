isPhoneActive = false
phoneScaleform = 0
cameraScaleform = 0
appOpen = 0
appOpenIsNonHome = false
lastAppOpen = 0
selectID = 0
appSelectID = 0
renderID = 0
themeID = 0

RequestStreamedTextureDict("shopui_title_casino")

apps = {
    --[[ HOMEPAGE ]]--
    [0] = {appID = 'scalePhone.InternalMenu.DontUse.Homepage', 1, type = 'homepage', name = 'Home', icon = 0, notif = 0, openEvent = 'scalePhone.GoBackApp', backEvent = 'scalePhone.ClosePhone', data = {},
        buttons = {
            [0] = {appID = 1, id = 2, isLeftToRight = false, type = "contacts", name = "Contacts", icon = 5, notif = 0, openEvent = "scalePhone.OpenContacts", backEvent = "scalePhone.GoToHomepage"},
            [1] = {appID = 2,id = 6, isLeftToRight = false, type = "messagesList", name = "Messages", icon = 2, notif = 0, openEvent = "scalePhone.OpenMessages", backEvent = "scalePhone.GoToHomepage"},
            [2] = {appID = 3,id = 8, isLeftToRight = false, type = "emailList", name = "Emails", icon = 4, notif = 0, openEvent = "scalePhone.OpenEmails", backEvent = "scalePhone.GoToHomepage"},
            [3] = {appID = 4,id = 0, isLeftToRight = false, type = "snapmatic", name = "Snapmatic", icon = 1, notif = 0, openEvent = "scalePhone.OpenSnapmatic", backEvent = "scalePhone.GoToHomepage"},
            [4] = {appID = 5,id = 14, isLeftToRight = false, type = "todoList", name = "Stats", icon = 12, notif = 0, openEvent = "scalePhone.OpenStatsMenu", backEvent = "scalePhone.GoToHomepage"},
            [5] = {appID = 6,id = 18, isLeftToRight = false, type = "menu", name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage"},
        },
    },
    --[[ ESSENTIAL APPS ]]--
    [1000] = {appID = 1000, id = 7, isLeftToRight = false, type = "messageView", name = "Message", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {contact = "Contact", message = 'unk', fromme = false, backApp = 0},
    buttons = {
        }
    },
    [1001] = {appID = 1001, id = 9, isLeftToRight = false, type = "emailView", name = "Email", icon = 0, notif = 0, openEvent = "", backEvent = "scalePhone.GoBackApp", data = {title = "Email", message = 'unk', from = "", to = "", backApp = 0},
    buttons = {
        }
    },
    --[[ CUSTOM APPS ]]--
    [1] = {appID = 1, id = 2, isLeftToRight = false, type = "contacts", name = "Contacts", icon = 5, notif = 0, openEvent = "scalePhone.OpenContacts", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
    buttons = {
            --[0] = {name = "Contact", pic = 'CHAR_BLANK_ENTRY', isBot = false, event = ""},
        }
    },
    [2] = {appID = 2,id = 6, isLeftToRight = false, type = "messagesList", name = "Messages", icon = 2, notif = 0, openEvent = "scalePhone.OpenMessages", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
    buttons = {
            [0] = {contact = "Lili", h = 15, m = 10, message = "Nelu tea rugat iulia sa idai si ei osuta dojda mi sa sia tigari si maine ti da", event = "scalePhone.ShowMessage", isentthat = false},
        }
    },
    [3] = {appID = 3,id = 8, isLeftToRight = false, type = "emailList", name = "Emails", icon = 4, notif = 0, openEvent = "scalePhone.OpenEmails", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
    buttons = {
            --[0] = {title = "Update 1", to = "fivem.net", from = "homies.net", message = "<img src='img://shopui_title_casino/shopui_title_casino' height='80' width='320'/>"},
        }
    },
    [4] = {appID = 4,id = 0, isLeftToRight = false, type = "snapmatic", name = "Snapmatic", icon = 1, notif = 0, openEvent = "scalePhone.OpenSnapmatic", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
        buttons = {
            [0] = {selfieOn = false},
            [1] = {selfieOn = true},
        }
    },
    [5] = {appID = 5,id = 14, isLeftToRight = false, type = "todoList", name = "Stats", icon = 12, notif = 0, openEvent = "scalePhone.OpenStatsMenu", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
        [0] = {title = "UID", text = "14", procent = 0},
        [1] = {title = "Rank", text = "4", procent = 0},
        [2] = {title = "Level", text = "100", procent = 0},
        [3] = {title = "Job", text = "Hitman", procent = 0},
        [4] = {title = "Faction", text = "FIB", procent = 0},
        [5] = {title = "Heist Points", text = "52", procent = 0},
    },
    [6] = {appID = 6,id = 18, isLeftToRight = false, type = "menu", name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
        [0] = {text = "Blue", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 0}},
        [1] = {text = "Green", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 1}},
        [2] = {text = "Red", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 2}},
        [3] = {text = "Orange", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 3}},
        [4] = {text = "Gray", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 4}},
        [5] = {text = "Purple", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 5}},
        [6] = {text = "Pink", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 6}},
    },
}

buttons = {
    [0] = { --contacts
        --[0] = {name = "Contact", pic = 'CHAR_BLANK_ENTRY', isBot = false, event = ""},
    },
    [1] = { --messages
        --[0] = {contact = "Lili", h = 15, m = 10, message = "Nelu tea rugat iulia sa idai si ei osuta dojda mi sa sia tigari si maine ti da", event = "scalePhone.ShowMessage", isentthat = false},
    },
    [2] = { --emails
        --[0] = {title = "Update 1", to = "fivem.net", from = "homies.net", message = "<img src='img://shopui_title_casino/shopui_title_casino' height='80' width='320'/>"},
    },
    [3] = {
        [0] = {selfieOn = false},
        [1] = {selfieOn = true},
    },
    [4] = { --stats menu
        [0] = {title = "UID", text = "14", procent = 0},
        [1] = {title = "Rank", text = "4", procent = 0},
        [2] = {title = "Level", text = "100", procent = 0},
        [3] = {title = "Job", text = "Hitman", procent = 0},
        [4] = {title = "Faction", text = "FIB", procent = 0},
        [5] = {title = "Heist Points", text = "52", procent = 0},
    },
    [5] = { --themes menu
        [0] = {text = "Blue", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 0}},
        [1] = {text = "Green", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 1}},
        [2] = {text = "Red", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 2}},
        [3] = {text = "Orange", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 3}},
        [4] = {text = "Gray", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 4}},
        [5] = {text = "Purple", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 5}},
        [6] = {text = "Pink", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 6}},
    },
    --[[ CUSTOM APPS]]--
    [6] = { --LSLD Jobs selector
        [0] = {text = "Unemployed", event = "phoneJobs.ChangeJob", eventParams = {jobid = 0}}, 
        [1] = {text = "Trucker", event = "phoneJobs.ChangeJob", eventParams = {jobid = 1}},
        [2] = {text = "Farmer", event = "phoneJobs.ChangeJob", eventParams = {jobid = 2}},
        [3] = {text = "Fisherman", event = "phoneJobs.ChangeJob", eventParams = {jobid = 3}},
        [4] = {text = "Pilot", event = "phoneJobs.ChangeJob", eventParams = {jobid = 4}},
        [5] = {text = "Hitman", event = "phoneJobs.ChangeJob", eventParams = {jobid = 5}},
    },
    [7] = { --LSLD Rules & Info
        [0] = {title = "General Rules", to = "You", from = "admins@critte.ro", message = "\n1.Don't be rude.\n2.Don't cheat?\n3.Don't be weird.\n4.Refer to point 1."},
        [1] = {title = "Jobs", to = "You", from = "admins@critte.ro", message = "\nJobs are the main way to make money on this server. You can choose between multiple types of activities, like Truker, Farmer or Hitman. Finishing a job will grant you cash, XP and 1 job point.\n\nJob points can be either traded for XP, or kept for bonus cash & XP for that job."},
        [2] = {title = "Businesses", to = "You", from = "admins@critte.ro", message = "\nExpect banks and rents, every business on the server is player-owned.\n\nWhen a business is owned by the a player, the owner can change the name and description of that business.\n\nThe owner can add funds, retrieve business sales and restock the business.\n\nIf a business is left unstocked, the owner will lose the biz."},
        [3] = {title = "Timetrials", to = "You", from = "admins@critte.ro", message = "\nTimetrials are timed, single-player races that will grant you cash & XP upon completion.\n\nEvery track has it's on leaderboard that will show the top 10 fastest players"},
    },
    [8] = { --numpad
        [0] = {text = 1, event = "scalePhone.NumpadAddNumber", eventParams = {add = 1}},
        [1] = {text = 2, event = "scalePhone.NumpadAddNumber", eventParams = {add = 2}},
        [2] = {text = 3, event = "scalePhone.NumpadAddNumber", eventParams = {add = 3}},
        [3] = {text = 4, event = "scalePhone.NumpadAddNumber", eventParams = {add = 4}},
        [4] = {text = 5, event = "scalePhone.NumpadAddNumber", eventParams = {add = 5}},
        [5] = {text = 6, event = "scalePhone.NumpadAddNumber", eventParams = {add = 6}},
        [6] = {text = 7, event = "scalePhone.NumpadAddNumber", eventParams = {add = 7}},
        [7] = {text = 8, event = "scalePhone.NumpadAddNumber", eventParams = {add = 8}},
        [8] = {text = 9, event = "scalePhone.NumpadAddNumber", eventParams = {add = 9}},
        [9] = {text = "DEL", event = "scalePhone.NumpadAddNumber", eventParams = {add = 'del'}},
        [10] = {text = 0, event = "scalePhone.NumpadAddNumber", eventParams = {add = 0}},
        [11] = {text = "CAN", event = "scalePhone.NumpadAddNumber", eventParams = {add = 'can'}},
    },
}


RegisterCommand('phone', function()
    if isPhoneActive == false then
        CreateMobilePhone(0)
        renderID = GetMobilePhoneRenderId() --render id for both the phone AND the frontend render.
        SetMobilePhonePosition(45.0,-23.0,-60.0)
        SetMobilePhoneRotation(-90.0,0.0,0.0) --last one is important
        SetPhoneLean(false) --flips the phone in hand
        SetMobilePhoneScale(300.0)
        appOpen = 0
        selectID = 0
        phoneScaleform = generateMainPhone(apps[appOpen].buttons, selectID, themeID)
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
RegisterKeyMapping('phone', "Open Phone", 'keyboard', 'm')

Citizen.CreateThread(function()
    while true do
        if isPhoneActive then
            local coords = GetEntityCoords(PlayerPedId())
            SetTextRenderId(renderID)
            Scaleform.CallFunction(phoneScaleform, false, "SET_TITLEBAR_TIME", GetClockHours(), GetClockMinutes(), day[GetClockDayOfWeek()])
            Scaleform.CallFunction(phoneScaleform, false, "SET_SIGNAL_STRENGTH", GetZoneScumminess(GetZoneAtCoords(coords.x, coords.y, coords.z)))
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

                DrawScaleformMovieFullscreen(cameraScaleform, 255, 255, 255, 255)
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterCommand('phoneleft', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'left')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneleft', "Phone Swipe Left", 'keyboard', 'LEFT')

RegisterCommand('phoneright', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'right')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneright', "Phone Swipe Right", 'keyboard', 'RIGHT')

RegisterCommand('phoneup', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'up')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneup', "Phone Swipe Up", 'keyboard', 'UP')

RegisterCommand('phonedown', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'down')
        PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phonedown', "Phone Swipe Down", 'keyboard', 'DOWN')

RegisterCommand('phoneselect', function()
    if isPhoneActive then
        TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'select')
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", 1)
    end
end)
RegisterKeyMapping('phoneselect', "Phone Select", 'keyboard', 'RETURN')

RegisterCommand('phoneback', function()
    if isPhoneActive then
        if appOpen ~= 0 then
            TriggerEvent('scalePhone.HandleInput.'..apps[appOpen].type, 'back')
            PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", 1)
        else
            TriggerEvent('scalePhone.HandleInput.homepage', 'back')
        end
    end
end)
RegisterKeyMapping('phoneback', "Phone Back", 'keyboard', 'BACK')