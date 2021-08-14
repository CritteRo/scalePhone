function openSnapmatic(scaleform)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)

    cameraScaleform = generateSnapmaticScaleform()
    SetPedConfigFlag(PlayerPedId(), 242, true)
	SetPedConfigFlag(PlayerPedId(), 243, true)
	SetPedConfigFlag(PlayerPedId(), 244, not true)

	CellCamActivate(true, true)
	CellFrontCamActivate(frontCam)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", 'Snapmatic')
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 16, 0)
end

function generateSnapmaticScaleform()
    local scaleform = Scaleform.Request('CAMERA_GALLERY')
    Scaleform.CallFunction(scaleform, false, "OPEN_SHUTTER")
    Scaleform.CallFunction(scaleform, false, "SHOW_PHOTO_FRAME", 1)
    Scaleform.CallFunction(scaleform, false, "SHOW_REMAINING_PHOTOS", 1)
    return scaleform
end

function useShutter(scaleform)
    Scaleform.CallFunction(scaleform, false, "CLOSE_THEN_OPEN_SHUTTER")
end

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1
frontCam = 0
currentGestureDict = 0
doingGesture = false
gestureDicts = {
	"blow_kiss",
	"dock",
	"jazz_hands",
	"the_bird",
	"thumbs_up",
	"wank",
}
gestureDir = "anim@mp_player_intselfie" .. gestureDicts[currentGestureDict+1]

AddEventHandler('scalePhone.HandleInput.snapmatic', function(input)
    if input == "left" then
        CellCamMoveFinger(4)
        frontCam = not frontCam
        CellFrontCamActivate(frontCam)
    elseif input == 'right' then
        CellCamMoveFinger(3)
        frontCam = not frontCam
        CellFrontCamActivate(frontCam)
    elseif input == 'up' then
        CellCamMoveFinger(1)
        if appSelectID == 0 then
            appSelectID = #apps[appOpen].buttons
        else
            appSelectID = appSelectID - 1
        end
        gestureDir = "anim@mp_player_intselfie" .. apps[appOpen].buttons[appSelectID][1]
        doingGesture = true
        if not HasAnimDictLoaded(gestureDir) then
            RequestAnimDict(gestureDir)
            repeat Wait(0) until HasAnimDictLoaded(gestureDir)
        end
        TaskPlayAnim(PlayerPedId(), gestureDir, "enter", 4.0, 4.0, -1, 128, -1.0, false, false, false)
        Wait(GetAnimDuration(gestureDir, "enter")*1000)
        TaskPlayAnim(PlayerPedId(), gestureDir, "idle_a", 8.0, 4.0, -1, 129, -1.0, false, false, false)
        doingGesture = false
    elseif input == 'down' then
        CellCamMoveFinger(2)
        if appSelectID == #apps[appOpen].buttons then
            appSelectID = 0
        else
            appSelectID = appSelectID + 1
        end
        print(appSelectID.." / "..tostring(apps[appOpen].buttons[appSelectID][1]))
        gestureDir = "anim@mp_player_intselfie" .. apps[appOpen].buttons[appSelectID][1]
        doingGesture = true
        if not HasAnimDictLoaded(gestureDir) then
            RequestAnimDict(gestureDir)
            repeat Wait(0) until HasAnimDictLoaded(gestureDir)
        end
        TaskPlayAnim(PlayerPedId(), gestureDir, "enter", 4.0, 4.0, -1, 128, -1.0, false, false, false)
        Wait(GetAnimDuration(gestureDir, "enter")*1000)
        TaskPlayAnim(PlayerPedId(), gestureDir, "idle_a", 8.0, 4.0, -1, 129, -1.0, false, false, false)
        doingGesture = false
    elseif input == 'select' then
        CellCamMoveFinger(5)
        useShutter(cameraScaleform)
        TakePhoto()
        if (WasPhotoTaken() and SavePhoto(-1)) then
            ClearPhoto()
        end
        TaskPlayAnim(PlayerPedId(), gestureDir, "exit", 4.0, 4.0, -1, 128, -1.0, false, false, false)
        Wait(GetAnimDuration(gestureDir, "exit")*1000)
        RemoveAnimDict(gestureDir)
        PlaySoundFrontend(-1, "Camera_Shoot", "Phone_SoundSet_Michael", 1)
    elseif input == 'back' then
        CellCamMoveFinger(5)
        TaskPlayAnim(PlayerPedId(), gestureDir, "exit", 4.0, 4.0, -1, 128, -1.0, false, false, false)
        Wait(GetAnimDuration(gestureDir, "exit")*1000)
        RemoveAnimDict(gestureDir)
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data, false)
    end
end)