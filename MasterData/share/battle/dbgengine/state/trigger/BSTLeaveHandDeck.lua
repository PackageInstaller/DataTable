local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTLeaveHandDeck, Super = System.NewClass("BSTLeaveHandDeck", BattleStateTriggerServer)

function BSTLeaveHandDeck:OnCardDeckChange(eventData)
  print("BSTLeaveHandDeck ============= ", table.tostring(eventData))
  if self.state.isDeleted then
    return
  end
  if eventData.cardUid ~= self.state.owner.uid then
    return
  end
  if eventData.oldDeck ~= bc.CardDeck.HandDeck then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTLeaveHandDeck:CardChangeByCmdBefore(eventData)
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

function BSTLeaveHandDeck:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardChangeByCmdBefore, self.CardChangeByCmdBefore, self)
end

return BSTLeaveHandDeck
