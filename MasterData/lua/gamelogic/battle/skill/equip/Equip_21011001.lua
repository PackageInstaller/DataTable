---
--- 自身所有攻击必定暴击。暴击率根据${Params[1]}:{Params[2]}的比率转化为暴击伤害,根据${Params[3]}:{Params[4]}的比例转化为攻击力。

---

local Equip_21011001 = BaseClass("Equip_21011001", Skill)
local base = Skill

local function __init(self)
    self.Data.CriDamageChangeRate = self.Params[1] / self.Params[2]
    self.Data.AtkChangeRate = self.Params[3] / self.Params[4]
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    local cri = self.__snc:Get(NumericType.Cri)

    self.__subc:IncTempNumeric(NumericType.CriDamageAdd, cri * self.Data.CriDamageChangeRate)
    self.__subc:IncTempNumeric(NumericType.AtkAdd, cri * self.Data.AtkChangeRate)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    activeSkillResult.IsMustCri = true
end

Equip_21011001.__init = __init
Equip_21011001.BeforeSkillEffect = BeforeSkillEffect
Equip_21011001.BeforeHit = BeforeHit

return Equip_21011001