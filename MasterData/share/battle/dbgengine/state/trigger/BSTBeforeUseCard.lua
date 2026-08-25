local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeUseCard, Super = System.NewClass("BSTBeforeUseCard", BattleStateTriggerServer)

function BSTBeforeUseCard:OnBeforeUseCard(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if self.cbParams.triggerPara and not card:CardTypeMatch(self.cbParams.triggerPara) then
    return
  end
  local upperTargets = card.cmdServer:GetUpperTargets()
  local triggerData = {
    associator = {card},
    associator2 = upperTargets
  }
  self:Trigger(triggerData)
end

function BSTBeforeUseCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseCard, self.OnBeforeUseCard, self)
end

return BSTBeforeUseCard
