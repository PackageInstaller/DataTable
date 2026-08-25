local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseKeeperSkill, Super = System.NewClass("BEAfterUseKeeperSkill", BattleEffectServer)

function BEAfterUseKeeperSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseKeeperSkill:Dispose()
  Super.Dispose(self)
end

function BEAfterUseKeeperSkill:DoEffect()
  Super.DoEffect(self)
  local notTriggerSkills = self.battleEngine.battleDT.GetOriginalConstant("KeepSkillNotTrigger", {})
  if table.contains(notTriggerSkills, self.effectConfig.skillId) then
    return true
  end
  if not self:IsTriggerBST() then
    return true
  end
  if 1 == self.effectConfig.cmdServer:GetMemberValue("banAfterUseKeeperSkill") then
    return true
  end
  local keeperSkill = self.effectConfig.keeperSkill
  if self.effectConfig.cmdServer:HasMemberValue("AfterUseKeeperSkillAssociator2") then
    local associatorUid = self.effectConfig.cmdServer:GetMemberValue("AfterUseKeeperSkillAssociator2")
    local overrideKeeperSkill = self.battleEngine:GetObj(associatorUid)
    if overrideKeeperSkill then
      keeperSkill = overrideKeeperSkill
    end
  end
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseKeeperSkill,
    eventData = {
      skillId = self.effectConfig.skillId,
      castRoleUid = self.effectConfig.castRoleUid,
      level = self.effectConfig.level,
      cmdServer = self.effectConfig.cmdServer,
      keeperSkill = keeperSkill
    }
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  return true
end

function BEAfterUseKeeperSkill:EffectEnd()
  Super.EffectEnd(self)
  if self.effectConfig.keeperSkill then
    self.effectConfig.keeperSkill:ClearCmdServerStats()
  end
  local cmdServer = self.effectConfig.cmdServer
  if cmdServer and 1 == cmdServer:GetMemberValue("HandKeeperClearCurCard") then
    self.battleEngine:SetCurCard(nil)
    cmdServer:SetMemberValue("HandKeeperClearCurCard", nil)
  end
end

return BEAfterUseKeeperSkill
