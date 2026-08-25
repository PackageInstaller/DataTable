local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterSwitchOceanModel, Super = System.NewClass("BSTAfterSwitchOceanModel", BattleStateTriggerServer)

function BSTAfterSwitchOceanModel:OnOceanModeChange(eventData)
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterSwitchOceanModel:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.OceanModeChange, self.OnOceanModeChange, self)
end

return BSTAfterSwitchOceanModel
