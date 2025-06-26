---
--- 攻击提升 攻击力提升50%
---
local Buff_20003 = BaseClass("Buff_20003",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.MagicDefPct,70)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.MagicDefPct,70)
    base.OnRemoved(self)
end

Buff_20003.OnOccur = OnOccur
Buff_20003.OnRemoved = OnRemoved

return Buff_20003