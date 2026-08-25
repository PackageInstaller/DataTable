local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterUseBloodRecoverSkill, Super = System.NewClass("BSTAfterUseBloodRecoverSkill", BattleStateTriggerServer)

function BSTAfterUseBloodRecoverSkill:OnUseBloodRecoverSkill(eventData)
  self.battleEngine:InfoS("BSTAfterUseBloodRecoverSkill:OnUseBloodRecoverSkill")
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  local cmdServer = self.battleEngine:GetObj(eventData.cmdServerUid)
  local bloodHealSkillId = self.battleEngine.battleDT.GetConstant("BloodHealSkill")
  if not cmdServer or cmdServer.skillConfigId ~= bloodHealSkillId then
    self.battleEngine:InfoS("BSTAfterUseBloodRecoverSkill:OnUseBloodRecoverSkill {curCmdSkillId} {bloodHealSkillId}", cmdServer and cmdServer.skillConfigId, bloodHealSkillId)
    return
  end
  if not cmdServer:IsTriggerBST() then
    return
  end
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self.battleEngine:InfoS("BSTAfterUseBloodRecoverSkill:OnUseBloodRecoverSkill {eventData}", eventData)
  local triggerData = {
    associator = {castRole},
    triggerValue = eventData.heal
  }
  self:Trigger(triggerData)
end

function BSTAfterUseBloodRecoverSkill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeHeal, self.OnUseBloodRecoverSkill, self)
end

return BSTAfterUseBloodRecoverSkill
