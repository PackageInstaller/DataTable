---
--- 恶翼振翅
--- 对全体敌人造成&{Params[1]}%法术伤害，赋予自身最大生命值&{Params[2]}%的【物理护盾】和【速度提升】&{Params[3]}回合。当攻击前自身强化状态不小于&{Params[4]}个时，获得&{Params[5]}%额外倍率，额外解除&{Params[6]}个异常状态,使自身所有技能冷却时间-&{Params[7]}。
---

local Skill_113714 = BaseClass("Skill_113714", Skill)
local base = Skill

local function __init(self)
    self.Data.TriggeredExtraEffect = false

    self.Data.DamageMultiplier = self.Params[1]
    self.Data.ShieldMultiplier = self.Params[2]
    self.Data.AddBuffTurn = self.Params[3]
    self.Data.ExtraEffectBuffCount = self.Params[4]
    self.Data.ExtraBuffRemoveCount = self.Params[5]
    self.Data.ExtraDamageMultiplier = self.Params[6]
    self.Data.ExtraCoolDownReduce = self.Params[7]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.Data.TriggeredExtraEffect = true
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    if self.__sbc:BuffTypeCount(false) >= self.Data.ExtraEffectBuffCount then
        self.Data.TriggeredExtraEffect = true
    end

    local result = ActiveSkillResult.New()
    local damageScale = self.Data.DamageMultiplier / 100

    if self.Data.TriggeredExtraEffect then
        damageScale = damageScale + self.Data.ExtraDamageMultiplier / 100
    end

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Magic,
        Value = damageNum
    }

    return result
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    local shieldValue = self.__snc:Get(NumericType.MaxHp) * self.Data.ShieldMultiplier / 100
    self.__sbc:CreateBuff(BattleBuffType.PhyShield, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.AddBuffTurn, nil, nil, nil, nil, { ShieldValue = shieldValue })
    self.__sbc:CreateBuff(BattleBuffType.SpeedIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.AddBuffTurn)

    if self.Data.TriggeredExtraEffect then
        local enemies = self:__get_enemy_all()
        table.walk(enemies, 
            function(key, unit)
                if not unit:GetComponent("CharacterComponent").IsDead then
                    local buffComponent = unit:GetComponent("BuffComponent")
                    local buffs = buffComponent:RandomGetBuff(false, self.Data.ExtraBuffRemoveCount)
                    for _, buff in pairs(buffs) do
                        buffComponent:RemoveOneBuff(buff)
                    end
                end
            end)
    end

end

local function OnActEnd(self)
    base.OnActEnd(self)

    if not self.__bc.CurActSkill == self then
        return
    end

    if self.Data.TriggeredExtraEffect then
        for id, skill in pairs(self.SrcUnit:GetComponent("SkillComponent").ActiveSkills) do
            skill:ReduceCoolDownTurn(self.Data.ExtraCoolDownReduce)
        end
    end

    self.Data.TriggeredExtraEffect = false
end

Skill_113714.__init = __init
Skill_113714.OnBattleStart = OnBattleStart
Skill_113714.OnUseActiveSkill = OnUseActiveSkill
Skill_113714.OnAtkEnd = OnAtkEnd
Skill_113714.OnActEnd = OnActEnd

return Skill_113714