---
--- 对单名敌人造成${Params[1]}%物理伤害。如果暴击，则造成${Params[2]}回合的【中毒】。
---
---
local  Skill_10101 = BaseClass("Skill_10101",Skill)

local function __init(self)
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

    return result
end

local function OnHit(self, activeSkillResult, targetUnit)
    if self.__bc.CurActSkill ~= self then
        return
    end

    if activeSkillResult.IsCri then
        table.insert(activeSkillResult.Buffs, ActiveSkillBuff.New(BattleBuffType.Poison, self.Params[2]))
    end
end

Skill_10101.__init = __init
Skill_10101.OnUseActiveSkill = OnUseActiveSkill
Skill_10101.OnHit = OnHit

return Skill_10101