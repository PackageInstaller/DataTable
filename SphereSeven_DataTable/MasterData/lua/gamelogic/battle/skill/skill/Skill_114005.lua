---
--- 震天劈
--- 对全体敌人造成${Params[1]}%物理伤害。在自身回合外使用时，附加攻击力${Params[2]}%的额外伤害。

local Skill_114005 = BaseClass("Skill_114005", Skill)
local base = Skill

local function __init(self)
    self.Data.thisTurnBeHurt = false
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    if self.__bc.CurTurnUnit ~= self.SrcUnit then
        result.ExtraDamage = atk * self.Params[2] / 100
    end

    return result
end


Skill_114005.__init = __init
Skill_114005.OnUseActiveSkill = OnUseActiveSkill

return Skill_114005