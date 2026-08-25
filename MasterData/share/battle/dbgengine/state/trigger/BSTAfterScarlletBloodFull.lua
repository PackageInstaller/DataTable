local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterScarlletBloodFull, Super = System.NewClass("BSTAfterScarlletBloodFull", BattleStateTriggerServer)

function BSTAfterScarlletBloodFull:OnScarlletBloodFull(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    triggerValue = eventData.changedValue,
    associator = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterScarlletBloodFull:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ScarletBloodFull, self.OnScarlletBloodFull, self)
end

return BSTAfterScarlletBloodFull
