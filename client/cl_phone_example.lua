TriggerEvent('scalePhone.BuildHomepageApp', 'app_hackerman', 'securoHack', 'SecuroServ H4x0r Client', 57, 69, '', 'scalePhone.GoToHomepage', {})

TriggerEvent('scalePhone.BuildAppButton', 'app_hackerman', {coords = vector3(2330.24,2571.88,46.67), weakSignalDist = 100.0, strongSignalDist = 8.0, timeNeeded = 5, event = "scalePhone.Lol", eventParams = 'button1'}, false, -1)


AddEventHandler('scalePhone.Lol', function(msg)
    TriggerEvent('core.notify', "simple", {text = msg})
end)