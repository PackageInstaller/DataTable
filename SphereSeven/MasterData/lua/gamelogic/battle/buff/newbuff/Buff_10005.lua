---
--- 攻击提升 攻击力提升50%
---
local Buff_10005 = BaseClass("Buff_10031",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.MagicDefPct,60)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.MagicDefPct,60)
    base.OnRemoved(self)
end

Buff_10005.OnOccur = OnOccur
Buff_10005.OnRemoved = OnRemoved

return Buff_10005