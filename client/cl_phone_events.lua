RegisterNetEvent('scalePhone.Event.UpdateContacts')
RegisterNetEvent('scalePhone.Event.ReceiveMessage')
RegisterNetEvent('scalePhone.Event.ReceiveEmail')
RegisterNetEvent("stats.UpdateClient")


AddEventHandler("stats.UpdateClient", function(_stats, _checks)
    buttons[4] = { --stats menu
    [0] = {title = "UID", text = _stats.UID, procent = 0},
    [1] = {title = "Rank", text = _stats.rank, procent = 0},
    [2] = {title = "Level", text = _stats.level, procent = 0},
    [3] = {title = "Job", text = _stats.job, procent = 0},
    [4] = {title = "Job Points", text = _stats.jobskill, procent = 0},
    [5] = {title = "Heist Points", text = _stats.robpoints, procent = 0},
    [6] = {title = "Language", text = _stats.lang, procent = 0},
}
end)

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

RegisterCommand('sendmail', function(source, args)
    local email = {title = "", to = "me", from = "me", message = ""}
    if args[1] ~= nil then
        email.title = tostring(args[1])
    else
        email.title = "unk"
    end
    if args[2] ~= nil then
        email.message = tostring(args[2])
    else
        email.message = "unk"
    end
    TriggerEvent('scalePhone.Event.ReceiveEmail', email)
end)

RegisterCommand('sms', function(source, args)
    local sms = {contact = GetPlayerName(PlayerId()), message = ""}
    for i,k in pairs(args) do
        sms.message = sms.message.." "..tostring(k)
    end
    TriggerEvent('scalePhone.Event.ReceiveMessage', sms)
end)

--[[  LSLD CUSTOM EVENTS  ]]--

AddEventHandler('phoneJobs.ChangeJob', function(_data)
    TriggerServerEvent("jobs.ChangePlayerJob", _data.jobid)
end)