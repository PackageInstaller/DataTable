---
--- 暴击后，减少目标的速攻值${Params[1]}
---
local Equip_12040004 = BaseClass("Equip_12040004", Skill)
local base = Skill

local function __init(self)
end

local function OnCri(self, targetUnit, activeSkillResult)
    base.OnCri(self)

    activeSkillResult.ActChange = activeSkillResult.ActChange - self.Params[1]
end


Equip_12040004.__init = __init
Equip_12040004.OnCri = OnCri

return Equip_12040004