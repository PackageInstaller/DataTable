local CEventConfig = BeanManager.GetTableByName("event.ceventconfig")

local function func(conditionInfo)
  local params = conditionInfo.parm
  local dungeonEventID = tonumber(params[1])
  local record = CEventConfig:GetRecorder(dungeonEventID)
  return EventManager.IsFinishedByEventID(dungeonEventID) and NekoData.BehaviorManager.BM_Dungeon:GetCurrentFloorId() == tonumber(record.scene)
end

return func
