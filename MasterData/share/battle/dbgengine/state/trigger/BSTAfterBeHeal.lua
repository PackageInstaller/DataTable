local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBeHeal, Super = System.NewClass("BSTAfterBeHeal", BattleStateTriggerServer)

function BSTAfterBeHeal:OnBeHeal(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local triggerData = {
    castRoleUid = eventData.castRoleUid,
    triggerValue = eventData.heal,
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    associator2 = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterBeHeal:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeHeal, self.OnBeHeal, self)
end

return BSTAfterBeHeal
