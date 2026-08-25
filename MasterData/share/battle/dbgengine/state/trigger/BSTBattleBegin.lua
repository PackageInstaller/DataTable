local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBattleBegin, Super = System.NewClass("BSTBattleBegin", BattleStateTriggerServer)

function BSTBattleBegin:OnBFBattleBegin()
  if self.state.isDeleted then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBattleBegin:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleBegin, self.OnBFBattleBegin, self)
end

return BSTBattleBegin
