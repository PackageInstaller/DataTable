local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTRoleDrawCard, Super = System.NewClass("BSTRoleDrawCard", BattleStateTriggerServer)

function BSTRoleDrawCard:OnCardOnDraw(eventData)
  if self.state.isDeleted then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local owner = card.owner
  local triggerCamp = owner:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {
    associator = {card},
    associator2 = {owner}
  }
  self:Trigger(triggerData)
end

function BSTRoleDrawCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnDraw, self.OnCardOnDraw, self)
end

return BSTRoleDrawCard
