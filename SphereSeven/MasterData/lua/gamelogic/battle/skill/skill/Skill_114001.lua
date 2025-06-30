---
--- 震天劈
--- 对全体敌人造成${Params[1]}%物理伤害。在自身回合外使用时，附加攻击力${Params[2]}%的额外伤害。

local Skill_114001 = BaseClass("Skill_114001", Skill)
local base = Skill

local function __init(self)
    self.Data.thisTurnBeHurt = false
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    if self.__bc.CurTurnUnit ~= self.SrcUnit then
        damageScale = damageScale + self.Params[2] / 100
    end

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    return result
end


Skill_114001.__init = __init
Skill_114001.OnUseActiveSkill = OnUseActiveSkill

return Skill_114001