---
--- 炎爪
--- 对血量最高的前排敌人造成&{Params[1]}%物理伤害，解除自身一个弱化状态并击退其&{Params[2]}%的行动值。当并非在战斗中第一次使用，且攻击前自身的异常状态数量不多于&{Params[3]}%个时，对同一列后排造成等量伤害，并额外使用1次。
---

local Skill_111813 = BaseClass("Skill_111813", Skill)
local base = Skill

local function __init(self)
    self.Data.UseTimes = 0
    self.Data.ExtraEffect = false
end

local function OnAtkStart(self)
    if self.__bc.CurActSkill ~= self then
        return
    end

    self.Data.UseTimes = self.Data.UseTimes + 1

    self.Data.ExtraEffect = self.__sbc:BuffTypeCount(true) <= self.Params[3]

    self.__sbc:RandomRemoveOneBuff(false)
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)


    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    result.ActChange = result.ActChange - self.Params[2]

    return result
end


local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if self.__bc.CurActSkill ~= self or self.Data.ExtraEffect then
        return
    end

    local smc = targetUnit:GetComponent("SsUnitMatrixComponent")

    local extraTargets = self.__bc:GetLineUnits(smc.Group, smc.Line)

    for k, extraTarget in pairs(extraTargets) do
        if not extraTarget:GetComponent("CharacterComponent").IsDead and extraTarget ~= targetUnit then
            local damageData = DamageData.New(activeSkillResult.TotalDamage, BattleDamageType.Universal)
            extraTarget:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
        end
    end

    local enemies = self:__get_enemy_all()
    local extraSkillTarget = BattleUtil.GetExtremeAttrTarget(enemies, NumericType.Hp, true)
    if extraSkillTarget then
        self.__subc.ExtraSkill = self
        self.__subc.ExtraSkillTarget = extraSkillTarget
    end

    self.Data.ExtraEffect = false
end

Skill_111813.__init = __init
Skill_111813.OnAtkStart = OnAtkStart
Skill_111813.OnUseActiveSkill = OnUseActiveSkill
Skill_111813.AfterOneTargetAllHit = AfterOneTargetAllHit

return Skill_111813