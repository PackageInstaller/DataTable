local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeDrawCards, Super = System.NewClass("BSTBeforeDrawCards", BattleStateTriggerServer)

function BSTBeforeDrawCards:OnBFBeforeDrawCards()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeDrawCards:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeDrawCards, self.OnBFBeforeDrawCards, self)
end

return BSTBeforeDrawCards
