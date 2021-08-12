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