---
--- 闪电吐息
--- 对全体敌人造成&{Params[1]}%法术伤害，攻击后赋予自身&{Params[2]}回合【攻击力提升】，【物防提升】。当攻击前自身处于强化状态不小于&{Params[3]}个时，获得&{Params[4]}%额外倍率，暴击率提升&{Params[5]}%
---

local Skill_113711 = BaseClass("Skill_113711", Skill)
local base = Skill

Skill_113711.SkillLightningBreath = true

local function __init(self)
    self.Data.UseTimes = 0

    self.Data.DamageMultiplier = self.Params[1]
    self.Data.AddBuffTurn = self.Params[2]
    self.ExtraDamageMultiplierBuffCount = self.Params[3]
    self.ExtraDamageMultiplier = self.Params[4]
    self.ExtraCriAdd = self.Params[5]
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

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    local buffCount = self.__sbc:BuffTypeCount(false)
    if buffCount >= self.ExtraDamageMultiplierBuffCount then
        self.__subc:IncTempNumeric(NumericType.CriAdd, self.ExtraCriAdd)
    end
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Data.DamageMultiplier / 100

    local buffCount = self.__sbc:BuffTypeCount(false)
    if buffCount >= self.ExtraDamageMultiplierBuffCount then
        damageScale = damageScale + self.ExtraDamageMultiplier / 100
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

Skill_113711.__init = __init
Skill_113711.OnAtkStart = OnAtkStart
Skill_113711.BeforeSkillEffect = BeforeSkillEffect
Skill_113711.OnUseActiveSkill = OnUseActiveSkill
Skill_113711.OnAtkEnd = OnAtkEnd

return Skill_113711