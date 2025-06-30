---
--- 震天劈
--- 对全体敌人造成${Params[1]}%物理伤害，附加${Params[2]}%攻击力的额外伤害。在自身回合外使用时，${Params[3]}%的概率造成${Params[4]}回合的【攻击降低】
---

local Skill_114009 = BaseClass("Skill_114009", Skill)
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

    result.ExtraDamage = atk * self.Params[2] / 100

    if self.__bc.CurTurnUnit ~= self.SrcUnit 
        and BattleUtil.IsPctProbHit(self.Params[3]) then

        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.AtkDecrease, self.Params[4]))
    end


    return result
end


Skill_114009.__init = __init
Skill_114009.OnUseActiveSkill = OnUseActiveSkill

return Skill_114009