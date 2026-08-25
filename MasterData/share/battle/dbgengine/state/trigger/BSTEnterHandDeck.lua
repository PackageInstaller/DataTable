local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTEnterHandDeck, Super = System.NewClass("BSTEnterHandDeck", BattleStateTriggerServer)

function BSTEnterHandDeck:OnCardDeckChange(eventData)
  local triggerCamp = self.state.owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if eventData.cardUid ~= self.state.owner.uid then
    return
  end
  if eventData.newDeck ~= bc.CardDeck.HandDeck then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTEnterHandDeck:OnCardChangeByCmd(eventData)
  local triggerCamp = self.state.owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if eventData.cardUid ~= self.state.owner.uid then
    return
  end
  if self.state.owner.deck ~= bc.CardDeck.HandDeck then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTEnterHandDeck:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTEnterHandDeck
