---
--- 闪电吐息
--- 对全体敌人造成&{Params[1]}%法术伤害，攻击后赋予自身&{Params[2]}回合【攻击力提升】，【物防提升】。当攻击前自身处于强化状态不小于&{Params[3]}个时，获得&{Params[4]}%额外倍率，必定暴击。当强化状态不小于&{Params[5]}个时，重置此技能冷却时间。
---

local Skill_113715 = BaseClass("Skill_113715", Skill)
local base = Skill

Skill_113715.SkillLightningBreath = true

local function __init(self)
    self.Data.UseTimes = 0

    self.Data.DamageMultiplier = self.Params[1]
    self.Data.AddBuffTurn = self.Params[2]
    self.ExtraDamageMultiplierBuffCount = self.Params[3]
    self.ExtraDamageMultiplier = self.Params[4]
    self.ResetCoolDownBuffCount = self.Params[5]
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end
    
    if self.__sbc:BuffTypeCount(false) >= self.Params[3] then
        self.__sbc:IncAllBuffTurn(false, self.Params[4])
    end
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Data.DamageMultiplier / 100

    local buffCount = self.__sbc:BuffTypeCount(false)
    if buffCount >= self.ExtraDamageMultiplierBuffCount then
        damageScale = damageScale + self.ExtraDamageMultiplier / 100
        result.IsMustCri = true
    end

    if buffCount >= self.ResetCoolDownBuffCount then
        self.DoNotCd = true
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

    self.__sbc:CreateBuff(BattleBuffType.AtkIncrease, nil, self.SrcUnit, self.SrcUnit, self.Data.AddBuffTurn)
    self.__sbc:CreateBuff(BattleBuffType.DefIncrease, nil, self.SrcUnit, self.SrcUnit, self.Data.AddBuffTurn)
end

Skill_113715.__init = __init
Skill_113715.OnAtkStart = OnAtkStart
Skill_113715.OnUseActiveSkill = OnUseActiveSkill
Skill_113715.OnAtkEnd = OnAtkEnd

return Skill_113715