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