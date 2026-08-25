local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterAwakerCardJoinHandDeck, _ = System.NewClass("BSTAfterAwakerCardJoinHandDeck", BattleStateTriggerServer)

function BSTAfterAwakerCardJoinHandDeck:OnCardDeckChange(eventData)
  if self.state.isDeleted then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  if not card.owner or card.owner.uid ~= self.state.owner.uid then
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

function BSTAfterAwakerCardJoinHandDeck:OnCardChangeByCmd(eventData)
  local triggerCamp = self.state.owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  if not card.owner or card.owner.uid ~= self.state.owner.uid then
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

function BSTAfterAwakerCardJoinHandDeck:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardChangeByCmdAfter, self.OnCardChangeByCmd, self)
end

return BSTAfterAwakerCardJoinHandDeck
