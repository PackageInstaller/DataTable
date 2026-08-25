local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterStateRemoved, _ = System.NewClass("BSTAfterStateRemoved", BattleStateTriggerServer)

function BSTAfterStateRemoved:OnStateRemovedEnd(eventData)
  if self.state.uid ~= eventData.stateUid then
    return
  end
  local triggerData = {ignoreDeleted = true}
  self:Trigger(triggerData)
end

function BSTAfterStateRemoved:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateRemoved, self.OnStateRemovedEnd, self)
end

return BSTAfterStateRemoved
