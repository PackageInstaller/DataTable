local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTCardChange, Super = System.NewClass("BSTCardChange", BattleStateTriggerServer)

function BSTCardChange:OnCardChange(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not self:TryTrigger(card:GetCamp()) then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.cardUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTCardChange:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardChange, self.OnCardChange, self)
end

return BSTCardChange
