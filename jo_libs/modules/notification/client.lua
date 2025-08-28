jo.notif = {}

if not DataView then
  jo.require("dataview")
end

local function LoadDictFile(dict, waiter)
  if DoesStreamedTextureDictExist(dict) then
    if not HasStreamedTextureDictLoaded(dict) then
      RequestStreamedTextureDict(dict, true)
      while waiter and not HasStreamedTextureDictLoaded(dict) do
        Wait(0)
      end
    end
  end
end

local function UiFeedPostSampleToastRight(...)
  return Citizen.InvokeNative(0xB249EBCB30DD88E0, ...)
end

local function UiFeedPostSampleToast(...)
  return Citizen.InvokeNative(0x26E87218390E6729, ...)
end

local function UiFeedClearAllChannels(...)
  return Citizen.InvokeNative(0x6035E8FBCA32AC5E, ...)
end

function UiFeedPostTwoTextShard(...)
  return Citizen.InvokeNative(0xA6F4216AB10EB08E, ...)
end

-- Register existing events
RegisterNetEvent(GetCurrentResourceName() .. ":client:notif",
  function(text, dict, icon, color, duration, soundset_ref, soundset_name)
    jo.notif.right(text, dict, icon, color, duration, soundset_ref, soundset_name)
  end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:notifLeft",
  function(title, subTitle, dict, icon, color, duration, soundset_ref, soundset_name)
    jo.notif.left(title, subTitle, dict, icon, color, duration, soundset_ref, soundset_name)
  end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:simpleTop", function(title, subtitle, duration)
  jo.notif.simpleTop(title, subtitle, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:notifPrint", function(...)
  print(...)
end)

-- Register new events for additional notification types
RegisterNetEvent(GetCurrentResourceName() .. ":client:tip", function(tipMessage, duration)
  jo.notif.tip(tipMessage, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:top", function(message, location, duration)
  jo.notif.top(message, location, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:rightTip", function(tipMessage, duration)
  jo.notif.rightTip(tipMessage, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:objective", function(message, duration)
  jo.notif.objective(message, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:basicTop", function(text, duration)
  jo.notif.basicTop(text, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:center", function(text, duration, text_color)
  jo.notif.center(text, duration, text_color)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:bottomRight", function(text, duration)
  jo.notif.bottomRight(text, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:fail", function(title, subtitle, duration)
  jo.notif.fail(title, subtitle, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:dead", function(title, audioRef, audioName, duration)
  jo.notif.dead(title, audioRef, audioName, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:update", function(title, message, duration)
  jo.notif.update(title, message, duration)
end)

RegisterNetEvent(GetCurrentResourceName() .. ":client:warning", function(title, message, audioRef, audioName, duration)
  jo.notif.warning(title, message, audioRef, audioName, duration)
end)

--- A function to display a successful notification
---@param text string (The text of the notification)
---@return boolean (Always return `true`)
function jo.notif.rightSuccess(text)
  jo.notif.right(text, "hud_textures", "check", "COLOR_GREEN")
  return true
end

--- A function to display an error notification
---@param text string (The text of the notification)
---@return boolean (Always return `false`)
function jo.notif.rightError(text)
  jo.notif.right(text, "menu_textures", "cross", "COLOR_RED", nil, nil, "Transaction_Negative")
  return false
end

--- Notification on the right with icon, color and sound
---@param text string (The text of the notification)
---@param dict string (The dictionnary of the icon)
---@param icon string (The name of the icon)
---@param color? string (The color of the text <br> default : "COLOR_WHITE")
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param soundset_ref? string (The dictionnary of the soundset <br> default : "Transaction_Feed_Sounds")
---@param soundset_name? string (The name of the soundset <br> default : "Transaction_Positive")
function jo.notif.right(text, dict, icon, color, duration, soundset_ref, soundset_name)
  local message = {
    type = "notificationRight",
    text = tostring(text or ""),
    dict = tostring(dict or ""),
    icon = tostring(icon or ""),
    color = tostring(color or "COLOR_WHITE"),
    duration = tonumber(duration or 3000),
    soundset_ref = soundset_ref or "Transaction_Feed_Sounds",
    soundset_name = soundset_name or "Transaction_Positive"
  }
  if not message then return end
  UiFeedClearAllChannels()
  LoadDictFile(message.dict, true)
  message.text = CreateVarString(10, "LITERAL_STRING", tostring(message.text))
  message.dict = CreateVarString(10, "LITERAL_STRING", tostring(message.dict))
  message.soundset_ref = CreateVarString(10, "LITERAL_STRING", message.soundset_ref)
  message.soundset_name = CreateVarString(10, "LITERAL_STRING", message.soundset_name)
  local struct1 = DataView.ArrayBuffer(8 * 7)
  struct1:SetInt32(8 * 0, message.duration)
  struct1:SetInt64(8 * 1, bigInt(message.soundset_ref))
  struct1:SetInt64(8 * 2, bigInt(message.soundset_name))
  local struct2 = DataView.ArrayBuffer(8 * 10)
  struct2:SetInt64(8 * 1, bigInt(message.text))
  struct2:SetInt64(8 * 2, bigInt(message.dict))
  struct2:SetInt64(8 * 3, bigInt(joaat(message.icon)))
  struct2:SetInt64(8 * 5, bigInt(joaat(message.color)))
  UiFeedPostSampleToastRight(struct1:Buffer(), struct2:Buffer(), 1)
end

--- Notification on the left with title, icon, color and sound
---@param title string (The title of the notification)
---@param text string (The text of the notification)
---@param dict string (The dictionnary of the icon)
---@param icon string (The name of the icon)
---@param color? string (The color of the text <br> default : "COLOR_WHITE")
---@param duration? integer (The duration of the notification in ms <br> default: 3000)
---@param soundset_ref? string (The dictionnary of the soundset <br> default : "Transaction_Feed_Sounds")
---@param soundset_name? string (The name of the soundset <br> default : "Transaction_Positive")
function jo.notif.left(title, text, dict, icon, color, duration, soundset_ref, soundset_name)
  local message = {
    type = "notificationLeft",
    title = tostring(title or ""),
    text = tostring(text or ""),
    dict = tostring(dict or ""),
    icon = tostring(icon or ""),
    color = tostring(color or "COLOR_WHITE"),
    duration = tonumber(duration or 3000),
    soundset_ref = soundset_ref or "Transaction_Feed_Sounds",
    soundset_name = soundset_name or "Transaction_Positive"
  }
  if not message then return end
  UiFeedClearAllChannels()
  LoadDictFile(message.dict, true)
  local struct1 = DataView.ArrayBuffer(8 * 7)
  local struct2 = DataView.ArrayBuffer(8 * 8)
  message.soundset_ref = CreateVarString(10, "LITERAL_STRING", message.soundset_ref)
  message.soundset_name = CreateVarString(10, "LITERAL_STRING", message.soundset_name)
  struct1:SetInt32(8 * 0, message.duration)
  struct1:SetInt64(8 * 1, bigInt(message.soundset_ref))
  struct1:SetInt64(8 * 2, bigInt(message.soundset_name))
  message.title = CreateVarString(10, "LITERAL_STRING", message.title)
  message.text = CreateVarString(10, "LITERAL_STRING", message.text)
  struct2:SetInt64(8 * 1, bigInt(message.title))
  struct2:SetInt64(8 * 2, bigInt(message.text))
  struct2:SetInt32(8 * 3, 0)
  struct2:SetInt64(8 * 4, bigInt(joaat(message.dict)))
  struct2:SetInt64(8 * 5, bigInt(joaat(message.icon)))
  struct2:SetInt64(8 * 6, bigInt(joaat(message.color)))
  UiFeedPostSampleToast(struct1:Buffer(), struct2:Buffer(), 1, 1)
end

--- Notification on the top with big title and subtitle (native mission start/end)
---@param title string (The title of the notification)
---@param subtitle string (The text of the notification)
---@param duration? integer (The duration of the notification in ms <br> default : 3000)
function jo.notif.simpleTop(title, subtitle, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 7)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", title)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", subtitle)))

  UiFeedPostTwoTextShard(structConfig:Buffer(), structData:Buffer(), 1, 1)
end

--- NotifyTip
---@param tipMessage string
---@param duration? number -- default 3000
function jo.notif.tip(tipMessage, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))
  structConfig:SetInt32(8 * 1, 0)
  structConfig:SetInt32(8 * 2, 0)
  structConfig:SetInt32(8 * 3, 0)

  local structData = DataView.ArrayBuffer(8 * 3)
  structData:SetUint64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", tipMessage)))

  Citizen.InvokeNative(0x049D5C615BD38BAD, structConfig:Buffer(), structData:Buffer(), 1)
end

--- NotifyTop
---@param message string
---@param location string
---@param duration? number -- default 3000
function jo.notif.top(message, location, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 5)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", location)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", message)))

  Citizen.InvokeNative(0xD05590C1AB38F068, structConfig:Buffer(), structData:Buffer(), 0, 1)
end

--- NotifyRightTip
---@param tipMessage string
---@param duration? number -- default 3000
function jo.notif.rightTip(tipMessage, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 3)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", tipMessage)))

  Citizen.InvokeNative(0xB2920B9760F0F36B, structConfig:Buffer(), structData:Buffer(), 1)
end

--- DisplayObjective
---@param message string
---@param duration? number -- default 3000
function jo.notif.objective(message, duration)
  Citizen.InvokeNative("0xDD1232B332CBB9E7", 3, 1, 0)

  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 3)
  local strMessage = VarString(10, "LITERAL_STRING", message)
  structData:SetInt64(8 * 1, bigInt(strMessage))

  Citizen.InvokeNative(0xCEDBF17EFCC0E4A4, structConfig:Buffer(), structData:Buffer(), 1)
end

--- NotifyBasicTop
---@param text string
---@param duration? number -- default 3000
function jo.notif.basicTop(text, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 7)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", text)))

  Citizen.InvokeNative(0x7AE0589093A2E088, structConfig:Buffer(), structData:Buffer(), 1)
end

--- NotifyCenter
---@param text string
---@param duration? number -- default 3000
---@param text_color? string -- default COLOR_PURE_WHITE
function jo.notif.center(text, duration, text_color)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 4)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", text)))
  structData:SetInt64(8 * 2, bigInt(joaat(text_color or "COLOR_PURE_WHITE")))

  Citizen.InvokeNative(0x893128CDB4B81FBB, structConfig:Buffer(), structData:Buffer(), 1)
