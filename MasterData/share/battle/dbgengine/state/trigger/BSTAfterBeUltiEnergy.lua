local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterBeUltiEnergy, Super = System.NewClass("BSTAfterBeUltiEnergy", BattleStateTriggerServer)

function BSTAfterBeUltiEnergy:OnBeUltiEnergy(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if not targetRole:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("受到狂气后触发失败，找不到目标唤醒体", eventData.targetRoleUid)
    return
  end
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("受到狂气后触发失败，找不到施法者", eventData.castRoleUid)
    return
  end
  local associator = castRole
  local triggerData = {
    castRoleUid = eventData.castRoleUid,
    triggerValue = eventData.castValue,
    associator = {associator},
    associator2 = {targetRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterBeUltiEnergy:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeUltiEnergy, self.OnBeUltiEnergy, self)
end

return BSTAfterBeUltiEnergy
