local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterSwallowCard, Super = System.NewClass("BSTAfterSwallowCard", BattleStateTriggerServer)

function BSTAfterSwallowCard:OnCardDeckChange(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if eventData.newDeck == bc.CardDeck.SwallowDeck then
    local triggerData = {
      associator = {castRole}
    }
    self:Trigger(triggerData)
  end
end

function BSTAfterSwallowCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTAfterSwallowCard
