local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterAddNewCard, Super = System.NewClass("BSTAfterAddNewCard", BattleStateTriggerServer)

function BSTAfterAddNewCard:OnCardDeckChange(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if eventData.oldDeck ~= bc.CardDeck.NoneDeck then
    return
  end
  local triggerData = {
    associator = {card}
  }
  self:Trigger(triggerData)
end

function BSTAfterAddNewCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTAfterAddNewCard
