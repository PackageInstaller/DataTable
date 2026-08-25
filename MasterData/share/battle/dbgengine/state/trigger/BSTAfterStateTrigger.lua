local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterStateTrigger, Super = System.NewClass("BSTAfterStateTrigger", BattleStateTriggerServer)

function BSTAfterStateTrigger:OnStateTriggerEnd(eventData)
  if self.state.isDeleted then
    return
  end
  if self.state.uid ~= eventData.stateUid then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterStateTrigger:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateTriggerEnd, self.OnStateTriggerEnd, self)
end

return BSTAfterStateTrigger
