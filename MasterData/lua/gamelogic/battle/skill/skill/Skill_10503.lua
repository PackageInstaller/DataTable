---
--- 攻击前赋予自身${Params[1]}回合的【攻击力提升】,对全体敌人造成${Params[2]}%的物理伤害,当自身攻击力大于目标攻击力时,根据差值无视目标最多${Params[3]}%的物防(${Params[4]})。
---

local Skill_10503 = BaseClass("Skill_10503",Skill)
local base = Skill

local function __init(self)

end

local function onParamsInited(self)
    base.onParamsInited(self)

    self.Data.BuffTurn = self.Params[1]
    self.Data.DamageScale = self.Params[2] / 100
    self.Data.MaxIgnoreDefPct = self.Params[3]
    self.Data.MaxcAtkDiff = self.Params[4]
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    self.__sbc:CreateBuff(BattleBuffType.AtkIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.BuffTurn)
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local atk = self.__snc:Get(NumericType.Atk)

    local damageScale = self.Data.DamageScale
    local targetAtk = targetUnit:GetComponent("NumericComponent"):Get(NumericType.Atk)
    local selfAtk = self.__snc:Get(NumericType.Atk)
    if targetAtk < selfAtk then
        result.ExtraIgnoreDef = result.ExtraIgnoreDef + self.Data.MaxIgnoreDefPct * math.min((selfAtk - targetAtk) / self.Data.MaxcAtkDiff, 1)
    end

    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    return result
end

Skill_10503.__init = __init
Skill_10503.onParamsInited = onParamsInited
Skill_10503.OnUseActiveSkill = OnUseActiveSkill
Skill_10503.OnAtkStart = OnAtkStart

return Skill_10503