RegisterNetEvent('scalePhone.Event.UpdateContacts')
RegisterNetEvent('scalePhone.Event.ReceiveMessage')
RegisterNetEvent('scalePhone.Event.ReceiveEmail')

AddEventHandler('scalePhone.Event.ReceiveEmail', function(email)
    local count = #buttons[2]
    print(count)
    local addnotif = 1
    for i,k in pairs(buttons[2]) do
        print(i)
        buttons[2][count-i+1] = buttons[2][count-i]
    end
    buttons[2][0] = {title = email.title, to = email.to, from = email.from, message = email.message}
    apps[2].notif = apps[2].notif + addnotif
end)

AddEventHandler('scalePhone.Event.ReceiveMessage', function(sms, isMine)
    local count = #buttons[1]
    print(count)
    local mine = false
    local addnotif = 1
    for i,k in pairs(buttons[1]) do
        buttons[1][count-i+1] = buttons[1][count-i]
    end
    if isMine ~= nil and isMine == true then
        mine = true
        addnotif = 0
    end
    buttons[1][0] = {contact = sms.contact, h = GetClockHours(), m = GetClockMinutes(), message = sms.message, event = "scalePhone.ShowMessage", isentthat = mine}
    apps[1].notif = apps[1].notif + addnotif
end)

AddEventHandler('scalePhone.Event.UpdateContacts', function(contacts)
    buttons[0] = {}
    for i,k in pairs(contacts) do
        buttons[0][i] = {name = k.name, pic = k.pic, isBot = k.isBot, event = "scalePhone.SendSMS"}
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

--[[  :: ESSENTIAL MENU EVENTS ::  ]]--

AddEventHandler('scalePhone.OpenApp', function(appID, isForced)
    if isPhoneActive or isForced then
        if isForced == true and isPhoneActive == false then
            ExecuteCommand('phone')
            Citizen.Wait(1)
        end
        local id = nil
        local isNonHomepage = nil
        --check if appID is a homepage app
        for i,k in pairs(apps) do
            if k.appID == appID then
                id = i
                isNonHomepage = false
            end
        end

        --if we don't find it there, check if it's a non-homepage app.
        if id ~= nil then
            --we got'em. Do nothing for now.
        else
            for i,k in pairs(nonHomeApps) do
                if k.appID == appID then
                    id = i
                    isNonHomepage = true
                end
            end
        end

        --if we find it, run code, else throw tantrun in console.
        if id ~= nil then
            if isNonHomepage == false then
                local app = apps[id]
                appOpenIsNonHome = false
            else
                local app = nonHomeApps[id]
                appOpenIsNonHome = true
            end
            appSelectID = 0
            appOpen = id
            if app.type == 'homepage' then
                showHomepage(phoneScaleform, apps, selectID, themeID)
            elseif app.type == 'contacts' then
            elseif app.type == 'emailList' then
            elseif app.type == 'emailView' then
            elseif app.type == 'messagesList' then
            elseif app.type == 'messageView' then
            elseif app.type == 'menu' then
            elseif app.type == 'todoList' then
            elseif app.type == 'numpad' then
            elseif app.type == 'snapmatic' then
            else
            end
        else
        end
    end
end)



--[[  LSLD CUSTOM EVENTS  ]]--

AddEventHandler('phoneJobs.ChangeJob', function(_data)
    TriggerServerEvent("jobs.ChangePlayerJob", _data.jobid)
end)