local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BSTMaxHpChanged, Super = System.NewClass("BSTMaxHpChanged", BattleStateTriggerServer)

function BSTMaxHpChanged:OnPropertyChanged(eventData)
  if eventData.propertyName ~= BP.max_hp then
    return
  end
  if not eventData.changedValue or 0 == eventData.changedValue then
    return
  end
  local targetRole = self.battleEngine:GetObj(eventData.uid)
  local triggerData = {
    triggerValue = eventData.changedValue,
    associator = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTMaxHpChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.PropertyChange, self.OnPropertyChanged, self)
end

return BSTMaxHpChanged
