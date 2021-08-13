AddEventHandler("scalePhone.ChangePhoneTheme", function(_data)
    if _data.themeID ~= nil then
        themeID = _data.themeID
        if isPhoneActive then
            phoneScaleform = generateMainPhone(apps, selectID, themeID)
            appOpen = -1
        end
    end
end)

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

gestureDicts = {
	"blow_kiss",
	"dock",
	"jazz_hands",
	"the_bird",
	"thumbs_up",
	"wank",
}

function loopGestures()
	currentGestureDict = 0
	doingGesture = false
	while appOpen == 3 do Wait(0)
		if not IsControlPressed(0, 186) then
			if IsControlJustPressed(0, 313) then
				currentGestureDict = (currentGestureDict + 1) % #gestureDicts
				--DisplayHelpText("Action Selected:\n" .. gestureNames[currentGestureDict+1], 1000)
			end
			if IsControlJustPressed(0, 312) then
				if currentGestureDict-1 < 0 then 
					currentGestureDict = #gestureDicts-1
				else
					currentGestureDict = (currentGestureDict - 1)
				end
				--DisplayHelpText("Action Selected:\n" .. gestureNames[currentGestureDict+1], 1000)
			end
		end
	
		gestureDir = "anim@mp_player_intselfie" .. gestureDicts[currentGestureDict+1]
		
		if IsControlPressed(0, 186) then
			if doingGesture == false then
					doingGesture = true
				if not HasAnimDictLoaded(gestureDir) then
					RequestAnimDict(gestureDir)
					repeat Wait(0) until HasAnimDictLoaded(gestureDir)
				end
				TaskPlayAnim(PlayerPedId(), gestureDir, "enter", 4.0, 4.0, -1, 128, -1.0, false, false, false)
				Wait(GetAnimDuration(gestureDir, "enter")*1000)
				TaskPlayAnim(PlayerPedId(), gestureDir, "idle_a", 8.0, 4.0, -1, 129, -1.0, false, false, false)
			end
		else
			if doingGesture == true then
				doingGesture = false
				TaskPlayAnim(PlayerPedId(), gestureDir, "exit", 4.0, 4.0, -1, 128, -1.0, false, false, false)
				Wait(GetAnimDuration(gestureDir, "exit")*1000)
				RemoveAnimDict(gestureDir)
			end
		end
	end
	TaskPlayAnim(PlayerPedId(), "", "", 4.0, 4.0, -1, 128, -1.0, false, false, false)
	RemoveAnimDict(gestureDir)
end

function runHomepageApp(_event, selectID)
    if _event == "scalePhone.OpenMessages" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openMessagesMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenContacts" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openContactsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenEmails" then
        appOpen = selectID
        appSelectID = 0
        apps[appOpen].notif = 0
        CellCamMoveFinger(5)
        openEmailsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenStatsMenu" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openStatsMenu(phoneScaleform, buttons[appOpen], appSelectID)
    elseif _event == "scalePhone.OpenSnapmatic" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openSnapmatic(phoneScaleform)
        Citizen.CreateThread(loopGestures())
    elseif _event == "scalePhone.OpenCustomMenu" then
        appOpen = selectID
        appSelectID = 0
        CellCamMoveFinger(5)
        openCustomMenu(phoneScaleform, apps[selectID].name, buttons[appOpen], appSelectID)
    end
end

function openMessagePrompt(name)
    Citizen.CreateThread(function()
        DisplayOnscreenKeyboard(1, "CELL_EMAIL_BOD", "", "Message "..name, "", "", "", 100)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            TriggerServerEvent('sendPhone.SendSMS', name, result)
            TriggerEvent('scalePhone.Event.ReceiveMessage', {contact = name, message = result}, true)
        end
    end)
end