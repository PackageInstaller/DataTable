---
--- 生命提升${Params[1]}%，速度提升${Params[2]}%
---

local Equip_16000023 = BaseClass("Equip_16000023", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
    self.__snc:Inc(NumericType.SpeedPct, self.Params[2])
end

Equip_16000023.__init = __init
Equip_16000023.OnBattleStart = OnBattleStart

return Equip_16000023