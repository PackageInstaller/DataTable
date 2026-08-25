local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BSTCardOnDrop, Super = System.NewClass("BSTCardOnDrop", BattleStateTriggerServer)

function BSTCardOnDrop:OnCardOnDrop(eventData)
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

function BSTCardOnDrop:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnDrop, self.OnCardOnDrop, self)
end

return BSTCardOnDrop
