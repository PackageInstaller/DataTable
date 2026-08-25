local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleEventMgr, Super = System.NewClass("BattleEventMgr", BattleComponent)

function BattleEventMgr:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.eventData = {}
  self.lock = false
  self.opList = {}
  self.onEventCb = false
end

function BattleEventMgr:Dispose()
  self.eventData = {}
  self.lock = false
  self.opList = {}
end

function BattleEventMgr:RegisterEvent(eventId, callback, target)
  local callbackData = {
    callback = callback,
    target = target,
    priority = target and target.eventPriority or -1
  }
  if not self.eventData[eventId] then
    self.eventData[eventId] = {}
  end
  local list = self.eventData[eventId]
  local index = #list + 1
  while index > 1 and list[index - 1].priority > callbackData.priority do
    index = index - 1
  end
  table.insert(list, index, callbackData)
end

function BattleEventMgr:RegisterEventToHead(eventId, callback, target)
  local callbackData = {
    callback = callback,
    target = target,
    priority = target and target.eventPriority or -1
  }
  if not self.eventData[eventId] then
    self.eventData[eventId] = {}
  end
  local list = self.eventData[eventId]
  local index = 1
  while index <= #list and list[index].priority < callbackData.priority do
    index = index + 1
  end
  table.insert(list, index, callbackData)
end

function BattleEventMgr:UnregisterEvent(eventId, callback, target)
  if not self.eventData[eventId] then
    return
  end
  local callbackDataList = self.eventData[eventId]
  for index = #callbackDataList, 1, -1 do
    local callbackData = callbackDataList[index]
    if callbackData.callback == callback and callbackData.target == target then
      callbackData.isDeleted = true
      table.remove(callbackDataList, index)
    end
  end
end

function BattleEventMgr:UnregisterAllEventsByTarget(target)
  for _, callbackDataList in pairs(self.eventData) do
    for index = #callbackDataList, 1, -1 do
      local callbackData = callbackDataList[index]
      if callbackData.target == target then
        callbackData.isDeleted = true
        table.remove(callbackDataList, index)
      end
    end
  end
end

function BattleEventMgr:SetOnEventCallbak(cb)
  self.onEventCb = cb
end

function BattleEventMgr:SendEvent(eventId, ...)
  if not self.eventData[eventId] then
    return
  end
  local list = table.clone(self.eventData[eventId])
  for _, callbackData in ipairs(list) do
    local callback = callbackData.callback
    local target = callbackData.target
    if callback and not callbackData.isDeleted then
      local ok, err = xpcall(callback, debug.traceback, target, ...)
      if not ok and self.entity then
        self.entity:Error("SendEvent {eventId} {err}", eventId, err)
      end
    elseif self.entity then
      self.entity:Warn("--------not callback " .. eventId)
    end
  end
  if self.onEventCb then
    local ok, err = xpcall(self.onEventCb, debug.traceback, eventId, ...)
    if not ok and self.entity then
      self.entity:Error("SendEvent onEventCb {eventId} {err}", eventId, err)
    end
  end
end

return BattleEventMgr
