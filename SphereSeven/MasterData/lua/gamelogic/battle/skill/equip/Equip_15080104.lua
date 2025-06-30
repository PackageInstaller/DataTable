---
--- 攻击时，根据自身速攻值与目标速攻值的差值，攻击力提高最多${Params[1]}%
---

local Equip_15080104 = BaseClass("Equip_15080104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    local rate = math.max((BATTLE_ACT_VALUE_MAX - targetUnit:GetComponent("BattleUnitComponent").ActValue) / BATTLE_ACT_VALUE_MAX, 0)
    self.__subc:IncTempNumeric(NumericType.AtkPct, self.Params[1] * rate)
end


Equip_15080104.__init = __init
Equip_15080104.BeforeSkillEffect = BeforeSkillEffect

return Equip_15080104