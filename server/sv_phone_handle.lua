RegisterNetEvent('sendPhone.SendSMS')


AddEventHandler('scalePhone.Server.GatherContacts', function()
    local row = 0
    onlinePlayers = {}
    for _,player in ipairs(GetPlayers()) do
        onlinePlayers[row] = {name = GetPlayerName(player), pic = 'CHAR_BLANK_ENTRY', isBot = false}
        row = row + 1
    end
    TriggerClientEvent('scalePhone.Event.UpdateContacts', -1, onlinePlayers)
end)


AddEventHandler('core.GatherPlayersForScoreboard', function()
    TriggerEvent('scalePhone.Server.GatherContacts')
end)

AddEventHandler('sendPhone.SendSMS', function(to, message)
    local src = source
    local senderid = 0
    for _,player in ipairs(GetPlayers()) do
        if GetPlayerName(player) == to then
            senderid = player
            break
        end
    end
    if senderid ~= 0 then
        TriggerClientEvent('scalePhone.Event.ReceiveMessage', senderid, {contact = GetPlayerName(src), message = message}, false)
        local notif = {type = "suggestion", img = 'CHAR_BLANK_ENTRY', title = "New Message!", subtitle = "From: "..GetPlayerName(src), icontype = 1, text = message, colID = 123}
        TriggerClientEvent('core.notify', senderid, notif.type, notif)
        TriggerClientEvent('core.notify', src, "simple", {text = "Message sent!", colID = 123})
    else
        TriggerClientEvent('core.notify', src, "simple", {text = "We could not find that player", colID = 6})
    end
end)

AddEventHandler('stats.GetPlayerStats', function(_source)
    local src = _source
    Citizen.Wait(13000)
    local email = {title = "Tip of the day!", to = GetPlayerName(src), from = "admins@lslockdown", message = "Bye. I'm leaving the server because I'm bored. Despite talking to all of you for a while I don't care about any of you at all. I lied. I'm not 14 I'm 13. And a girl. I can probably draw better than yall as well. Just sayin. Cya."}
    TriggerClientEvent('scalePhone.Event.ReceiveEmail', src, email)
    local notif = {type = "suggestion", img = 'CHAR_SOCIAL_CLUB', title = "New Email!", subtitle = "From: admins@lslockdown", icontype = 1, text = "", colID = 123}
    TriggerClientEvent('core.notify', src, notif.type, notif)
end)