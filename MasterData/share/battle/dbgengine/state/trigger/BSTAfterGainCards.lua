local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterGainCards, Super = System.NewClass("BSTAfterGainCards", BattleStateTriggerServer)

function BSTAfterGainCards:OnCardDeckChange(eventData)
  if not eventData.enternal then
    return
  end
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
  local skillType = self.cbParams.triggerPara
  if card:CardTypeMatch(skillType) then
    return
  end
  local triggerData = {
    associator = {card}
  }
  self:Trigger(triggerData)
end

function BSTAfterGainCards:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTAfterGainCards
