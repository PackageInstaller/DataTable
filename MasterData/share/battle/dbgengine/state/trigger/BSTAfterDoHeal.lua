local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDoHeal, Super = System.NewClass("BSTAfterDoHeal", BattleStateTriggerServer)

function BSTAfterDoHeal:OnDoHeal(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("触发造成治疗后失败：找不到施法者", self.state.stateId, eventData.castRoleUid)
    return
  end
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local associator2 = castRole
  local triggerData = {
    associator2 = {associator2},
    triggerValue = eventData.heal,
    triggerValue2 = eventData.overFlowHeal,
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterDoHeal:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoHeal, self.OnDoHeal, self)
end

return BSTAfterDoHeal
