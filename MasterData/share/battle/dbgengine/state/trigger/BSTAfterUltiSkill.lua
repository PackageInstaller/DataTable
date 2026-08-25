local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterUltiSkill, Super = System.NewClass("BSTAfterUltiSkill", BattleStateTriggerServer)

function BSTAfterUltiSkill:AfterUseUltiSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if not castRole:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("触发使用狂气爆发后失败：找不到唤醒体", self.state.stateId, eventData.castRoleUid)
    return
  end
  local cmdServer = eventData.cmdServer
  local upperTargets = cmdServer:GetUpperTargets()
  local triggerData = {
    associator = {castRole},
    associator2 = upperTargets,
    triggerValue = cmdServer.cmdParser:GetMemberValue("UltiEnergyCost") or 0
  }
  self:Trigger(triggerData)
end

function BSTAfterUltiSkill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseUltiSkill, self.AfterUseUltiSkill, self)
end

return BSTAfterUltiSkill
