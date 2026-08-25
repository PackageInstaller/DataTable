local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEAttachPostAction, Super = System.NewClass("BEAttachPostAction", BattleEffectServer)

function BEAttachPostAction:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAttachPostAction:Dispose()
  Super.Dispose(self)
end

function BEAttachPostAction:PreTrigger(triggerData)
  if not triggerData and self.cmdServer then
    triggerData = self.cmdServer.triggerData
  end
  self.parentEffectUid = self.battleEngine.effectMgr:GetRootEffectUid()
  self.preTriggerTime = self.battleEngine:GetCurPassTime()
  self.triggerData = triggerData
  self:AppendToParentEffect()
end

function BEAttachPostAction:DoEffect()
  local skillTid = self.params[1]
  local useTimes = self.params[2] or 1
  local DT = self.battleEngine.battleDT
  local skillCfg = DT.Skill[skillTid]
  if not skillCfg then
    self.battleEngine.logger:WarningS("BEAttachPostAction {skillTid} no config", skillTid)
    return false
  end
  local casters = self.targets
  if not casters then
    self.battleEngine.logger:WarningS("BEAttachPostAction no targets {skillTid}", skillTid)
    return false
  end
  self.totalEffectTimes = useTimes
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, "BEAttachPostAction no targets {skillTid}", skillTid
end

function BEAttachPostAction:__DoMultiEffect()
  local skillTid = self.params[1]
  local skillLevel = self.params[5] or 1
  skillLevel = math.max(skillLevel, 1)
  local isTriggerBST = self.params[3] or 0
  local isPerform = self.params[4] or 0
  local DT = self.battleEngine.battleDT
  local skillCfg = DT.Skill[skillTid]
  local casters = self.targets
  local producer = self.battleEngine.roleMgr:GetCurCaster()
  if not producer then
    self.battleEngine.logger:WarningS("BEAttachPostAction no producer {skillTid}", skillTid)
    return false
  end
  local attachPostParam = {
    isTriggerBST = 1 == isTriggerBST
  }
  for _, caster in ipairs(casters) do
    if caster:GetProperty(bc.BattleProperty.seal_attachpost) > 0 then
    else
      self.battleEngine.recordMgr:OnAttachPostAction(producer.uid, caster.uid, skillTid, isPerform)
      local skillType = skillCfg.Type
      if table.contains(skillType, bc.SkillType.Ulti_Skill) then
        caster:CreateSkillEffect(skillTid, skillLevel, nil, nil, nil, attachPostParam)
      elseif table.contains(skillType, bc.SkillType.Keeper_Skill) then
        caster:CreateSkillEffect(skillTid, skillLevel, nil, nil, nil, attachPostParam)
      elseif caster:IsRoleType(bc.RoleType.Monster) then
        caster.monsterBehaviorComp:ActByAttachPost(skillTid, attachPostParam)
      else
        caster:UseAttachPostCard(skillTid, skillLevel, attachPostParam)
      end
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEAttachPostAction
