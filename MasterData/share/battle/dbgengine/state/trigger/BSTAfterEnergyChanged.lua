local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BSTAfterEnergyChanged, Super = System.NewClass("BSTAfterEnergyChanged", BattleStateTriggerServer)

function BSTAfterEnergyChanged:OnPropertyChanged(eventData)
  if eventData.propertyName ~= BP.energy then
    return
  end
  local targetRole = self.battleEngine:GetObj(eventData.uid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.uid) then
    return
  end
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerData = {
    triggerValue = eventData.changedValue,
    associator = {castRole},
    associator2 = {
      eventData.castCardUid and self.battleEngine:GetObj(eventData.castCardUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterEnergyChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.PropertyChange, self.OnPropertyChanged, self)
end

return BSTAfterEnergyChanged
