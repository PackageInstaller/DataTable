local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTGainDeathResist, Super = System.NewClass("BSTGainDeathResist", BattleStateTriggerServer)

function BSTGainDeathResist:OnGainDeathResist(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerData = {
    triggerValue = eventData.castValue,
    associator = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTGainDeathResist:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.GainDeathResist, self.OnGainDeathResist, self)
end

return BSTGainDeathResist
