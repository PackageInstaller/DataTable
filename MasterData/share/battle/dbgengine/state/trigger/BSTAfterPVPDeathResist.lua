local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterPVPDeathResist, _ = System.NewClass("BSTAfterPVPDeathResist", BattleStateTriggerServer)

function BSTAfterPVPDeathResist:OnPVPDeathResist(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerData = {
    associator = {targetRole},
    associator2 = {castRole},
    triggerValue = eventData.castDamage
  }
  self:Trigger(triggerData)
end

function BSTAfterPVPDeathResist:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.PVPDeathResist, self.OnPVPDeathResist, self)
end

return BSTAfterPVPDeathResist
