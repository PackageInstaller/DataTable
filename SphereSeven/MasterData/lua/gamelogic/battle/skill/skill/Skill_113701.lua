---
--- 鞭挞
--- 对血量最高的前排敌人造成&{Params[1]}%物理伤害，当攻击前自身强化状态不小于&{Params[2]}个时，延长自身强化状态&{Params[3]}回合。

local Skill_113701 = BaseClass("Skill_113701", Skill)
local base = Skill

local function __init(self)
    self.Data.UseTimes = 0
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end
    
    if self.__sbc:BuffTypeCount(false) >= self.Params[2] then
        self.__sbc:IncAllBuffTurn(false, self.Params[3])
    end
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

    return result
end

Skill_113701.__init = __init
Skill_113701.OnAtkStart = OnAtkStart
Skill_113701.OnUseActiveSkill = OnUseActiveSkill

return Skill_113701