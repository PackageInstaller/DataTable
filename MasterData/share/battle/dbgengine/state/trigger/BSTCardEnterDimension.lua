local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTCardEnterDimension, Super = System.NewClass("BSTCardEnterDimension", BattleStateTriggerServer)

function BSTCardEnterDimension:OnCardDeckChange(eventData)
  if self.state.isDeleted then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if eventData.newDeck ~= bc.CardDeck.DimensionDeck then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  local associator2 = card and card.owner or self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerData = {
    triggerValue = 1,
    associator = {player},
    associator2 = {associator2}
  }
  self:Trigger(triggerData)
end

function BSTCardEnterDimension:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

return BSTCardEnterDimension
