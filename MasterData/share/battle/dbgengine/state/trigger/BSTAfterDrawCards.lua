local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDrawCards, Super = System.NewClass("BSTAfterDrawCards", BattleStateTriggerServer)

function BSTAfterDrawCards:OnBFAfterDrawCards()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterDrawCards:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterDrawCards, self.OnBFAfterDrawCards, self)
end

return BSTAfterDrawCards
