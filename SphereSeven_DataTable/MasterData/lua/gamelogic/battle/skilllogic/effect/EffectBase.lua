local EffectBase = BaseClass("EffectBase")

local function __init(self, effectId, skill)
    self.Skill = skill
    self.Config = Z_BattleSkillEffect[effectId]
    self.SkillParamIndices = self.Config.SkillParamIndices
    self.Params = self.Config.Params

    self.ConditionList = {}
    for _, conditionId in ipairs(self.Config.ConditionIds) do
        local condition = BattleConditionManager.GenerateCondition(conditionId, skill)
        table.insert(self.ConditionList, condition)
    end
end

local function RunBase(self, skill, targetUnit, result)
    for _, condition in ipairs(self.ConditionList) do
        if not condition:Check(skill, targetUnit, result) then
            return
        end
    end

    if not self:IsTargetCorrect(targetUnit) then
        return
    end
    
    if self.Config.ProbabilityIndice ~= 0 then
        local probability = skill.Params[self.Config.ProbabilityIndice]
        if not BattleUtil.IsPctProbHit(probability) then
            Logger.BattleLog("触发概率判定失败")
            return
        end
    end
    if self.Config.ProbabilityIndice ~= 0 then
        Logger.BattleLog("触发概率判定成功")
    end

    self.BattleComponent = Game.Scene:GetComponent("BattleComponent")

    self:Run(skill, targetUnit, result)
end

local function IsTargetCorrect(self, targetUnit)
    if self.Config.TargetType == TargetType.SkillTargetEnemy then
        return targetUnit.IsPlayer ~= self.Skill.SrcUnit.IsPlayer
    elseif self.Config.TargetType == TargetType.SkillTargetFriend then
        return targetUnit.IsPlayer == self.Skill.SrcUnit.IsPlayer
    elseif self.Config.TargetType == TargetType.Self then
        return targetUnit == self.Skill.SrcUnit
    end
    return false
end

EffectBase.__init = __init
EffectBase.RunBase = RunBase
EffectBase.IsTargetCorrect = IsTargetCorrect


return EffectBase

