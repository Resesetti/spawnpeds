Citizen.CreateThread(function()
    local defaultHash = 416176080
    for i=1, #Config.Locations do
        local model = Config.Locations[i]["model"]
        if model then
            model["hash"] = model["hash"] or defaultHash
            _RequestModel(model["hash"])
            if not DoesEntityExist(model["entity"]) then
                model["entity"] = CreatePed(4, model["hash"], model["coords"], model["h"])
                SetEntityAsMissionEntity(model["entity"])
                SetBlockingOfNonTemporaryEvents(model["entity"], true)
                FreezeEntityPosition(model["entity"], true)
                SetEntityInvincible(model["entity"], true)
            end
            SetModelAsNoLongerNeeded(model["hash"])
        end
    end
end)

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end