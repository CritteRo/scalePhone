--[[  :: ESSENTIAL MENU EVENTS ::  ]]--

AddEventHandler('scalePhone.OpenApp', function(appID, isForced)
    if isPhoneActive or isForced ~= nil then
        if isForced == true and isPhoneActive == false then
            ExecuteCommand('phone')
            Citizen.Wait(1)
        end
        local id = nil
        --check if appID is valid
        for i,k in pairs(apps) do
            if k.appID == appID then
                id = i
                break
            end
        end

        --if we find it, run code, else throw tantrun in console.
        if id ~= nil then
            local app = apps[id]
            appSelectID = 0
            lastAppOpen = apps[appOpen].appID
            appOpen = id
            if app.type == 'homepage' then
                showHomepage(phoneScaleform, app.buttons, selectID, themeID)
            elseif app.type == 'contacts' then
                openContactsMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'callscreen' then
                openCallscreen(phoneScaleform, app.data.contact, app.data.pic, app.data.status)
            elseif app.type == 'emailList' then
                openEmailsMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'emailView' then
                openEmailView(phoneScaleform, tostring(app.data.title), tostring(app.data.from), tostring(app.data.to), tostring(app.data.message))
            elseif app.type == 'messagesList' then
                openMessagesMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'messageView' then
                openMessageView(phoneScaleform, tostring(app.data.contact), tostring(app.data.message), app.data.fromme, app.data.hasPic)
            elseif app.type == 'menu' then
                openCustomMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'todoList' then
                openStatsMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'todoView' then
                openTodoView(phoneScaleform)
            elseif app.type == 'numpad' then
                openNumpadMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'snapmatic' then
                openSnapmatic(phoneScaleform)
            elseif app.type == 'missionStatsView' then
                openMissionStatsView(phoneScaleform, app.name, app.buttons, appSelectID)
            else
                print("[[  ::  CAN'T FIND APP TYPE  ::  ]]")
            end
        else
            print("[[  ::  CAN'T FIND THE APP  ::  ]]")
        end
    end
end)

AddEventHandler('scalePhone.GoBackApp', function(data)
    print('am I here?')
    if appOpen ~= 0 then
        if data ~= nil and data.backApp ~= nil then
            TriggerEvent('scalePhone.OpenApp', data.backApp, false)
        else
            TriggerEvent('scalePhone.OpenApp', lastAppOpen, false)
        end
    else
        ExecuteCommand('phone')
    end
end)

AddEventHandler("scalePhone.NumpadAddNumber", function(data)
    local txt = ""
    if apps[appOpen].dataText ~= nil then
        txt = apps[appOpen].dataText
    end
    if isPhoneActive == true and apps[appOpen] ~= nil and apps[appOpen].type == 'numpad' then
        if data.add ~= nil then
            if data.add == 'res' then
                txt = ""
            elseif data.add == 'go' then
            else
                txt = txt..data.add
            end
            if data.forceText ~= nil then
                txt = tostring(data.forceText)
            end
            Scaleform.CallFunction(phoneScaleform, false, "SET_HEADER", txt)
            apps[appOpen].dataText = txt
            TriggerEvent('scalePhone.Event.GetNumpadNumber', txt)
        end
    end 
end)

AddEventHandler('scalePhone.GoToHomepage', function()
    TriggerEvent('scalePhone.OpenApp', 'scalePhone.InternalMenu.DontUse.Homepage', false)
end)

AddEventHandler('scalePhone.BuildMessageView', function(data, appID)
    if data.contact ~= nil and data.message ~= nil and data.isentthat ~= nil then
        local id = 1000
        if appID ~= nil then
            id = appID
        end
        apps[id].data = {contact = data.contact, message = data.message, fromme = data.isentthat}
        if data.hasPic ~= nil then
            apps[id].data.hasPic = tostring(data.hasPic)
        end
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "contact" = string, "isentthat" = bool')
    end
end)

AddEventHandler('scalePhone.BuildEmailView', function(data, appID)
    if data.title ~= nil and data.from ~= nil and data.to ~= nil and data.message ~= nil then
        local id = 1001
        if appID ~= nil then
            id = appID
        end
        apps[id].data = {title = data.title, message = data.message, to = data.to, from = data.from}
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "title" = string, "to" = string, "from" = string')
    end
end)

AddEventHandler('scalePhone.BuildCallscreenView', function(data, appID)
    if data.contact ~= nil and data.pic ~= nil and data.status ~= nil then
        apps[appID].data = {contact = data.contact, pic = data.pic, status = data.status}
    else
        print('[[  ::  scalePhone.BuildCallscreenView requires the following array variables: "contact" = string, "pic" = string, "status" = string')
    end
end)

AddEventHandler('scalePhone.BuildApp', function(appID, type, name, icon, notif, openEvent, backEvent, data) --this will be a "non-homepage app". Probably low level, just like 1000 and 1001
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('cant use that appID')
            break
        end
    end
    if allowed then
        local id = appID
        apps[appID] = {appID = appID,id = typeDetails[type].id, isLeftToRight = typeDetails[type].isLeftToRight, type = type, name = name, icon = icon, notif = notif, openEvent = openEvent, backEvent = backEvent, buttons = {}}
    end
end)

