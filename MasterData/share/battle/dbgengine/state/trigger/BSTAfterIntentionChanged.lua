local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterIntentionChanged, Super = System.NewClass("BSTAfterIntentionChanged", BattleStateTriggerServer)

function BSTAfterIntentionChanged:OnAfterIntentionChanged(eventData)
  local monster = self.battleEngine:GetObj(eventData.uid)
  if not monster then
    return
  end
  local triggerCamp = monster:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {
    triggerValue = eventData.lastIntention,
    triggerValue2 = eventData.intention
  }
  self:Trigger(triggerData)
end

function BSTAfterIntentionChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.IntentionChanged, self.OnAfterIntentionChanged, self)
end

return BSTAfterIntentionChanged
