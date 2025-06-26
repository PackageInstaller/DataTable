---
--- 生命提升${Params[1]}%，物防提升${Params[2]}%
---

local Equip_16000033 = BaseClass("Equip_16000033", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
    self.__snc:Inc(NumericType.DefPct, self.Params[2])
end

Equip_16000033.__init = __init
Equip_16000033.OnBattleStart = OnBattleStart

return Equip_16000033