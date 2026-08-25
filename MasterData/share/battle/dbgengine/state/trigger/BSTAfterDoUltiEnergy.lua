local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDoUltiEnergy, Super = System.NewClass("BSTAfterDoUltiEnergy", BattleStateTriggerServer)

function BSTAfterDoUltiEnergy:OnDoUltiEnergy(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("触发造成狂气后失败，找不到施法者", self.state.stateId, eventData.castRoleUid)
    return
  end
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local associator2 = castRole
  local triggerData = {
    castRoleUid = eventData.castRoleUid,
    triggerValue = eventData.castValue,
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    },
    associator2 = {associator2}
  }
  self:Trigger(triggerData)
end

function BSTAfterDoUltiEnergy:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoUltiEnergy, self.OnDoUltiEnergy, self)
end

return BSTAfterDoUltiEnergy
