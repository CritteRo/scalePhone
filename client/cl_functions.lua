AddEventHandler("scalePhone.ChangePhoneTheme", function(_data)
    if _data.themeID ~= nil then
        themeID = _data.themeID
        if isPhoneActive then
            phoneScaleform = generateMainPhone(apps[0].buttons, selectID, themeID)
            appOpen = 0
        end
    end
end)

AddEventHandler("scalePhone.TogglePhoneSleepMode", function()
    sleepMode = not sleepMode
    Scaleform.CallFunction(phoneScaleform, false, "SET_SLEEP_MODE", sleepMode)
end)

blacklistID = {
    0, 1000, 1001, 1002, 'scalePhone.InternalMenu.DontUse.Homepage', 'scalePhone.Internal.Themes'
}

typeDetails = {
    ['homepage'] = {id = 1, isLeftToRight = true},
    ['contacts'] = {id = 2, isLeftToRight = false},
    ['callscreen'] = {id = 4, isLeftToRight = false},
    ['messagesList'] = {id = 6, isLeftToRight = false},
    ['messageView'] = {id = 7, isLeftToRight = false},
    ['emailList'] = {id = 8, isLeftToRight = false},
    ['emailView'] = {id = 9, isLeftToRight = false},
    ['menu'] = {id = 18, isLeftToRight = false},
    ['snapmatic'] = {id = 16, isLeftToRight = true},
    ['todoList'] = {id = 14, isLeftToRight = false},
    ['todoView'] = {id = 15, isLeftToRight = false},
    ['missionStatsView'] = {id = 19, isLeftToRight = false},
    ['numpad'] = {id = 11, isLeftToRight = true},
    ['gps'] = {id = 24, isLeftToRight = false},
    ['settings'] = {id = 22, isLeftToRight = false},
}

function RemoveNotifications(appID)
    for i,k in pairs(apps[0].buttons) do
        if appID == k.appID then
            k.notif = 0
        end
    end
end

function getAppOpen(isLast)
    local retval = appOpen
    if isLast ~= nil and isLast == true then
        retval = lastAppOpen
    end
    return retval
end

function sleepModeStatus()
    return sleepMode
end

ActualZoneNames = {
    ['AIRP'] = 'Los Santos International Airport',  
    ['ALAMO'] = 'Alamo Sea',
    ['ALTA'] = 'Alta',
    ['ARMYB'] = 'Fort Zancudo',
    ['BANHAMC'] = 'Banham Canyon Dr  ',
    ['BANNING'] = 'Banning  ',
    ['BEACH'] = 'Vespucci Beach  ',
    ['BHAMCA'] = 'Banham Canyon  ',
    ['BRADP'] = 'Braddock Pass  ',
    ['BRADT'] = 'Braddock Tunnel  ',
    ['BURTON'] = 'Burton  ',
    ['CALAFB'] = 'Calafia Bridge  ',
    ['CANNY'] = 'Raton Canyon  ',
    ['CCREAK'] = 'Cassidy Creek  ',
    ['CHAMH'] = 'Chamberlain Hills  ',
    ['CHIL'] = 'Vinewood Hills  ',
    ['CHU'] = 'Chumash  ',
    ['CMSW'] = 'Chiliad Mountain State Wilderness  ',
    ['CYPRE'] = 'Cypress Flats  ',
    ['DAVIS'] = 'Davis  ',
    ['DELBE'] = 'Del Perro Beach  ',
    ['DELPE'] = 'Del Perro  ',
    ['DELSOL'] = 'La Puerta  ',
    ['DESRT'] = 'Grand Senora Desert  ',
    ['DOWNT'] = 'Downtown  ',
    ['DTVINE'] = 'Downtown Vinewood  ',
    ['EAST_V'] = 'East Vinewood  ',
    ['EBURO'] = 'El Burro Heights  ',
    ['ELGORL'] = 'El Gordo Lighthouse  ',
    ['ELYSIAN'] = 'Elysian Island  ',
    ['GALFISH'] = 'Galilee  ',
    ['GOLF'] = 'GWC and Golfing Society  ',
    ['GRAPES'] = 'Grapeseed  ',
    ['GREATC'] = 'Great Chaparral  ',
    ['HARMO'] = 'Harmony  ',
    ['HAWICK'] = 'Hawick  ',
    ['HORS'] = 'Vinewood Racetrack  ',
    ['HUMLAB'] = 'Humane Labs and Research  ',
    ['JAIL'] = 'Bolingbroke Penitentiary  ',
    ['KOREAT'] = 'Little Seoul  ',
    ['LACT'] = 'Land Act Reservoir  ',
    ['LAGO'] = 'Lago Zancudo  ',
    ['LDAM'] = 'Land Act Dam  ',
    ['LEGSQU'] = 'Legion Square  ',
    ['LMESA'] = 'La Mesa  ',
    ['LOSPUER'] = 'La Puerta  ',
    ['MIRR'] = 'Mirror Park  ',
    ['MORN'] = 'Morningwood  ',
    ['MOVIE'] = 'Richards Majestic  ',
    ['MTCHIL'] = 'Mount Chiliad  ',
    ['MTGORDO'] = 'Mount Gordo  ',
    ['MTJOSE'] = 'Mount Josiah  ',
    ['MURRI'] = 'Murrieta Heights  ',
    ['NCHU'] = 'North Chumash  ',
    ['NOOSE'] = 'N.O.O.S.E  ',
    ['OCEANA'] = 'Pacific Ocean  ',
    ['PALCOV'] = 'Paleto Cove  ',
    ['PALETO'] = 'Paleto Bay  ',
    ['PALFOR'] = 'Paleto Forest  ',
    ['PALHIGH'] = 'Palomino Highlands  ',
    ['PALMPOW'] = 'Palmer-Taylor Power Station  ',
    ['PBLUFF'] = 'Pacific Bluffs  ',
    ['PBOX'] = 'Pillbox Hill  ',
    ['PROCOB'] = 'Procopio Beach  ',
    ['RANCHO'] = 'Rancho  ',
    ['RGLEN'] = 'Richman Glen  ',
    ['RICHM'] = 'Richman',
    ['ROCKF'] = 'Rockford Hills  ',
    ['RTRAK'] = 'Redwood Lights Track  ',
    ['SANAND'] = 'San Andreas  ',
    ['SANCHIA'] = 'San Chianski Mountain Range  ',
    ['SANDY'] = 'Sandy Shores  ',
    ['SKID'] = 'Mission Row  ',
    ['SLAB'] = 'Stab City  ',
    ['STAD'] = 'Maze Bank Arena  ',
    ['STRAW'] = 'Strawberry  ',
    ['TATAMO'] = 'Tataviam Mountains  ',
    ['TERMINA'] = 'Terminal  ',
    ['TEXTI'] = 'Textile City  ',
    ['TONGVAH'] = 'Tongva Hills  ',
    ['TONGVAV'] = 'Tongva Valley  ',
    ['VCANA'] = 'Vespucci Canals  ',
    ['VESP'] = 'Vespucci',
    ['VINE'] = 'Vinewood',
    ['WINDF'] = 'Ron Alternates Wind Farm  ',
    ['WVINE'] = 'West Vinewood  ',
    ['ZANCUDO'] = 'Zancudo River  ',
    ['ZP_ORT'] = 'Port of South Los Santos' ,
    ['ZQ_UAR'] = 'Davis Quartz',
}