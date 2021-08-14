RegisterNetEvent('scalePhone.Event.UpdateContacts')
RegisterNetEvent('scalePhone.Event.ReceiveMessage')
RegisterNetEvent('scalePhone.Event.ReceiveEmail')

AddEventHandler('scalePhone.Event.ReceiveEmail', function(email)
    local count = #apps[3].buttons
    print(count)
    local addnotif = 1
    for i,k in pairs(apps[3].buttons) do
        print(i)
        apps[3].buttons[count-i+1] = buttons[2][count-i]
    end
    apps[3].buttons[0] = {title = email.title, to = email.to, from = email.from, message = email.message}
    apps[0].buttons[2].notif = apps[0].buttons[2].notif + addnotif
end)

AddEventHandler('scalePhone.Event.ReceiveMessage', function(sms, isMine)
    local count = #apps[2].buttons
    print(count)
    local mine = false
    local addnotif = 1
    for i,k in pairs(apps[2].buttons) do
        apps[2].buttons[count-i+1] = apps[2].buttons[count-i]
    end
    if isMine ~= nil and isMine == true then
        mine = true
        addnotif = 0
    end
    apps[2].buttons[0] = {contact = sms.contact, h = GetClockHours(), m = GetClockMinutes(), message = sms.message, event = "scalePhone.ShowMessage", isentthat = mine}
    apps[0].buttons[1].notif = apps[0].buttons[1].notif + addnotif
end)

AddEventHandler('scalePhone.Event.UpdateContacts', function(contacts)
    apps[1].buttons = {}
    for i,k in pairs(contacts) do
        apps[1].buttons[i] = {name = k.name, pic = k.pic, isBot = k.isBot, event = "scalePhone.Event.SendSMS", eventParams = {name = k.name, isBot = k.isBot}}
    end
end)

AddEventHandler("scalePhone.NumpadAddNumber", function(data)
    local txt = apps[appOpen].dataText
    if isPhoneActive == true and apps[appOpen] ~= nil and apps[appOpen].type == 'numpad' then
        if data.add ~= nil then
            if data.add == 'del' then
            elseif data.add == 'can' then
            else
                txt = txt..data.add
            end
            Scaleform.CallFunction(phoneScaleform, false, "SET_HEADER", txt)
            apps[appOpen].dataText = txt
        end
    end 
end)

AddEventHandler('scalePhone.Event.SendSMS', function(data)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 150)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('sendPhone.SendSMS', data.name, result)
    end
end)

--[[  :: ESSENTIAL MENU EVENTS ::  ]]--

AddEventHandler('scalePhone.OpenApp', function(appID, isForced)
    if isPhoneActive or isForced then
        if isForced == true and isPhoneActive == false then
            ExecuteCommand('phone')
            Citizen.Wait(1)
        end
        local id = nil
        --check if appID is a homepage app
        for i,k in pairs(apps) do
            if k.appID == appID then
                id = i
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
            elseif app.type == 'emailList' then
                openEmailsMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'emailView' then
                openEmailView(phoneScaleform, app.name, tostring(app.data.from), tostring(app.data.to), tostring(app.data.message))
            elseif app.type == 'messagesList' then
                openMessagesMenu(phoneScaleform, app.buttons, appSelectID, app.name)
            elseif app.type == 'messageView' then
                openMessageView(phoneScaleform, tostring(app.data.contact), tostring(app.data.message), app.data.fromme)
            elseif app.type == 'menu' then
                openCustomMenu(phoneScaleform, app.name, app.buttons, appSelectID)
            elseif app.type == 'todoList' then
                openStatsMenu(phoneScaleform, app.buttons, appSelectID)
            elseif app.type == 'numpad' then
            elseif app.type == 'snapmatic' then
                openSnapmatic(phoneScaleform)
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
        TriggerEvent('scalePhone.OpenApp', lastAppOpen, false)
    else
        ExecuteCommand('phone')
    end
end)

AddEventHandler('scalePhone.GoToHomepage', function()
    TriggerEvent('scalePhone.OpenApp', 'scalePhone.InternalMenu.DontUse.Homepage', false)
end)

AddEventHandler('scalePhone.BuildMessageView', function(data)
    if data.contact ~= nil and data.message ~= nil and data.isentthat ~= nil then
        apps[1000].data = {contact = data.contact, message = data.message, fromme = data.isentthat}
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "contact" = string, "isentthat" = bool')
    end
end)

AddEventHandler('scalePhone.BuildEmailView', function(data)
    if data.title ~= nil and data.from ~= nil and data.to ~= nil and data.message ~= nil then
        apps[1001].data = {title = data.title, message = data.message, to = data.to, from = data.from}
    else
        print('[[  ::  scalePhone.BuildMessageView requires the following array variables: "message" = string, "title" = string, "to" = string, "from" = string')
    end
end)

AddEventHandler('scalePhone.BuildApp', function(appID, type, name, icon, notif, openEvent, backEvent, data)
end)

AddEventHandler('scalePhone.BuildHomepageApp', function(appID, type, name, icon, notif, openEvent, backEvent, data)
end)


--[[  LSLD CUSTOM EVENTS  ]]--

AddEventHandler('phoneJobs.ChangeJob', function(_data)
    TriggerServerEvent("jobs.ChangePlayerJob", _data.jobid)
end)