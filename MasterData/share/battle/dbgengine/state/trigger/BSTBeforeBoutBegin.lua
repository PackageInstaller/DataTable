local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeBoutBegin, Super = System.NewClass("BSTBeforeBoutBegin", BattleStateTriggerServer)

function BSTBeforeBoutBegin:OnBFBeforeBoutBegin()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeBoutBegin:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutBegin, self.OnBFBeforeBoutBegin, self)
end

return BSTBeforeBoutBegin
