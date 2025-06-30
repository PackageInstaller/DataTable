---
--- 攻击提升${Params[1]}%
---

local Equip_16000003 = BaseClass("Equip_16000003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
end

Equip_16000003.__init = __init
Equip_16000003.OnBattleStart = OnBattleStart

return Equip_16000003