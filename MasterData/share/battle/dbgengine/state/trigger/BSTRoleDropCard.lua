local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTRoleDropCard, Super = System.NewClass("BSTRoleDropCard", BattleStateTriggerServer)

function BSTRoleDropCard:OnCardOnDrop(eventData)
  if self.state.isDeleted then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card.owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {
    associator = {card}
  }
  self:Trigger(triggerData)
end

function BSTRoleDropCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnDrop, self.OnCardOnDrop, self)
end

return BSTRoleDropCard
