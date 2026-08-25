local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTEnergyGain, Super = System.NewClass("BSTEnergyGain", BattleStateTriggerServer)

function BSTEnergyGain:OnGainEnergy(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    triggerValue = eventData.castValue,
    associator = {castRole},
    associator2 = {
      eventData.castCardUid and self.battleEngine:GetObj(eventData.castCardUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTEnergyGain:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.GainEnergy, self.OnGainEnergy, self)
end

return BSTEnergyGain
