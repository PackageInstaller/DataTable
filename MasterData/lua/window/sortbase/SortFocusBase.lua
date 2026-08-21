local WU, DB, REF = require("Common/WindowUtil")(this)
local m_actorHasBennRemoved, m_hasNewActor, m_equipHasBeenRemoved, m_hasNewEquip, m_itemHasBeenRemoved, m_hasNewItem

function InitWindowActor()
  this:RegisterGameEvent("ActorRemoved", function()
    m_actorHasBennRemoved = true
  end)
  this:RegisterGameEvent("ActorNew", function()
    m_hasNewActor = true
  end)
end

function FocusActor(on, excFunc)
  if on and (m_actorHasBennRemoved or m_hasNewActor) then
    m_actorHasBennRemoved = false
    m_hasNewActor = false
    local sortMate = REF["$UILuaWindow"].SortMate
    local advancedFilters = {
      contextName = sortMate.contextName
    }
    if excFunc then
      advancedFilters = excFunc()
    end
    DB:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse, advancedFilters)
  end
end

function InitWindowEquip()
  this:RegisterGameEvent("EquipRemoved", function()
    m_equipHasBeenRemoved = true
  end)
  this:RegisterGameEvent("EquipNew", function()
    m_hasNewEquip = true
  end)
end

function FocusEquip(on)
  if on and (m_equipHasBeenRemoved or m_hasNewEquip) then
    m_equipHasBeenRemoved = false
    m_hasNewEquip = false
    local sortMate = REF["$UILuaWindow"].SortMate
    DB:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse, {
      contextName = sortMate.contextName
    })
  end
end

function InitWindowItem()
  this:RegisterGameEvent("ItemRemoved", function()
    m_itemHasBeenRemoved = true
  end)
  this:RegisterGameEvent("ItemNew", function()
    m_hasNewItem = true
  end)
end

function FocusItem(on)
  if on and (m_itemHasBeenRemoved or m_hasNewItem) then
    m_itemHasBeenRemoved = false
    m_hasNewItem = false
    local sortMate = REF["$UILuaWindow"].SortMate
    DB:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse, {
      contextName = sortMate.contextName
    })
  end
end
