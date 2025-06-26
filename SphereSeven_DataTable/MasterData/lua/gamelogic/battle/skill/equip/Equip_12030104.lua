---
--- 暴击时，最终伤害提升${Params[1]}%
---
local Equip_12030104 = BaseClass("Equip_12030104", Skill)
local base = Skill

local function __init(self)
end

local function OnCri(self, targetUnit, activeSkillResult)
    base.OnCri(self, targetUnit, activeSkillResult)
    activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
end

Equip_12030104.__init = __init
Equip_12030104.OnCri = OnCri

return Equip_12030104