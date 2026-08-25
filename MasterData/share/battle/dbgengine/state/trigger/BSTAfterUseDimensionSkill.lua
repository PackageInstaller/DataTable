local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterUseDimensionSkill, Super = System.NewClass("BSTAfterUseDimensionSkill", BattleStateTriggerServer)

function BSTAfterUseDimensionSkill:OnUseDimensionSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    associator = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterUseDimensionSkill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseDimensionSkill, self.OnUseDimensionSkill, self)
end

return BSTAfterUseDimensionSkill
