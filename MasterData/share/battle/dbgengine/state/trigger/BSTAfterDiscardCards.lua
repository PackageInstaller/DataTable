local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDiscardCards, Super = System.NewClass("BSTAfterDiscardCards", BattleStateTriggerServer)

function BSTAfterDiscardCards:OnBFAfterDiscardCards()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterDiscardCards:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterDiscardCards, self.OnBFAfterDiscardCards, self)
end

return BSTAfterDiscardCards
