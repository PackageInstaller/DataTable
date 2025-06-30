---
--- 攻击提升 攻击力提升50%
---
local Buff_20004 = BaseClass("Buff_20004",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.SpeedPct,30)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.SpeedPct,30)
    base.OnRemoved(self)
end

Buff_20004.OnOccur = OnOccur
Buff_20004.OnRemoved = OnRemoved

return Buff_20004