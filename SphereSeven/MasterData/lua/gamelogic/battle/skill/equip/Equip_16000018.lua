---
--- 效果命中提升${Params[1]}%，速度提升${Params[2]}%
---

local Equip_16000018 = BaseClass("Equip_16000018", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.EAccAdd, self.Params[1])
    self.__snc:Inc(NumericType.SpeedPct, self.Params[2])
end

Equip_16000018.__init = __init
Equip_16000018.OnBattleStart = OnBattleStart

return Equip_16000018