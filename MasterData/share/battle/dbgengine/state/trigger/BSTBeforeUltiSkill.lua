local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTBeforeUltiSkill, Super = System.NewClass("BSTBeforeUltiSkill", BattleStateTriggerServer)

function BSTBeforeUltiSkill:BeforeUseUltiSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if not castRole:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("触发使用狂气爆发前失败：找不到唤醒体", self.state.stateId, eventData.castRoleUid)
    return
  end
  local cmdServer = eventData.cmdServer
  local upperTargets = cmdServer:GetUpperTargets() or {}
  local triggerData = {
    associator = {castRole},
    associator2 = upperTargets,
    triggerValue = cmdServer.cmdParser:GetMemberValue("UltiEnergyCost") or 0
  }
  self:Trigger(triggerData)
end

function BSTBeforeUltiSkill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseUltiSkill, self.BeforeUseUltiSkill, self)
end

return BSTBeforeUltiSkill
