local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTCardJoinDeck, Super = System.NewClass("BSTCardJoinDeck", BattleStateTriggerServer)

function BSTCardJoinDeck:OnCardDeckChange(eventData)
  if self.state.isDeleted then
    return
  end
  if eventData.cardUid ~= self.state.owner.uid then
    return
  end
  if eventData.oldDeck ~= bc.CardDeck.NoneDeck then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTCardJoinDeck:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTCardJoinDeck
