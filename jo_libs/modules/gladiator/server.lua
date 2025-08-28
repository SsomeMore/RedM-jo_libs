jo.gladiator = {}

function jo.gladiator.regisserver(eventName, callback)
    RegisterServerEvent(eventName, callback)
end

function jo.gladiator.triggerev(eventName, callback)
    TriggerEvent(eventName, callback)
end

function jo.gladiator.trggercl(eventName, callback)
    TriggerClientEvent(eventName, callback)
end

return jo.gladiator