end

--- NotifyBottomRight
---@param text string
---@param duration? number -- default 3000
function jo.notif.bottomRight(text, duration)
  local structConfig = DataView.ArrayBuffer(8 * 7)
  structConfig:SetInt32(8 * 0, tonumber(duration or 3000))

  local structData = DataView.ArrayBuffer(8 * 5)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", text)))

  Citizen.InvokeNative(0x2024F4F333095FB1, structConfig:Buffer(), structData:Buffer(), 1)
end

--- NotifyFail
---@param title string
---@param subtitle string
---@param duration? number -- default 3000
function jo.notif.fail(title, subtitle, duration)
  local structConfig = DataView.ArrayBuffer(8 * 5)

  local structData = DataView.ArrayBuffer(8 * 9)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", title)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", subtitle)))

  local result = Citizen.InvokeNative(0x9F2CC2439A04E7BA, structConfig:Buffer(), structData:Buffer(), 1)
  Wait(duration or 3000)
  Citizen.InvokeNative(0x00A15B94CBA4F76F, result)
end

--- NotifyDead
---@param title string
---@param audioRef string
---@param audioName string
---@param duration? number -- default 3000
function jo.notif.dead(title, audioRef, audioName, duration)
  local structConfig = DataView.ArrayBuffer(8 * 5)

  local structData = DataView.ArrayBuffer(8 * 9)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", title)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", audioRef)))
  structData:SetInt64(8 * 3, bigInt(VarString(10, "LITERAL_STRING", audioName)))

  local result = Citizen.InvokeNative(0x815C4065AE6E6071, structConfig:Buffer(), structData:Buffer(), 1)
  Wait(duration or 3000)
  Citizen.InvokeNative(0x00A15B94CBA4F76F, result)
