jo.notif = {}

--- Notification on the right with icon, color and sound
---@param source integer (The source ID of the player)
---@param text string (The text of the notification)
---@param dict string (The dictionnary of the icon)
---@param icon string (The name of the icon)
---@param color? string (The color of the text <br> default : "COLOR_WHITE")
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param soundset_ref? string (The dictionnary of the soundset <br> default : "Transaction_Feed_Sounds")
---@param soundset_name? string (The name of the soundset <br> default : "Transaction_Positive")
function jo.notif.right(source, text, dict, icon, color, duration, soundset_ref, soundset_name)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:notif", source, text, dict, icon, color, duration, soundset_ref, soundset_name)
end

--- Notification on the left with title, icon, color and sound
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param text string (The text of the notification)
---@param dict string (The dictionnary of the icon)
---@param icon string (The name of the icon)
---@param color? string (The color of the text <br> default : "COLOR_WHITE")
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param soundset_ref? string (The dictionnary of the soundset <br> default : "Transaction_Feed_Sounds")
---@param soundset_name? string (The name of the soundset <br> default : "Transaction_Positive")
function jo.notif.left(source, title, text, dict, icon, color, duration, soundset_ref, soundset_name)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:notifLeft", source, title, text, dict, icon, color, duration, soundset_ref, soundset_name)
end

--- A function to display a successful notification
---@param source integer (The source ID of the player)
---@param text string (The text of the notification)
---@return boolean (Always return `true`)
function jo.notif.rightSuccess(source, text)
  jo.notif.right(source, text, "hud_textures", "check", "COLOR_GREEN")
  return true
end

--- A function to display an error notification
---@param source integer (The source ID of the player)
---@param text string (The text of the notification)
---@return boolean (Always return `false`)
function jo.notif.rightError(source, text)
  jo.notif.right(source, text, "menu_textures", "cross", "COLOR_RED")
  return false
end

--- Notification on the top with big title and subtitle (native mission start/end)
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param subtitle string (The text of the notification)
---@param duration? integer (The duration of the notification in ms <br> default : 3000)
function jo.notif.simpleTop(source, title, subtitle, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:simpleTop", source, title, subtitle, duration)
end

--- Notification tip message
---@param source integer (The source ID of the player)
---@param tipMessage string (The tip message to display)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.tip(source, tipMessage, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:tip", source, tipMessage, duration)
end

--- Notification on top with message and location
---@param source integer (The source ID of the player)
---@param message string (The message to display)
---@param location string (The location text)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.top(source, message, location, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:top", source, message, location, duration)
end

--- Right tip notification
---@param source integer (The source ID of the player)
---@param tipMessage string (The tip message to display)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.rightTip(source, tipMessage, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:rightTip", source, tipMessage, duration)
end

--- Objective notification
---@param source integer (The source ID of the player)
---@param message string (The objective message)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.objective(source, message, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:objective", source, message, duration)
end

--- Advanced notification with quality and custom settings
---@param source integer (The source ID of the player)
---@param text string (The text of the notification)
---@param dict string (The dictionnary of the icon)
---@param icon string (The name of the icon)
---@param text_color string (The color of the text)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param quality? integer (The quality level <br> default: 1)
---@param showquality? boolean (Show quality indicator <br> default: false)
function jo.notif.advanced(source, text, dict, icon, text_color, duration, quality, showquality)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:advanced", source, text, dict, icon, text_color, duration, quality, showquality)
end

--- Basic top notification
---@param source integer (The source ID of the player)
---@param text string (The text to display)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.basicTop(source, text, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:basicTop", source, text, duration)
end

--- Center notification
---@param source integer (The source ID of the player)
---@param text string (The text to display)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param text_color? string (The color of the text <br> default: "COLOR_PURE_WHITE")
function jo.notif.center(source, text, duration, text_color)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:center", source, text, duration, text_color)
end

--- Bottom right notification
---@param source integer (The source ID of the player)
---@param text string (The text to display)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.bottomRight(source, text, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:bottomRight", source, text, duration)
end

--- Fail notification
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param subtitle string (The subtitle of the notification)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.fail(source, title, subtitle, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:fail", source, title, subtitle, duration)
end

--- Dead notification
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param audioRef string (The audio reference)
---@param audioName string (The audio name)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.dead(source, title, audioRef, audioName, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:dead", source, title, audioRef, audioName, duration)
end

--- Update notification
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param message string (The message of the notification)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.update(source, title, message, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:update", source, title, message, duration)
end

--- Warning notification
---@param source integer (The source ID of the player)
---@param title string (The title of the notification)
---@param message string (The message of the notification)
---@param audioRef string (The audio reference)
---@param audioName string (The audio name)
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
function jo.notif.warning(source, title, message, audioRef, audioName, duration)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:warning", source, title, message, audioRef, audioName, duration)
end

--- A function to print in the client console from the server side
---@param source integer (The source ID of the player)
---@param ... any (The data you want to print)
function jo.notif.print(source, ...)
  TriggerClientEvent(GetCurrentResourceName() .. ":client:notifPrint", source, ...)
end