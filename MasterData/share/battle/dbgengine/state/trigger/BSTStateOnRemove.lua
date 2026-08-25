local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTStateOnRemove, _ = System.NewClass("BSTStateOnRemove", BattleStateTriggerServer)

function BSTStateOnRemove:OnStateLifeEnd(eventData)
  if self.state.uid ~= eventData.stateUid then
    return
  end
  local triggerData = {ignoreDeleted = true}
  self:Trigger(triggerData)
end

function BSTStateOnRemove:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateLifeEnd, self.OnStateLifeEnd, self)
end

return BSTStateOnRemove
