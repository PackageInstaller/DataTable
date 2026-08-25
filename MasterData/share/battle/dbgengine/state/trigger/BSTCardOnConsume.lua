local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BSTCardOnConsume, Super = System.NewClass("BSTCardOnConsume", BattleStateTriggerServer)

function BSTCardOnConsume:OnCardOnConsume(eventData)
  if self.state.isDeleted then
    return
  end
  if not self.state.owner:is(BattleCardServer) then
    return
  end
  if self.state.owner.uid ~= eventData.cardUid then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.cardUid)
    },
    associator2 = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTCardOnConsume:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnConsume, self.OnCardOnConsume, self)
end

return BSTCardOnConsume
