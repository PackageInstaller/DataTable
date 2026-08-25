local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTCardCostChanged, Super = System.NewClass("BSTCardCostChanged", BattleStateTriggerServer)

function BSTCardCostChanged:OnCardCostChanged(eventData)
  if self.state.isDeleted then
    return
  end
  if eventData.uid ~= self.state.owner.uid then
    return
  end
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.uid)
    },
    associator2 = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTCardCostChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardCostChanged, self.OnCardCostChanged, self)
end

return BSTCardCostChanged
