local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterAnyCardJoinHandDeck, _ = System.NewClass("BSTAfterAnyCardJoinHandDeck", BattleStateTriggerServer)

function BSTAfterAnyCardJoinHandDeck:OnCardDeckChange(eventData)
  if self.state.isDeleted then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  if eventData.newDeck ~= bc.CardDeck.HandDeck then
    return
  end
  local triggerData = {
    associator = {card}
  }
  self:Trigger(triggerData)
end

function BSTAfterAnyCardJoinHandDeck:OnCardChangeByCmd(eventData)
  local triggerCamp = self.state.owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  if card.deck ~= bc.CardDeck.HandDeck then
    return
  end
  local triggerData = {
    associator = {card}
  }
  self:Trigger(triggerData)
end

function BSTAfterAnyCardJoinHandDeck:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardChangeByCmdAfter, self.OnCardChangeByCmd, self)
end

return BSTAfterAnyCardJoinHandDeck