AddEventHandler('scalePhone.BuildHomepageApp', function(appID, type, name, icon, notif, openEvent, backEvent, data)
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('cant use that appID')
            break
        end
    end
    if allowed then
        local id = appID
        local placeHomepage = 0
        if apps[0].buttons[0] ~= nil then
            placeHomepage = #apps[0].buttons+1
        end
        for i,k in pairs(apps[0].buttons) do
            if id == k.appID then
                placeHomepage = i
                break
            end 
        end
        apps[0].buttons[placeHomepage] = {appID = appID,id = typeDetails[type].id, isLeftToRight = typeDetails[type].isLeftToRight, type = type, name = name, icon = icon, notif = notif, openEvent = openEvent, backEvent = backEvent}
        apps[appID] = {appID = appID,id = typeDetails[type].id, isLeftToRight = typeDetails[type].isLeftToRight, type = type, name = name, icon = icon, notif = notif, openEvent = openEvent, backEvent = backEvent, buttons = {}}
    end
end)

AddEventHandler('scalePhone.BuildSnapmatic', function(appID)
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('cant use that appID')
            break
        end
    end
    if allowed then
        local id = appID
        local placeHomepage = 0
        if apps[0].buttons[0] ~= nil then
            placeHomepage = #apps[0].buttons+1
        end
        for i,k in pairs(apps[0].buttons) do
            if id == k.appID then
                placeHomepage = i
                break
            end 
        end
        apps[0].buttons[placeHomepage] = {appID = appID,id = 0, isLeftToRight = false, type = "snapmatic", name = "Snapmatic", icon = 1, notif = 0, openEvent = "scalePhone.OpenSnapmatic", backEvent = "scalePhone.GoToHomepage"}
        apps[appID] = {appID = appID, id = 0, isLeftToRight = false, type = "snapmatic", name = "Snapmatic", icon = 1, notif = 0, openEvent = "scalePhone.OpenSnapmatic", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
            buttons = {
                [0] = {"blow_kiss"},
                [1] = {"dock"},
                [2] = {"jazz_hands"},
                [3] = {"the_bird"},
                [4] = {"thumbs_up"},
                [5] = {"wank"},
            }
        }
    end
end)

AddEventHandler('scalePhone.BuildThemeSettings', function(appID)
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('cant use that appID')
            break
        end
    end
    if allowed then
        local id = appID
        local placeHomepage = 0
        if apps[0].buttons[0] ~= nil then
            placeHomepage = #apps[0].buttons+1
        end
        for i,k in pairs(apps[0].buttons) do
            if id == k.appID then
                placeHomepage = i
                break
            end 
        end
        apps[0].buttons[placeHomepage] = {appID = appID,id = 18, isLeftToRight = false, type = "menu", name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage"}
        apps[appID] = {appID = appID,id = 18, isLeftToRight = false, type = "menu", name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
            buttons = {
                [0] = {text = "Blue", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 0}},
                [1] = {text = "Green", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 1}},
                [2] = {text = "Red", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 2}},
                [3] = {text = "Orange", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 3}},
                [4] = {text = "Gray", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 4}},
                [5] = {text = "Purple", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 5}},
                [6] = {text = "Pink", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 6}},
            }
        }
    end
end)

AddEventHandler('scalePhone.BuildAppButton', function(appID, buttonData, addOnTop, overrideExistingButton)
    if apps[appID] ~= nil then
        local placeButton = 0
        if addOnTop then
            local count = #apps[appID].buttons
            if apps[appID].buttons[0] ~= nil then
                for i=count,0,-1 do
                    apps[appID].buttons[i+1] = apps[appID].buttons[i]
                end
            end
            if overrideExistingButton ~= nil and overrideExistingButton > -1 then
                for i,k in pairs(apps[appID].buttons) do
                    if overrideExistingButton == i then
                        placeButton = i
                        break
                    end 
                end
            end
        else
            if apps[appID].buttons[0] ~= nil then
                placeButton = #apps[appID].buttons+1
            end
            if overrideExistingButton ~= nil and overrideExistingButton > -1 then
                for i,k in pairs(apps[appID].buttons) do
                    if overrideExistingButton == i then
                        placeButton = i
                        break
                    end 
                end
            end
        end
        apps[appID].buttons[placeButton] = buttonData
    else
        print('[  ::  CANT BUILD BUTTON : APP ID DOES NOT EXIST  ::  ]')
    end
end)

AddEventHandler('scalePhone.ResetAppButtons', function(appID)
    if apps[appID] ~= nil then
        apps[appID].buttons = {}
    end
end)

AddEventHandler('scalePhone.AddAppNotification', function(appID, customValue)
    if apps[appID] ~= nil then
        local homePlace = 0
        for i,k in pairs(apps[0].buttons) do
            if k.appID == appID then
                homePlace = i
                break
            end
        end
        if tonumber(customValue) ~= nil then
            apps[0].buttons[homePlace].notif = tonumber(customValue)
        else
            apps[0].buttons[homePlace].notif = apps[0].buttons[homePlace].notif + 1
        end
        
    end
end)
