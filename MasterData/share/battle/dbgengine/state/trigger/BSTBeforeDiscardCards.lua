local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeDiscardCards, Super = System.NewClass("BSTBeforeDiscardCards", BattleStateTriggerServer)

function BSTBeforeDiscardCards:OnBFBeforeDiscardCards()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeDiscardCards:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeDiscardCards, self.OnBFBeforeDiscardCards, self)
end

return BSTBeforeDiscardCards
