---
--- 大天使的聖潔
--- 解除所有的友軍所有異常状態,對其造成${Params[1]}%攻撃的治癒效攻果;每解除一個異常状態,額外獲得${Params[2]}%的倍率

local Skill_10353 = BaseClass("Skill_10353",Skill)

local function __init(self)
    self.Data.HealScale = self.Params[1] / 100
    self.Data.ExtraHealScale = self.Params[2] / 100
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()

    local healScale = self.Data.HealScale

    local debuffs = targetUnit:GetComponent("BuffComponent"):GetAllBuff(true, false)

    healScale = healScale + table.count(debuffs) * self.Data.ExtraHealScale
    result.HealHp = self.__snc:Get(NumericType.Atk) * self.Data.HealScale
    result.RemoveBuffs = debuffs

    return result
end


Skill_10353.__init = __init
Skill_10353.OnUseActiveSkill = OnUseActiveSkill

return Skill_10353