end

--- NotifyUpdate
---@param title string
---@param message string
---@param duration? number -- default 3000
function jo.notif.update(title, message, duration)
  local structConfig = DataView.ArrayBuffer(8 * 5)

  local structData = DataView.ArrayBuffer(8 * 9)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", title)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", message)))

  local result = Citizen.InvokeNative(0x339E16B41780FC35, structConfig:Buffer(), structData:Buffer(), 1)
  Wait(duration or 3000)
  Citizen.InvokeNative(0x00A15B94CBA4F76F, result)
end

--- NotifyWarning
---@param title string
---@param message string
---@param audioRef string
---@param audioName string
---@param duration? number -- default 3000
function jo.notif.warning(title, message, audioRef, audioName, duration)
  local structConfig = DataView.ArrayBuffer(8 * 5)

  local structData = DataView.ArrayBuffer(8 * 9)
  structData:SetInt64(8 * 1, bigInt(VarString(10, "LITERAL_STRING", title)))
  structData:SetInt64(8 * 2, bigInt(VarString(10, "LITERAL_STRING", message)))
  structData:SetInt64(8 * 3, bigInt(VarString(10, "LITERAL_STRING", audioRef)))
  structData:SetInt64(8 * 4, bigInt(VarString(10, "LITERAL_STRING", audioName)))

  local result = Citizen.InvokeNative(0x339E16B41780FC35, structConfig:Buffer(), structData:Buffer(), 1)
  Wait(duration or 3000)
  Citizen.InvokeNative(0x00A15B94CBA4F76F, result)
end