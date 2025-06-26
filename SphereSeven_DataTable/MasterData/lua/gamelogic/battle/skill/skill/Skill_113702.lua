---
--- 恶翼振翅
--- 对全体敌人造成&{Params[1]}%法术伤害，赋予自身最大生命值&{Params[2]}%的【物理护盾】&{Params[3]}回合。当攻击前自身强化状态不小于&{Params[4]}个时，额外解除&{Params[5]}个异常状态。

local Skill_113702 = BaseClass("Skill_113702", Skill)
local base = Skill

local function __init(self)
    self.Data.UseTimes = 0
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end
    
    if self.__sbc:BuffTypeCount(false) >= self.Params[4] then
        local buffs = self.__sbc:RandomGetBuff(true, self.Params[5])
        for _, buff in pairs(buffs) do
            self.__sbc:RemoveOneBuff(buff)
        end
    end
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)


    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

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

    local shieldValue = self.__snc:Get(NumericType.MaxHp) * self.Params[2] / 100
    self.__sbc:CreateBuff(BattleBuffType.PhyShield, nil, self.SrcUnit, self.SrcUnit, self.Params[3], nil, nil, nil, nil, { ShieldValue = shieldValue })
end

Skill_113702.__init = __init
Skill_113702.OnAtkStart = OnAtkStart
Skill_113702.OnUseActiveSkill = OnUseActiveSkill
Skill_113702.OnAtkEnd = OnAtkEnd

return Skill_113702