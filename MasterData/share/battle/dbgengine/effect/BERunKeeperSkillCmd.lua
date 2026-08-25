local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERunKeeperSkillCmd, Super = System.NewClass("BERunKeeperSkillCmd", BattleEffectServer)

function BERunKeeperSkillCmd:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERunKeeperSkillCmd:Dispose()
  Super.Dispose(self)
end

function BERunKeeperSkillCmd:DoEffect()
  Super.DoEffect(self)
  if 0 == #self.targets then
    return false
  end
  self:__ReplaceAfterUseKeeperSkillAssociator2()
  self.totalEffectTimes = math.ceil(self.params[1] or 1)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BERunKeeperSkillCmd:__DoMultiEffect()
  local runTimeline = self.params[2] or 0
  local afterEffect = self.params[3] or 0
  for i, target in ipairs(self.targets) do
    local targetEffectConfig = {
      effectType = bc.BattleEffectType.BEGenerateTargets,
      cmdServer = target:GetCmdServer(),
      targetType = target:GetCmdTarget(),
      castRoleUid = target.cmdServer.castRoleUid
    }
    self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
    if 0 == runTimeline then
      local effectType = bc.BattleEffectType.BEFunctionEffect
      local effectConfig = {
        effectType = effectType,
        func = self.SendUseKeeperSkillRecord,
        funcTarget = self,
        funcArgs = {target}
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
    local cardEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = target.cmdServer.castRoleUid,
      cmdServer = target:GetCmdServer(),
      skipTimeline = 1 == runTimeline
    }
    self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
    if 0 == afterEffect then
      self:__FireAfterUseKeeperSkill(target)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

function BERunKeeperSkillCmd:SendUseKeeperSkillRecord(target)
  local role = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  local skillId = target:GetID()
  self.battleEngine.recordMgr:OnUseKeeperSkill(role.uid, skillId)
end

function BERunKeeperSkillCmd:__FireAfterUseKeeperSkill(target)
  local cmdServer = target:GetCmdServer()
  if not self:IsTriggerBST() then
    return
  end
  local skillId = target:GetID()
  local castRoleUid = target.cmdServer.castRoleUid
  local eventData = {
    skillId = skillId,
    castRoleUid = castRoleUid,
    level = 1,
    cmdServer = cmdServer,
    keeperSkill = target
  }
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseKeeperSkill,
    eventData = eventData
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
end

function BERunKeeperSkillCmd:__ReplaceAfterUseKeeperSkillAssociator2()
  local parentCmdServer = self.effectConfig.cmdServer
  local firstKeeperSkill = self.targets[1]
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local chaosType2SkillId = player:GetChaosType2Skill()
  local chaosType2Skill2Id = player:GetChaosType2Skill2()
  local parentSkillId = parentCmdServer.skillConfigId
  if parentSkillId ~= chaosType2SkillId and parentSkillId ~= chaosType2Skill2Id then
    return
  end
  parentCmdServer:SetMemberValue("AfterUseKeeperSkillAssociator2", firstKeeperSkill.uid)
end

return BERunKeeperSkillCmd
