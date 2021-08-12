
day = {
	[1] = "Mon",
	[2] = "Tue",
	[3] = "Wed",
	[4] = "Thu",
	[5] = "Fri",
	[6] = "Sat",
	[7] = "Sun"
}

--id 4 = call screen / 11 = numpad / 15 = todo 6= sms list / 8 = email list


function generateMainPhone(_apps, _selectID)
    local scaleform = Scaleform.Request('CELLPHONE_IFRUIT')

    Scaleform.CallFunction(scaleform, false, "SET_THEME", 1)
    Scaleform.CallFunction(scaleform, false, "SET_SLEEP_MODE", 0)
    showHomepage(scaleform, _apps, _selectID)
    --openMessagesMenu(scaleform)

    return scaleform
end

function showHomepage(scaleform, apps, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_BACKGROUND_CREW_IMAGE", "Phone_Wallpaper_ifruitdefault")
    for i,k in pairs(apps) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 1, i, k.icon, k.notif, k.name, 500.0)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 1, selectID)
end

function openMessagesMenu(scaleform, messages, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Messages")
    for i,k in pairs(messages) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 6, i, k.h, k.m, k.contact, k.message)
    end
    --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, 0, 0, 0, "Lili", "Nelu tea rugat iulia sa idai si ei osuta dojda mi sa sia tigari si maine ti da")
    --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, 1, 2, 0, "Dan Nistor", "Salut eu am vb k u iar u incepi sa dai prin ziare si prin astea ce am vb k tine nu i frumos ce ai facut sincer")
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 6, selectID)
end

function openContactsMenu(scaleform, contacts, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Contacts")
    for i,k in pairs(contacts) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 2, i, 0, k.name, "", k.pic)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 2, selectID)
end

function openEmailsMenu(scaleform, emails, selectID)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", "Emails")
    for i,k in pairs(emails) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 8, i, 1, 0, k.title, k.message)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 8, selectID)
end

function openEmailViewer(scaleform, title, from, to, message)
    SetMobilePhoneRotation(-90.0,0.0,90.0) -- 75<X<75
    SetPhoneLean(true)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 9, 0, 1, "To: ~b~me~s~,", 'From: ~b~'..from..'~s~', "<c>"..title.."</c>", message)

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 9, 0)
end

function openCustomMenu(scaleform, title, buttons, selectID)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    for i,k in pairs(buttons) do
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 18, i, 0, k.text)
    end

    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 18, seletID)
end

--[[
APPS:
1 = snapmatic,
2 = sms,
3 = blank / black
4 = email,
5 = contacts
6 = web,
11 = contacts with a plus
12 = jobs / todo?
14 = multiple people
24 = settings
27 = ! sign
]]