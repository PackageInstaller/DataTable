local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTEnergyConsume, Super = System.NewClass("BSTEnergyConsume", BattleStateTriggerServer)

function BSTEnergyConsume:OnConsumeEnergy(eventData)
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

function BSTEnergyConsume:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeEnergy, self.OnConsumeEnergy, self)
end

return BSTEnergyConsume
