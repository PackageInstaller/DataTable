local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterSelectInitCard, Super = System.NewClass("BSTAfterSelectInitCard", BattleStateTriggerServer)

function BSTAfterSelectInitCard:OnAfterSelectInitCard(eventData)
  if not self:TryTrigger(eventData.camp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterSelectInitCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterSelectInitCard, self.OnAfterSelectInitCard, self)
end

return BSTAfterSelectInitCard
