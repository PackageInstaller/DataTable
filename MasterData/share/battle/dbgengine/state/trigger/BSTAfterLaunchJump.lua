local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterLaunchJump, Super = System.NewClass("BSTAfterLaunchJump", BattleStateTriggerServer)

function BSTAfterLaunchJump:OnLaunchJump(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    associator = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterLaunchJump:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.LaunchJump, self.OnLaunchJump, self)
end

return BSTAfterLaunchJump
