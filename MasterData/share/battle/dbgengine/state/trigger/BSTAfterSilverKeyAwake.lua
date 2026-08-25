local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterSilverKeyAwake, _ = System.NewClass("BSTAfterSilverKeyAwake", BattleStateTriggerServer)

function BSTAfterSilverKeyAwake:AfterUseSilverKeyAwake(eventData)
  if self.state.isDeleted then
    return
  end
  local upperTargets = eventData.cmdServer:GetUpperTargets()
  local triggerData = {associator = upperTargets}
  self:Trigger(triggerData)
end

function BSTAfterSilverKeyAwake:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseSilverKeyAwake, self.AfterUseSilverKeyAwake, self)
end

return BSTAfterSilverKeyAwake
