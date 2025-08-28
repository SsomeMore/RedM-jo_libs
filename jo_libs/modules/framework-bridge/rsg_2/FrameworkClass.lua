-------------
-- FRAMEWORK CLASS
-------------
local RSGCore = exports["rsg-core"]:GetCoreObject()
local Inventory = exports.ox_inventory

jo.file.load("framework-bridge.rsg.FrameworkClass")
jo.framework.inv = Inventory

-------------
-- VARIABLES
-------------

-------------
-- INVENTORY
-------------

function jo.framework:registerUseItem(item, closeAfterUsed, callback)
  -- Check if item exists in ox_inventory items
  local itemData = Inventory:Items(item)
  if not itemData then
    return eprint(item .. " < item does not exist in the ox_inventory configuration")
  end
  
  -- Register useable item with ox_inventory
  exports.ox_inventory:registerHook('useItem', function(playerId, itemName, slotId, metadata)
    if itemName == item then
      callback(playerId, { metadata = metadata })
      if closeAfterUsed then
        -- Close inventory for the player
        exports.ox_inventory:forceCloseInventory(playerId)
      end
      return true -- Consume the item
    end
  end, {
    itemFilter = { [item] = true }
  })
end

function jo.framework:createInventory(id, name, invConfig)
  local config = {
    label = name,
    slots = invConfig.maxSlots or 50,
    weight = invConfig.maxWeight and (invConfig.maxWeight * 1000) or 100000, -- convert kg to g
    owner = false, -- Make it accessible to anyone
    groups = false,
    coords = false
  }

  -- Register the inventory with ox_inventory
  exports.ox_inventory:RegisterStash(id, config.label, config.slots, config.weight, config.owner, config.groups, config.coords)
end

function jo.framework:openInventory(source, id)
  -- Open the stash inventory for the player
  exports.ox_inventory:forceOpenInventory(source, 'stash', id)
end

function jo.framework:addItemInInventory(source, invId, item, quantity, metadata, needWait)
  -- Ensure the inventory exists (ox_inventory will handle creation if it doesn't exist)
  local success = exports.ox_inventory:AddItem(invId, item, quantity, metadata)
  return success
end

function jo.framework:getItemsFromInventory(invId)
  local inventory = exports.ox_inventory:GetInventoryItems(invId)
  local items = {}
  
  if inventory then
    for slot, item in pairs(inventory) do
      if item and item.name then
        table.insert(items, {
          metadata = item.metadata or {},
          amount = item.count,
          item = item.name,
          slot = slot
        })
      end
    end
  end
  
  return items
end

function jo.framework:removeInventory(invId)
  -- Remove inventory from database (ox_inventory handles this automatically)
  -- You may need to clear the inventory first
  exports.ox_inventory:ClearInventory(invId)
  
  -- If you need to completely remove the stash registration, you might need to handle this
  -- depending on your ox_inventory version and requirements
  return true
end