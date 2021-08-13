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