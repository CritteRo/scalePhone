--[[  :: ESSENTIAL MENU EVENTS ::  ]]--

AddEventHandler('scalePhone.OpenApp', function(appID, isForced)
    if isPhoneActive or isForced ~= nil then
        if isForced == true and isPhoneActive == false then
            ExecuteCommand('phone')
            Citizen.Wait(100) --this is still retarded, btw. Here, I need to wait for the scaleform to load, so I can then push the new app. This wait is arbitrary, and I basically hope that the scaleform will be ready in under 100ms.
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
                openCallscreen(phoneScaleform, app.data.contact, app.data.pic, app.data.status, app.data.canAnswer)
            elseif app.type == 'emailList' then
                openEmailsMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'emailView' then
                openEmailView(phoneScaleform, tostring(app.data.title), tostring(app.data.from), tostring(app.data.to), tostring(app.data.message), app.data.canOpenMenu)
            elseif app.type == 'messagesList' then
                openMessagesMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'messageView' then
                openMessageView(phoneScaleform, tostring(app.data.contact), tostring(app.data.message), app.data.fromme, app.data.hasPic, app.data.canOpenMenu)
            elseif app.type == 'menu' then
                openCustomMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'settings' then
                openSettingsList(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'todoList' then
                openStatsMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'todoView' then
                openTodoView(phoneScaleform, app.name, app.data.title, app.data.line1, app.data.line2, app.data.footer)
            elseif app.type == 'numpad' then
                openNumpadMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'snapmatic' then
                openSnapmatic(phoneScaleform)
            elseif app.type == 'missionStatsView' then
                openMissionStatsView(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'gps' then
                openGPSView(phoneScaleform, app.name)
            elseif app.type == 'trackifyView' then
                openTrackifyView(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'securoHack' then
                openSecuroHackView(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'tv' then
                openTvApp()
            else
                print("[[  ::  ERROR IN scalePhone.OpenApp  ::  CAN'T FIND APP TYPE  ::  ]]")
            end
        else
            print("[[  ::  ERROR IN scalePhone.OpenApp  ::  CAN'T FIND THE APP ID  ::  ]]")
        end
    end
end)

AddEventHandler('scalePhone.GoBackApp', function(data)
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

AddEventHandler('scalePhone.ClosePhone', function()
    if not WasEventCanceled() then
        if isPhoneActive then
            PlaySoundFrontend(-1, "Put_Away", "Phone_SoundSet_Michael", 1)
            isPhoneActive = false
            local tempy = phonePos.y
            while tempy >= -40.0 do
                tempy = tempy - 1.5
                SetMobilePhonePosition(phonePos.x, tempy, phonePos.z)
                Citizen.Wait(0)
            end
            DestroyMobilePhone()
        end
    end
end)

AddEventHandler('scalePhone.OpenPhone', function()
    if not WasEventCanceled() then
        if isPhoneActive == false and canPhoneBeOpened == true then
            CreateMobilePhone(0)
            renderID = GetMobilePhoneRenderId() --render id for both the phone AND the frontend render.
            local tempy = -40.0
            SetMobilePhonePosition(phonePos.x, tempy, phonePos.z)
            PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
            SetMobilePhoneRotation(-90.0,0.0,0.0) --last one is important
            SetPhoneLean(false) --flips the phone in hand
            SetMobilePhoneScale(tonumber(phoneScale) + 0.0)
            appOpen = 0
            selectID = 0
            phoneScaleform = generateMainPhone(apps[appOpen].buttons, selectID, themeID)
            isPhoneActive = true
            SetPedConfigFlag(PlayerPedId(), 242, not true)
            SetPedConfigFlag(PlayerPedId(), 243, not true)
            SetPedConfigFlag(PlayerPedId(), 244, true)
            N_0x83a169eabcdb10a2(PlayerPedId(), phoneCaseID) --phone case color. 0=blue, 1=green, 2=red, 3=orange, 4=gray, 5=purple, 6=pink, 7 or more = dark-gray?
            while tempy <= phonePos.y do
                tempy = tempy + 1.5
                SetMobilePhonePosition(phonePos.x, tempy, phonePos.z)
                Citizen.Wait(0)
            end
            SetMobilePhonePosition(phonePos.x, phonePos.y, phonePos.z)
        end
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
    if not WasEventCanceled() then
        TriggerEvent('scalePhone.OpenApp', 'scalePhone.InternalMenu.DontUse.Homepage', false)
    end
end)

AddEventHandler('scalePhone.BuildMessageView', function(data, appID)
    if data.contact ~= nil and data.message ~= nil and data.isentthat ~= nil and data.canOpenMenu ~= nil and data.selectEvent ~= nil then
        local id = 1000
        if appID ~= nil then
            id = appID
        end
        apps[id].data = data
        apps[id].data.contact = data.contact
        apps[id].data.message = data.message
        apps[id].data.fromme = data.isentthat
        apps[id].data.canOpenMenu = data.canOpenMenu
        if data.hasPic ~= nil then
            apps[id].data.hasPic = tostring(data.hasPic)
        end
        if data.canOpenMenu == true then
            apps[id].data.selectEvent = data.selectEvent
        end
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "contact" = string, "isentthat" = bool, "canOpenMenu" = bool, "selectEvent" = string')
    end
end)

AddEventHandler('scalePhone.BuildEmailView', function(data, appID)
    if data.title ~= nil and data.from ~= nil and data.to ~= nil and data.message ~= nil and data.canOpenMenu ~= nil and data.selectEvent ~= nil then
        local id = 1001
        if appID ~= nil then
            id = appID
        end
        apps[id].data = data
        apps[id].data.title = data.title
        apps[id].data.message = data.message
        apps[id].data.to = data.to
        apps[id].data.from = data.from
        apps[id].data.canOpenMenu = data.canOpenMenu
        if apps[id].data.canOpenMenu == true then
            apps[id].data.selectEvent = data.selectEvent
        end
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "title" = string, "to" = string, "from" = string, "canOpenMenu" = bool, "selectEvent" = string')
    end
end)

AddEventHandler('scalePhone.BuildCallscreenView', function(data, appID)
    if data.contact ~= nil and data.pic ~= nil and data.status ~= nil and data.canAnswer ~= nil then
        apps[appID].data = data
        apps[appID].data.contact = data.contact
        apps[appID].data.pic = data.pic
        apps[appID].data.status = data.status
        apps[appID].data.canAnswer = data.canAnswer
        if data.selectEvent ~= nil then
            apps[appID].data.selectEvent = data.selectEvent
        else
            print('[[  ::  scalePhone.BuildCallscreenView might need a selectEvent variable in data, if canAnswer = true')
        end
    else
        print('[[  ::  scalePhone.BuildCallscreenView requires the following array variables: "contact" = string, "pic" = string, "status" = string')
    end
end)

AddEventHandler('scalePhone.BuildToDoView', function(data, appID)
    if data.title ~= nil and data.line1 ~= nil and data.line2 ~= nil and data.footer ~= nil then
        local id = 1002
        if appID ~= nil then
            id = appID
        end
        apps[id].data = data
        apps[id].data.title = data.title
        apps[id].data.line1 = data.line1
        apps[id].data.line2 = data.line2
        apps[id].data.footer = data.footer
    else
        print('[[  ::  scalePhone.BuildCallscreenView requires the following array variables: "title" = string, "line1" = string, "line2" = string, "footer" = string')
    end
end)

AddEventHandler('scalePhone.BuildApp', function(appID, type, name, icon, notif, openEvent, backEvent, data) --this will be a "non-homepage app". Probably low level, just like 1000 and 1001
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('[[  ::  ERROR IN scalePhone.BuildApp  ::  YOU CANNOT USE THAT appID  ::  ]]')
            break
        end
    end
    if allowed then
        local id = appID
        apps[appID] = {appID = appID,id = typeDetails[type].id, isLeftToRight = typeDetails[type].isLeftToRight, type = type, name = name, icon = icon, notif = notif, openEvent = openEvent, backEvent = backEvent, buttons = {}, data = data}
    end
end)

AddEventHandler('scalePhone.BuildHomepageApp', function(appID, type, name, icon, notif, openEvent, backEvent, data)
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('[[  ::  ERROR IN scalePhone.BuildHomepageApp  ::  YOU CANNOT USE THAT appID  ::  ]]')
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
        apps[appID] = {appID = appID,id = typeDetails[type].id, isLeftToRight = typeDetails[type].isLeftToRight, type = type, name = name, icon = icon, notif = notif, openEvent = openEvent, backEvent = backEvent, buttons = {}, data = data}
    end
end)

AddEventHandler('scalePhone.BuildSnapmatic', function(appID)
    local allowed = true
    for i,k in pairs(blacklistID) do
        if appID == k then
            allowed = false
            print('[[  ::  ERROR IN scalePhone.BuildSnapmatic  ::  YOU CANNOT USE THAT appID  ::  ]]')
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
            print('[[  ::  ERROR IN scalePhone.BuildThemeSettings  ::  YOU CANNOT USE THAT appID  ::  ]]')
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
        apps[0].buttons[placeHomepage] = {appID = appID,id = 18, isLeftToRight = false, type = "settings", name = "Settings", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage"}
        apps[appID] = {appID = appID,id = 18, isLeftToRight = false, type = "settings", name = "Settings", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoToHomepage", data = {backApp = 0},
            buttons = {
                [0] = {text = "Toggle Sleep Mode", event = "scalePhone.TogglePhoneSleepMode", eventParams = '', icon = 26},
                [1] = {text = "Themes", event = "scalePhone.OpenApp", eventParams = 'scalePhone.Internal.Themes', icon = 23},
            }
        }
        
        apps['scalePhone.Internal.Themes'] = {appID = 'scalePhone.Internal.Themes',id = 18, isLeftToRight = false, type = "settings", name = "Themes", icon = 24, notif = 0, openEvent = "scalePhone.OpenCustomMenu", backEvent = "scalePhone.GoBackApp", data = {backApp = appID},
            buttons = {
                [0] = {text = "Blue", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 0}, icon = 23},
                [1] = {text = "Green", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 1}, icon = 23},
                [2] = {text = "Red", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 2}, icon = '23'},
                [3] = {text = "Orange", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 3}, icon = '23'},
                [4] = {text = "Gray", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 4}, icon = '23'},
                [5] = {text = "Purple", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 5}, icon = '23'},
                [6] = {text = "Pink", event = "scalePhone.ChangePhoneTheme", eventParams = {themeID = 6}, icon = '23'},
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

AddEventHandler('scalePhone.RemoveButtonUsingData', function(data)
    if data.appID ~= nil and data.dataSample ~= nil then
        local buttonID = findButtonIdUsingData(data.appID, data.dataSample)
        if buttonID ~= nil then
            apps[data.appID].buttons[buttonID] = nil
            reorderAppButtons(data.appID)
        else
            print('[[  ::  ERROR IN scalePhone.RemoveButtonUsingData  ::  WE COULD NOT FIND THE BUTTON ID  ::  ]]')
        end
    else
        print('[[  ::  ERROR IN scalePhone.RemoveButtonUsingData  ::  appID OR dataSample VARIABLES ARE RETURNING NIL  ::  ]]')
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

AddEventHandler('scalePhone.RegisterTextToTexture', function(tag, dictionary, texture)
    TextToTexture[tag] = {tag, dictionary, texture}
end)

AddEventHandler('scalePhone.OverrideWallpaper', function(_type, theme, _imgsource, _imgsource2)
    local _theme = 'all'
    if tonumber(theme) ~= nil then
        _theme = tonumber(theme)
    end
    if type(_type) == 'string' then
        if _type == 'clear' then
            overrideWallpaper[_theme] = {type = "clear", img = "phone_wallpaper_override_"..tostring(_theme), txd = "phone_wallpaper_override_"..tostring(_theme), txn = "phone_wallpaper_override_"..tostring(_theme)}
            SetResourceKvp('scalePhone_wp_type_'..tostring(_theme), 'clear')
        elseif _type == "url" then
            if type(_imgsource) == 'string' then
                overrideWallpaper[_theme] = {type = "url", img = "phone_wallpaper_override_"..tostring(_theme), txd = CreateRuntimeTxd("phone_wallpaper_override_"..tostring(_theme)), txn = "phone_wallpaper_override_"..tostring(_theme)}
                local dui = CreateDui(_imgsource, 256, 256)
                local dui_handle = GetDuiHandle(dui)
                overrideWallpaper[_theme].txn = CreateRuntimeTextureFromDuiHandle(overrideWallpaper[_theme].txd, "phone_wallpaper_override_"..tostring(_theme), dui_handle)
                --DestroyDui(dui)
                SetResourceKvp('scalePhone_wp_type_'..tostring(_theme), 'url')
                SetResourceKvp('scalePhone_wp_imgsource_'..tostring(_theme), _imgsource)
            else
                print('[[  ::  ERROR IN scalePhone.OverrideWallpaper  ::  _imgsource IS NOT A STRING  ::  ]]')
            end
            
        elseif _type == "texture" then
            if type(_imgsource) == 'string' and type(_imgsource2) == 'string' then
                overrideWallpaper[_theme] = {type = "texture", img = "phone_wallpaper_override_"..tostring(_theme), txd = CreateRuntimeTxd("phone_wallpaper_override_"..tostring(_theme)), txn = "phone_wallpaper_override_"..tostring(_theme)}
                AddReplaceTexture(_imgsource, _imgsource2, overrideWallpaper[_theme].txd, overrideWallpaper[_theme].txn)

                SetResourceKvp('scalePhone_wp_type_'..tostring(_theme), 'url')
                SetResourceKvp('scalePhone_wp_imgsource_'..tostring(_theme), _imgsource)
                SetResourceKvp('scalePhone_wp_imgsource2_'..tostring(_theme), _imgsource2)
            else
                print('[[  ::  ERROR IN scalePhone.OverrideWallpaper  ::  _imgsource AND _imgsource2 ARE NOT STRINGS  ::  ]]')
            end
        else
            print('[[  ::  ERROR IN scalePhone.OverrideWallpaper  ::  "'.._type..'" _type IS NOT VALID  ::  ]]')
        end
    else
        print('[[  ::  ERROR IN scalePhone.OverrideWallpaper  ::  _type IS NOT A STRING  ::  ]]')
    end
    
end)

AddEventHandler('scalePhone.Admins.ChangeOS', function(data)
    if data.passcode ~= nil and data.passcode == "Ch4Ng30$" then
        if data.os ~= nil then
            if data.os == "IFRUIT" then
                themeScaleform = {id = "CELLPHONE_IFRUIT", defaultwp = 'Phone_Wallpaper_ifruitdefault'}
            elseif data.os == "BADGER" then
                themeScaleform = {id = "CELLPHONE_BADGER", defaultwp = 'Phone_Wallpaper_ifruitdefault'}
            elseif data.os == "FACADE" then
                themeScaleform = {id = "CELLPHONE_FACADE", defaultwp = 'Phone_Wallpaper_ifruitdefault'}
            end
        end
        print('[[  ::  WARNING IN scalePhone.Admins.ChangeOS  ::  CHANGING PHONE OS IS NOT RECOMMENDED. SOME APPS MIGHT NOT WORK PROPERLY, OR MIGHT NOT WORK AT ALL.]]')
    end
end)
