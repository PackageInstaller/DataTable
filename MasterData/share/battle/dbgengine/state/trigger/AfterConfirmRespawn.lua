local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local AfterConfirmRespawn, _ = System.NewClass("AfterConfirmRespawn", BattleStateTriggerServer)

function AfterConfirmRespawn:OnConfirmRespawn(_)
  if self.state.isDeleted then
    return
  end
  self:Trigger({})
end

function AfterConfirmRespawn:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConfirmRespawn, self.OnConfirmRespawn, self)
end

return AfterConfirmRespawn
