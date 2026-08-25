local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterRoleRespawn, _ = System.NewClass("BSTAfterRoleRespawn", BattleStateTriggerServer)

function BSTAfterRoleRespawn:OnRoleAfterRebirth(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    associator2 = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterRoleRespawn:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterRebirth, self.OnRoleAfterRebirth, self)
end

return BSTAfterRoleRespawn
