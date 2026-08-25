local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BSTCardOnDraw, Super = System.NewClass("BSTCardOnDraw", BattleStateTriggerServer)

function BSTCardOnDraw:OnCardOnDraw(eventData)
  if self.state.isDeleted then
    return
  end
  if not self.state.owner:is(BattleCardServer) then
    return
  end
  if self.state.owner.uid ~= eventData.cardUid then
    return
  end
  local associator2 = self.battleEngine.roleMgr:GenMonsterOrPlayerTarget(eventData.castRoleUid)
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.cardUid)
    },
    associator2 = {associator2}
  }
  self:Trigger(triggerData)
end

function BSTCardOnDraw:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnDraw, self.OnCardOnDraw, self)
end

return BSTCardOnDraw
