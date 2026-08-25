local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeBattleEnd, Super = System.NewClass("BSTBeforeBattleEnd", BattleStateTriggerServer)

function BSTBeforeBattleEnd:OnBFBattleEnd()
  if self.state.isDeleted then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeBattleEnd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBFBattleEnd, self)
end

return BSTBeforeBattleEnd
